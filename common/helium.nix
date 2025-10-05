{ pkgs, stdenv, lib, appimageTools, fetchurl }:

let
  pname = "helium-browser";
  version = "0.5.2.1";
  
  src = fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage"; 
    sha256 = "sha256-0fcln535wn6ffh4j9hjrwqz71y9s5ilw4lg67vzdbw3rr4q0c7fy";
  };
  
  extraPkgs = p: with p; [
    libxkbcommon
    libsecret
    libva-vdpau-driver
    mesa
  ];

in
appimageTools.wrapType2 {
  inherit pname version src;
  
  nativeBuildInputs = [ appimageTools ];
  
  extraInstallCommands = ''
    mv $out/bin/${pname} $out/bin/helium
    
    for desktopFile in $out/share/applications/*.desktop; do
        substituteInPlace $desktopFile \
          --replace-fail 'Exec=AppRun' 'Exec=helium' \
          --replace-fail 'Exec=${pname}' 'Exec=helium' || true
    done
  '';

  inherit extraPkgs;

  meta = with lib; {
    description = "Private, fast, and honest web browser based on ungoogled-chromium";
    homepage = "https://github.com/imputnet/helium";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
