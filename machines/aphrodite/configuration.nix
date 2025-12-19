{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.firewall.enable = false;

  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "max";
    };

    # timeout = 0;

    efi.canTouchEfiVariables = true;
  };

  security.apparmor.enable = true;

  networking.hostName = "Aphrodite";
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

  services.pipewire.extraConfig.pipewire."hi-res-dac" = {
    "context.properties" = {
      "default.clock.allowed-rates" = [ 44100 48000 88200 96000 176400 192000 ];
    };

    "stream.properties" = {
      "resample.quality" = 14;
    };
  };

  time.timeZone = "Europe/Bucharest";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = false;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = false;

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
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

  modules.editors.rider.enable = true;

  virtualisation.virtualbox.host.enable = true;

  environment.systemPackages = [
    pkgs.vim
    pkgs.git
    pkgs.qmk-udev-rules
    pkgs.qmk_hid
    pkgs.i2c-tools

    pkgs.solaar

    pkgs.wineWowPackages.waylandFull
  ];

  boot.blacklistedKernelModules = [ "spd5118" ];

  environment.variables.EDITOR = "vim";

  system.stateVersion = "25.05";
}

