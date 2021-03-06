# @summary Configure filesystem mounts using the puppet
#
# @see https://puppet.com/docs/puppet/5.5/types/mount.html
#
# @example mounting a partition on `/opt`
#   r_profile::mount::mount:
#     '/opt':
#       ensure: mounted
#       atboot: true
#       options: 'nodev'
#       device: '/dev/sdc1'
#       fstype: ext4
#
# @param mounts hash of mounts to mount
# @param default_mounts default hash of default mount options
class r_profile::mount(
  Hash[String, Optional[Hash]]  $mounts         = {},
  Hash[String, Optional[Hash]]  $default_mounts = {},
) {
  $mounts.each |$key, $opts| {
    mount {
      default:
        ensure => mounted,
      ;
      $key:
        * => pick($opts, {})
    }
  }
}
