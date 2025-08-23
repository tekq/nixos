let
  wallpaper = pkgs.fetchurl {
    url = "https://invent.kde.org/plasma/plasma-workspace-wallpapers/-/raw/master/Patak/contents/images_dark/3840x2160.png?ref_type=heads";
    sha256 = "033gpip4ms97zahm40s29k4nsmv34zwpyh3pczwh5fwq0zgb625l";
  };
in
{
  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri = "file://${wallpaper}";
    };
  };
}
