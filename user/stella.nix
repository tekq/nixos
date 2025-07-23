{ config, pkgs, lib, inputs, ...}:

{
  home.username = "stella";
  home.homeDirectory = "/home/stella";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    unzip
    zip
    vim
    tidal-hifi
    galaxy-buds-client
    qbittorrent
    mpv
    element-desktop
    easyeffects
    eog

    godotPackages_4_3.godot
    unityhub
    # jetbrains.rider
    # jetbrains.idea-ultimate
    (jetbrains.rider.override {
     jdk = pkgs.openjdk21;
    })
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
    shadps4
    oversteer

    vial
    i2c-tools

    htop
  ];

  programs.zen-browser = {
    enable = true;

    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
  };

  programs.nixcord = {
    enable = true;
    discord.enable = true;
    vesktop.enable = false;
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
	fhs = "steam-run bash";
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
