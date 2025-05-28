{ config, git, ... }:

{
  environment.systemPackages = [ pkgs.git ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

