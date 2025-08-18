{ config, pkgs, lib, inputs, ...}:

{
  home.username = "stella";
  home.homeDirectory = "/home/stella";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    unzip
    zip
    vim
    inputs.tidaLuna.packages."x86_64-linux".default
    galaxy-buds-client
    qbittorrent
    mpv
    element-desktop
    eog
    nautilus

    godotPackages_4_3.godot-mono
    unityhub
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
    shadps4
    oversteer

    vial
    i2c-tools

    htop

    gnomeExtensions.gnome-40-ui-improvements
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
      package = pkgs.morewaita-icon-theme;   
      name = "MoreWaita";
    };
  };

  qt.platformTheme = "gnome";

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "gnome-ui-tune@itstime.tech"
	"gsconnect@andyholmes.github.io"
      ];
      "keybindings/toggle-overview" = [ "<Super>comma" ];
      "keybindings/toggle-quick-settings" = [ "<Super>period" ];
    };

    "org/gnome/desktop" = {
      "interface/monospace-font-name" = "Hack Nerd Font Mono 10";
      "interface/gtk-enable-primary-paste" = false;
      "wm/preferences/button-layout" = "appmenu:minimize,maximize,close";
      "wm/preferences/resize-with-right-button" = true;

      "wm/keybindings/close" = [ "<Super>slash" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      "screensaver" = [ "<Control><Super>Escape" ];

      "custom-keybindings" = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ]; 
      "custom-keybindings/custom0/binding" = "<Super>Return";
      "custom-keybindings/custom0/command" = "kgx";
      "custom-keybindings/custom0/name" = "Console";
    };
  };

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
