{ config, pkgs, lib, ...}:

{
  home.username = "stella";
  home.homeDirectory = "/home/stella";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    firefox-esr
    unzip
    zip
    vim
    tidal-hifi
    tutanota-desktop
    galaxy-buds-client
    qbittorrent
    mpv
    element-desktop
    bubblewrap
    fuse-overlayfs
    easyeffects
    eog

    # unityhub
    jetbrains.rider
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
    vial

    htop

    discord
  ];

  programs.nixcord = {
    enable = false;
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

    initContent = ''
    	eval "$(starship init zsh)"
    '';
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  home.stateVersion = "25.05";
}
