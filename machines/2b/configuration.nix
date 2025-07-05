{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  # boot.loader.timeout = 0;
  boot.loader.efi.canTouchEfiVariables = true;

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

  time.timeZone = "Europe/Bucharest";

  i18n.defaultLocale = "en_US.UTF-8";

  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

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

  services.hardware.openrgb.enable = true;

  services.udev.packages = [ pkgs.via ];

  environment.systemPackages = [
    pkgs.vim
    pkgs.git
    pkgs.qmk-udev-rules
    pkgs.qmk_hid
    pkgs.i2c-tools

    pkgs.wineWowPackages.waylandFull
  ];

  boot.blacklistedKernelModules = [ "spd5118" ];

  environment.variables.EDITOR = "vim";

  system.stateVersion = "25.05";
}

