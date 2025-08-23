{
  virtualisation.libvirtd.enable = true;
  users.extraUsers.youruser.extraGroups = [ "libvirtd" ];

  boot.extraModprobeConfig = ''
    options kvm_amd nested=1
    options kvm ignore_msrs=1 report_ignored_msrs=0
  '';
}
