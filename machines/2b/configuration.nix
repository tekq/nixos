{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "max";
    };

    # timeout = 0;

    efi.canTouchEfiVariables = true;
  };

  services.scx.enable = true;

  networking.hostName = "2B";
  networking.networkmanager.enable = true;
  networking.hostId = "cc81040a";

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      input = {
        General = {
	  UserspaceHID = true;
	};
      };
      settings = {
	General = {
	  MaxConnections = 10;
	};
      };
    };
  };

  hardware.logitech.wireless.enable = true;

  time.timeZone = "Europe/Bucharest";

  i18n.defaultLocale = "en_US.UTF-8";

  services.desktopManager.cosmic.enable = true;

  services.displayManager.cosmic-greeter.enable = true;

  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.dwm.package = pkgs.dwm.override {
    conf = ../../user/dwm/config.h;

    patches = [ (pkgs.fetchpatch {
	url = "https://dwm.suckless.org/patches/autoraise-windows/dwm-autoraise_windows-20240809-d2e6bd5b.diff";
	hash = "sha256-+YwF1xVUA8i7HVoAwONJjmmGLQuqAWSuaGlqGSbA8XY=";
      })
      (pkgs.fetchpatch {
	url = "https://dwm.suckless.org/patches/tagshift/dwm-tagshift-6.3.diff";
	hash = "sha256-5QLIICFOpIzObnhmjwPkkzdq3h1Tmq0T53TjPNTkDfI=";
      })
      (pkgs.fetchpatch {
        url = "https://dwm.suckless.org/patches/center/dwm-center-6.2.diff";
        hash = "sha256-2uOVNtjR1c0eF5jbcUy51wgvBYHdPtUxZRWU4iz+zfs=";
      })
      (pkgs.fetchpatch {
        url = "https://raw.githubusercontent.com/bakkeby/patches/refs/heads/master/dwm/dwm-resizepoint-6.5.diff";
        hash = "sha256-vN97kH/o6Jck5TAvxu75hrgguP2AVgPSab2g0GwpUF0=";
      })
      (pkgs.fetchpatch {
        url = "https://dwm.suckless.org/patches/cool_autostart/dwm-cool-autostart-20240312-9f88553.diff";
        hash = "sha256-pgXbgoAAewCjZP16smKkTVh5p7P/FK+Rue0F6gjmGVo=";
      })
      (pkgs.fetchpatch {
	url = "https://dwm.suckless.org/patches/hide_vacant_tags/dwm-hide_vacant_tags-6.4.diff";
	hash = "sha256-GIbRW0Inwbp99rsKLfIDGvPwZ3pqihROMBp5vFlHx5Q=";
      })
      (pkgs.fetchpatch {
	url = "https://dwm.suckless.org/patches/barpadding/dwm-barpadding-20211020-a786211.diff";
	hash = "sha256-0kUD9+5E3h8B8V+emP/EuNKUNRujseL5dzjjZTN/NSU=";
      })
    ];
  };

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  nix.settings.trusted-users = [ "@wheel" ];
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  zramSwap.enable = true;

  services.hardware.openrgb.enable = true;

  services.udev.packages = [ pkgs.via ];

  environment.systemPackages = [
    pkgs.vim
    pkgs.git
    pkgs.qmk-udev-rules
    pkgs.qmk_hid
    pkgs.i2c-tools

    pkgs.nitrogen
    pkgs.slstatus
    pkgs.dunst

    pkgs.wineWowPackages.waylandFull
  ];

  boot.blacklistedKernelModules = [ "spd5118" ];

  environment.variables.EDITOR = "vim";

  system.stateVersion = "25.05";
}

