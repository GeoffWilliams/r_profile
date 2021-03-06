# @summary Manage Linux system limits using saz/limits
#
# @see https://forge.puppet.com/saz/limits/
#
# @example hiera data to enable purging unmanaged rules
#   r_profile::linux::limits::purge: true
#
# @example hiera data to set limits
#   r_profile::linux::limits::settings:
#     '*/nofile':
#       hard: 1048576
#       soft: 1048576
#     '*/memlock':
#       both: unlimited
#
# @param purge True to remove unmanaged entries otherwise false
# @param settings Hash of limits settings to make
class r_profile::linux::limits(
    Boolean $purge    = false,
    Hash    $settings = {},
) {
  class { 'limits':
    purge_limits_d_dir => $purge,
    entries            => $settings,
  }

}
