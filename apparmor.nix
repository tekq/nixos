{ pkgs, ... }:

{
  security.apparmor.packages = [ pkgs.apparmor-d ];
  security.apparmor.enable = true;

  security.apparmor.includes = {
    "abstractions/base" = ''
      /nix/store/*/bin/** mr,
      /nix/store/*/lib/** mr,
      /nix/store/** r,
      ${getExe' pkgs.coreutils "coreutils"} rix,
      ${getExe' pkgs.coreutils-full "coreutils"} rix,
    '';
  };
}
