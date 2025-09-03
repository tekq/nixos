{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.lan-mouse_git ];
  chaotic.mesa-git.enable = true;
}
