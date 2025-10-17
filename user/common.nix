{ config, pkgs, ... }:

{
  programs.zsh.enable = true;

  users = {
    users.stella = {
      description = "Assembly";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
      hashedPasswordFile = config.sops.secrets.stella-password.path;
    };

    groups.libvirtd.members = [ "stella" ];

    extraGroups.docker.members = [ "stella" ];
  };

  home-manager.backupFileExtension = "backup";

  xdg.autostart.enable = true;
}
