{ config, pkgs, lib,  ... }:

{
  home.username = "lexi";
  home.homeDirectory = "/home/lexi";

  #home-manager.users.lexi = {

  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
        firefox-wayland
	chrome-gnome-shell
        hyfetch
	gnome-console
        gnome-tweaks
	nautilus
	tidal-hifi
	discord
        git
        curl
        wget
	unzip 
	zip

	# Themes
	adw-gtk3
	morewaita-icon-theme
	(nerdfonts.override { fonts = [ "Hack" ]; })
	lato

        # Rust Replacements
        bat
        eza
        fd
        procs
        ripgrep
        sd
        tokei
	bottom

	# Tools
	gh
	eog
	tldr
	cachix
	android-tools
	oversteer	
	gnome-calculator
	libreoffice
	age
	transmission-gtk

	# Gaming
	heroic
	protonup-qt

        # Shell
        starship

        # IDEs
        jetbrains.clion
	jetbrains.rider
	jetbrains.pycharm-professional
	unityhub

	# py
	python313Full

	# Node
	nodejs_18 # probs required for GH Copilot in JB

        # C++
        clang
        gnumake
        cmake
        
	# Rust
        rustup
  ];	

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
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
	neofetch = "hyfetch";
    };

    oh-my-zsh = {
    	enable = true;
	plugins = [ "git" "systemd" "z" ];
    };

    initExtra = ''
    	eval "$(starship init zsh)"
    '';
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  #};
}
