{config, pkgs, lib, ...}:

{
  home.username = "stella";
  home.homeDirectory = "/home/stella";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ungoogled-chromium
    gnome-console
    nautilus
    tidal-hifi
    unzip
    zip
    vim
    tutanota-desktop
    galaxy-buds-client
    qbittorrent
    mpv

    # unityhub
    # jetbrains.rider
    # jetbrains.idea-ultimate
    devenv
    gh
    git-lfs

    starship
	
    # alacritty

    bat
    eza
    fd
    procs
    ripgrep
    sd
    tokei
    bottom

    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.gsconnect    
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.desaturated-tray-icons

    prismlauncher
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "gnome-ui-tune@itstime.tech"
	"gsconnect@andyholmes.github.io"
        "trayIconsReloaded@selfmade.pl"
        "desaturated-tray-icons@cr1337.github.com"
      ];
    };

    "org/gnome/desktop" = {
      "interface/monospace-font-name" = "Hack Nerd Font Mono 10";
      "input-sources/xkb-options" = "caps:swapescape";
    };
  };

  gtk = {
    enable = true;
    
    theme = { 
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };

    font = {
      package = pkgs.inter;
      name = "Inter";
    };

    iconTheme = {
      #package = pkgs.morewaita-icon-theme;   
      #name = "MoreWaita";
      package = pkgs.fluent-icon-theme;
      name = "Fluent-dark";
    };
  };

  qt.platformTheme = "gnome";

  programs.nixcord = {
    enable = true;
    discord.enable = false;
    vesktop.enable = true;
    config = {
      themeLinks = [ "https://milbits.github.io/oldcord/src/main.css" ];
      plugins = {
        noProfileThemes.enable = true;
        silentTyping.enable = true;
      };
    };
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;
    shellAliases = {
	sl = "eza --icons";
	ls = "eza --icons";
	l = "eza -l --icons";
	la = "eza -la --icons";
	"cat" = "bat";
	"grep" = "rg";
	find = "fd";
	ps = "procs";
	"sed" = "sd";
	ne = "nix-env";
	ni = "nix-env -iA";
	nu = "nix-env --uninstall";
	ns = "nix-shell --pure";
	nsp = "nix-shell -p";
    };

    oh-my-zsh = {
    	enable = true;
	plugins = [ "git" "systemd" "z" ];
    };

    initExtra = ''
    	eval "$(starship init zsh)"
    '';
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  home.stateVersion = "24.11";
}
