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
    discord
    unzip
    zip
    vim
    tutanota-desktop
    galaxy-buds-client
    qbittorrent

    # unityhub
    # jetbrains.rider
    # jetbrains.idea-ultimate
    # devenv
    # gh

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

    # nerd-fonts.hack
    morewaita-icon-theme
    gnomeExtensions.gnome-40-ui-improvements

    prismlauncher
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "gnome-ui-tune@itstime.tech"
      ];
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

  home.stateVersion = "24.11";
}
