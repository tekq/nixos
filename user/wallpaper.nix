{ pkgs, config, ... }:
let
  wallpaper = pkgs.fetchurl {
    url = "https://invent.kde.org/plasma/breeze/-/raw/master/wallpapers/Next/contents/images_dark/7680x2160.png";
    sha256 = "1v5sxncm9bmhzdpcqq5faikmyfb1106wxwkbxbqswwd0dgb7qxpz";
  };
in
{
  dconf.settings = {
    "org/gnome/desktop" = { 
      "background/picture-uri" = "file://${wallpaper}";
      "background/picture-uri-dark" = "file://${wallpaper}"; 
      "screensaver/picture-uri" = "file://${wallpaper}";
    };
  };
}
