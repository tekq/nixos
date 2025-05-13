{ config, pkgs, ... }:

{
  nixpkgs = {
    overlays = [
      (self: super: {
        picom = super.picom.overrideAttrs (oldattrs: {
          src = fetchGit {
            url = "https://github.com/jonaburg/picom.git";
            rev = "65ad706ab8e1d1a8f302624039431950f6d4fb89";
          }; 
        });
      })
    ]; 
  };

  environment.systemPackages = [
    pkgs.picom
  ];
}
