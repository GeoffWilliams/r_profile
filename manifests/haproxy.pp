# https://tickets.puppetlabs.com/browse/MODULES-3932
class r_profile::haproxy(
  $listeners        = hiera('r_profile::haproxy::listeners',undef),
  $enable_firewall  = hiera('r_profile::haproxy::enable_firewall', true),
  $frontends        = hiera('r_profile::haproxy::frontends',undef),
  $backends         = hiera('r_profile::haproxy::backends',undef),
  $admin_stats      = hiera('r_profile::haproxy::admin_stats', true),
  $nagios_monitored = hiera('r_profile::haproxy::nagios_monitored', true),
  $stats_port       = hiera('r_profile::haproxy::stats_port', '9090'),
  $stats_username   = hiera('r_profile::haproxy::stats_username', 'puppet'),
  $stats_password   = hiera('r_profile::haproxy::stats_password', 'puppet'),
) {


  include haproxy
  if $admin_stats { 
    haproxy::listen { 'stats':
      ipaddress => '0.0.0.0',
      ports     => $stats_port,
      options   => {
        'mode'  => 'http',
        'stats' => ['uri /', "auth ${stats_username}:${stats_password}"],
        },
    }
  
    if $nagios_monitored {
      nagios::nagios_service_tcp { 'haproxy_stats':
        port => $stats_port,
      }
    }

    if $enable_firewall {
      firewall { "100 nagios_stats":
        dport  => $stats_port,
        proto  => 'tcp',
        action => 'accept',
      }
    }
  }

  if $listeners {
    $listeners.each |String $listener,Hash $listener_values| {
      haproxy::listen { $listener:
        * => $listener_values,
      }

      if $enable_firewall {
        firewall { "100 ${listener}":
          dport  => [$listener_values['ports']],
          proto  => 'tcp',
          action => 'accept',
        }
      }

      if $nagios_monitored {
        nagios::nagios_service_tcp { "haproxy_${listener}":
          port => $listener_values['ports'],
        }
      } 

    }
  }

  if $frontends {
    $frontends.each |String $frontend, Hash $frontend_values| {
      haproxy::frontend { $frontend:
        * => $frontend_values,
      }

      if $enable_firewall {
        firewall { "100 ${frontend}":
          dport  => [$frontend_values['ports']],
          proto  => 'tcp',
          action => 'accept',
        }
      }
    }
  }

  if $backends {
    $backends.each |String $backend, Hash $backend_values| {
      haproxy::backend { $backend:
        * => $backend_values,
      }
    }
  }
}

