# R_profile::Linux::Realmd
#
# Support for setting up realmd (SSSD) for authentication against a directory server on
# RHEL 7. You are advised to use hiera-eyaml to encrypt the `ad_password` parameter when
# using this profile.
#
# @see https://forge.puppet.com/geoffwilliams/realmd
#
# @example activating the realmd profile
#   include r_profile::linux::realmd
#
# @example Hiera data for joining domain
#   r_profile::linux::realmd::domain: "megacorp.com"
#   r_profile::linux::realmd::ad_username: "ad_join"
#   r_profile::linux::realmd::ad_password: "topsecret" # plaintext password not recommended
#   r_profile::linux::realmd::ou:
#     - 'linux'
#     - 'servers'
#   r_profile::linux::realmd::groups:
#     - 'admins'
#     - 'superadmins'
#
# @example Hiera data with encrypted password
#   r_profile::linux::realmd::ad_password: >
#     ENC[PKCS7,Y22exl+OvjDe+drmik2XEeD3VQtl1uZJXFFF2NnrMXDWx0csyqLB/2NOWefv
#     NBTZfOlPvMlAesyr4bUY4I5XeVbVk38XKxeriH69EFAD4CahIZlC8lkE/uDh
#     jJGQfh052eonkungHIcuGKY/5sEbbZl/qufjAtp/ufor15VBJtsXt17tXP4y
#     l5ZP119Fwq8xiREGOL0lVvFYJz2hZc1ppPCNG5lwuLnTekXN/OazNYpf4CMd
#     /HjZFXwcXRtTlzewJLc+/gox2IfByQRhsI/AgogRfYQKocZgFb/DOZoXR7wm
#     IZGeunzwhqfmEtGiqpvJJQ5wVRdzJVpTnANBA5qxeA==]
#
# @param domain Domain to join
# @param ad_password AD password to use for joining
# @param ou Array of OUs to use for joining eg `foo,bar,baz` (OU= will be added for you)
# @param services List of services to enable for SSD/Realmd
# @param groups List of groups to add to `simple_allow_groups` (will be flattened for you)
class r_profile::linux::realmd(
    String                  $domain,
    String                  $ad_username,
    String                  $ad_password,
    Array[String]           $ou,
    Optional[Array[String]] $groups = undef,
) {
  class { "realmd":
    domain      => $domain,
    ad_username => $ad_username,
    ad_password => $ad_password,
    ou          => $ou,
    groups      => $groups,
  }
}