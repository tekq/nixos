{ config, pkgs, lib, inputs, ...}:

{
  home.username = "stella";
  home.homeDirectory = "/home/stella";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ffmpeg
    unzip
    zip
    vim
    inputs.tidaLuna.packages."x86_64-linux".default
    # tidal-hifi
    galaxy-buds-client
    qbittorrent
    mpv
    eog
    bottles
    easyeffects

    vscode
    godotPackages_4_3.godot-mono
    unityhub
    # jetbrains.rider
    jetbrains.idea-ultimate
    jetbrains.clion
    devenv
    gh
    git-lfs
    libgcc
    gcc
    nodePackages_latest.nodejs

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
