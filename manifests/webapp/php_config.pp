# write PHP configuration file settings
# 
# Params
# ======
# `configs`
# Hash of configuration filenames and values to write:
# config_filename => {
#   owner => 'user',  # config file owner
#   group => 'group', # config file group  
#   mode  => '0640',  # config file permissions
#   notify => RES,    # resources to notify on change
#   defines   => {},  # PHP define KVPs to write in key=>value format
#   vars      => {},  # PHP variable KVPs to write in key=>value format
# }

class r_profile::webapp::php_config(
    $configs = hiera('r_profile::webapp::php_config', {}),
) {

  $configs.keys.each | $config | {
    $notify = pick($configs[$config]['notify'], false)
    if $notify {
      $_notify = $notify
    } else {
      $_notify = undef
    }


    file { $config:
      ensure  => file,
      owner   => pick($configs[$config]['owner'], 'root'),
      group   => pick($configs[$config]['group'], 'root'),
      mode    => pick($configs[$config]['mode'], '0644'),
      notify  => $_notify,
    }
    
    # defined values
    $configs[$config]['defines'].sort.each | $def | {
      file_line { "${config}_${def}":
        ensure => present,
        path   => $config,
        line   => "define( '${def}', '${configs[$config][$def]}' );",
        match  => "define( '${def}'",
        notify => $_notify,
      }
    }

    # variables
    $configs[$config]['vars'].sort.each | $v | {
      file_line { "${config}_${v}":
        ensure => present,
        path   => $config,
        line   => "\$${def} = '${configs[$config][$v]}';",
        match  => "\$${def}\s*=",
        notify => $_notify,
      }
    }
  }
}