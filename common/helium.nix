{ pkgs, lib, ... }:

let
  pname = "helium";

  version = "0.5.2.1";

  src = pkgs.fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage";

    sha256 = "sha256-3h0GMMl58NX+PuZRwmksOvlwPuZZwiQJdM5YXkaxlDk=";
  };

  appimageContents = pkgs.appimageTools.extractType2 { inherit pname version src; };
in
  pkgs.appimageTools.wrapType2 rec {
    inherit pname version src;

    pkgs = pkgs;

    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop

      install -m 444 -D ${appimageContents}/${pname}.png $out/share/icons/hicolor/512x512/apps/${pname}.png

      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Exec=AppRun %U' 'Exec=${pname} %U' \
	--replace 'Exec=AppRun' 'Exec=${pname}' \
	--replace 'Exec=AppRun --incognito' 'Exec=${pname} --incognito'
    '';

    extraBwrapArgs = [
        "--bind-try /etc/nixos/ /etc/nixos/"
    ];

    meta = with lib; {

      description = "Helium Browser";

      homepage = "https://helium.computer/";

      # license = licenses.gpl3;

      maintainers = [ ];

      platforms = [ "x86_64-linux" ];
    };

} 
