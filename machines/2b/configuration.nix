{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_6_14;

  services.scx.enable = true;

  networking.hostName = "2B";
  networking.networkmanager.enable = true;
  networking.hostId = "cc81040a";

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

  # virtualisation.waydroid.enable = true;

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  services.hardware.openrgb.enable = true;

  services.udev.packages = [ pkgs.via ];

  systemd.services.disable-rgb = {
    script = "
      ${pkgs.i2c-tools}/bin/i2cset -y 1 0x61 0x08 0x53
      ${pkgs.i2c-tools}/bin/i2cset -y 1 0x61 0x09 0x00
      ${pkgs.i2c-tools}/bin/i2cset -y 1 0x61 0x20 0x0
      ${pkgs.i2c-tools}/bin/i2cset -y 1 0x61 0x08 0x44
      ${pkgs.i2c-tools}/bin/i2cset -y 1 0x63 0x08 0x53
      ${pkgs.i2c-tools}/bin/i2cset -y 1 0x63 0x09 0x00
      ${pkgs.i2c-tools}/bin/i2cset -y 1 0x63 0x20 0x0
      ${pkgs.i2c-tools}/bin/i2cset -y 1 0x63 0x08 0x44
    ";

    serviceConfig = {
      Type = "oneshot";
    };

    wantedBy = [ "graphical.target" ];
  };

  environment.systemPackages = [
    pkgs.vim
    pkgs.git
    pkgs.qmk-udev-rules
    pkgs.qmk_hid
    pkgs.i2c-tools
  ];

  boot.blacklistedKernelModules = [ "spd5118" ];

  environment.variables.EDITOR = "vim";

  system.stateVersion = "25.05";
}

