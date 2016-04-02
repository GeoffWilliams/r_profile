class r_profile::puppet::agent_installers(
    $install                = true,
    $install_pe_only_agents = false,
){
  if $install {  
    # Just install everything - this list can be generated with the command:
    # fgrep class  /opt/puppetlabs/puppet/modules/pe_repo/manifests/platform/*.pp -h | sed 's/class/include/g' | sed 's/(//g'

    if $install_pe_only_agents {
      include pe_repo::platform::aix_53_power
      include pe_repo::platform::aix_61_power
      include pe_repo::platform::aix_71_power
      include pe_repo::platform::el_4_i386
      include pe_repo::platform::el_4_x86_64
      include pe_repo::platform::solaris_10_i386
      include pe_repo::platform::solaris_10_sparc
      include pe_repo::platform::solaris_11_i386
      include pe_repo::platform::solaris_11_sparc
    }
    include pe_repo::platform::debian_6_amd64
    include pe_repo::platform::debian_6_i386
    include pe_repo::platform::debian_7_amd64
    include pe_repo::platform::debian_7_i386
    include pe_repo::platform::debian_8_amd64
    include pe_repo::platform::debian_8_i386
    include pe_repo::platform::el_5_i386
    include pe_repo::platform::el_5_x86_64
    include pe_repo::platform::el_6_i386
    include pe_repo::platform::el_6_x86_64
    include pe_repo::platform::el_7_x86_64
    include pe_repo::platform::fedora_21_i386
    include pe_repo::platform::fedora_21_x86_64
    # Fedora 22 doesn't seem to exist yet
    #include pe_repo::platform::fedora_22_i386
    #include pe_repo::platform::fedora_22_x86_64
    include pe_repo::platform::osx_1010_x86_64
    include pe_repo::platform::osx_109_x86_64
    include pe_repo::platform::sles_10_i386
    include pe_repo::platform::sles_10_x86_64
    include pe_repo::platform::sles_11_i386
    include pe_repo::platform::sles_11_x86_64
    include pe_repo::platform::sles_12_x86_64
    include pe_repo::platform::ubuntu_1004_amd64
    include pe_repo::platform::ubuntu_1004_i386
    include pe_repo::platform::ubuntu_1204_amd64
    include pe_repo::platform::ubuntu_1204_i386
    include pe_repo::platform::ubuntu_1404_amd64
    include pe_repo::platform::ubuntu_1404_i386
    include pe_repo::platform::ubuntu_1504_amd64
    include pe_repo::platform::ubuntu_1504_i386
    include pe_repo::platform::windows_i386
    include pe_repo::platform::windows_x86_64
  }
}