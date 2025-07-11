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
  };

  xdg.autostart.enable = true;
}
