{ pkgs, config, ... }:
let
  wallpaper = pkgs.fetchurl {
    url = "https://512pixels.net/downloads/macos-wallpapers-6k/26-Tahoe-Dark-6K.png";
    sha256 = "1nqqa0zwhr6fda96ky0jiw5yrhp9c784ibsly09dq0hvlf2bd8l6";
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
