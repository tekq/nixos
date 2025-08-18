{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.config.permittedInsecurePackages = [
    "libxml2-2.13.8"
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

