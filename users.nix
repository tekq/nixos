{ config, pkgs, ... }

{
  users.users = {
    root = {
      hashedPasswordFile = config.sops.secrets.my-password.path;
    };

    lexi = {
      # initialHashedPassword = "";
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.zsh;
    };
  };
}
