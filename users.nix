{ config, pkgs, ... }

{
  users.users = {
    root = {
      hashedPasswordFile = config.sops.secrets.my-password.path;
    };

    lexi = {
      hashedPasswordFile = config.sops.secrets.my-password.path;
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.zsh;
    };
  };
}
