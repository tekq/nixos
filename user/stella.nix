{ config, pkgs, lib, ...}:

{
  home.username = "stella";
  home.homeDirectory = "/home/stella";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ungoogled-chromium
    nemo
    tidal-hifi
    unzip
    zip
    vim
    tutanota-desktop
    galaxy-buds-client
    qbittorrent
    mpv
    element-desktop
    bubblewrap
    fuse-overlayfs
    dwarfs

    # unityhub
    # jetbrains.rider
    jetbrains.idea-ultimate
    devenv
    gh
    git-lfs

    starship

    bat
    eza
    fd
    procs
    ripgrep
    sd
    tokei

    prismlauncher
    rpcs3

    qmk
    via
    vial

    neofetch
    pavucontrol

    htop

    # dwm
    polybar
    alacritty
    dunst
    nitrogen
    rofi
    alsa-utils
    maim
    xclip

    (slstatus.override {
      conf = ./dwm/slstatus.h;
    })

    # dwl
    grim
    slurp
    wofi
    wlr-randr
    waybar
    wbg
  ];

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
      #package = pkgs.kora-icon-theme;   
      #name = "Kora";
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
	if [[ -z "$DISPLAY" && "$TTY" == "/dev/tty1" ]]
	then
    		exec dwl
	fi
    '';
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  home.stateVersion = "24.11";
}
