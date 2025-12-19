{ config, pkgs, lib, inputs, ...}:

{
  imports = 
    [
      ./wallpaper.nix
    ];

  home.username = "stella";
  home.homeDirectory = "/home/stella";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    gnome-console
    nautilus
    ffmpeg
    unzip
    zip
    vim
    #inputs.tidaLuna.packages."x86_64-linux".default
    tidal-hifi
    high-tide
    galaxy-buds-client
    qbittorrent
    mpv
    eog
    bottles
    # winboat
    freerdp
    easyeffects
    rhythmbox
    tutanota-desktop
    gnome-boxes

    vscode
    godotPackages_4_3.godot-mono
    unityhub
    # jetbrains.rider
    jetbrains.idea-ultimate
    jetbrains.clion
    jetbrains.gateway
    devenv
    gh
    git-lfs
    libgcc
    gcc
    nodePackages_latest.nodejs
    nss
    github-copilot-cli

    starship

    bat
    eza
    fd
    procs
    ripgrep
    sd
    tokei

    prismlauncher
    mcpelauncher-ui-qt
    #rpcs3
    shadps4
    oversteer

    i2c-tools

    htop

    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.tailscale-qs
    gnomeExtensions.blur-my-shell
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
	"Bluetooth-Battery-Meter@maniacx.github.com"
	"tailscale@joaophi.github.com"
	"blur-my-shell@aunetx"
      ];
      "keybindings/toggle-overview" = [ "<Super>comma" ];
      "keybindings/toggle-quick-settings" = [ "<Super>period" ];
    };

    "org/gnome/desktop" = {
      "interface/monospace-font-name" = "Hack Nerd Font Mono 10";
      "interface/gtk-enable-primary-paste" = false;
      "interface/color-scheme" = "prefer-dark";

      "wm/preferences/button-layout" = "appmenu:minimize,maximize,close";
      "wm/preferences/resize-with-right-button" = true;

      "wm/keybindings/close" = [ "<Super>slash" ];

      "peripherals/mouse/accel-profile" = "flat";
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      "screensaver" = [ "<Control><Super>Escape" ];

      "custom-keybindings" = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ]; 
      "custom-keybindings/custom0/binding" = "<Super>Return";
      "custom-keybindings/custom0/command" = "kgx";
      "custom-keybindings/custom0/name" = "Console";
    };

    "org/gnome/mutter" = {
      "center-new-windows" = true;
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
      DisableFirefoxAccounts = true;

      ExtensionSettings = {
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
	"{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
	  install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
	  installation_mode = "force_installed";
	};
	"addon@fastforward.team" = {
	  install_url = "https://addons.mozilla.org/firefox/downloads/latest/fastforwardteam/latest.xpi";
	  installation_mode = "force_installed";
	};
	"addon@karakeep.app" = {
	  install_url = "https://addons.mozilla.org/firefox/downloads/latest/karakeep/latest.xpi";
	  installation_mode = "force_installed";
	};
	"{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
	  install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
	  installation_mode = "force_installed";
	};
	"uBlock0@raymondhill.net" = {
	  install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
	  installation_mode = "force_installed";
	};
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
    dotDir = "${config.home.homeDirectory}/.config/zsh";
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
