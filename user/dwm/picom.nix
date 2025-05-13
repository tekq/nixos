{ config, pkgs, lib, ... }:

{
  nixpkgs = {
    overlays = [
      (final: prev: {
        picom = prev.picom.overrideAttrs (oldattrs: {
          src = fetchGit {
            url = "https://github.com/jonaburg/picom.git";
            rev = "65ad706ab8e1d1a8f302624039431950f6d4fb89";
          };
          nativeBuildInputs = (oldattrs.nativeBuildInputs or []) ++ [ pkgs.asciidoc ];

          buildInputs = (oldattrs.buildInputs or []) ++ [ pkgs.pcre ];

          installCheckPhase = ''
            echo "--- Running custom installCheckPhase, version check should be skipped ---"
            # We don't want to run the original check, so just echo and exit
          '';
        });
      })
    ]; 
  };

  environment.systemPackages = [
    pkgs.picom
  ];
}
