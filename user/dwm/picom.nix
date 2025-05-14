{ config, pkgs, lib, ... }:

{
  nixpkgs = {
    overlays = [
      (final: prev: {
        picom = prev.picom.overrideAttrs (oldattrs: {
          src = fetchGit {
            url = "https://github.com/ibhagwan/picom";
            rev = "c4107bb6cc17773fdc6c48bb2e475ef957513c7a";
          };
          nativeBuildInputs = (oldattrs.nativeBuildInputs or []) ++ [ pkgs.asciidoc ];

          buildInputs = (oldattrs.buildInputs or []) ++ [ pkgs.pcre ];

          installCheckPhase = ''
            echo "---Version check should be skipped ---"
          '';
        });
      })
    ]; 
  };

  environment.systemPackages = [
    pkgs.picom
  ];
}
