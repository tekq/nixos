# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.etc."machine-id".source
    = "/nix/persist/etc/machine-id";

  networking.hostName = "9S";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Bucharest";

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-utilities.enable = false;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    git
    jetbrains.clion
  ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.age.keyFile = "/nix/persist/var/lib/sops-nix/keys.txt";
  sops.age.generateKey = true;
  sops.secrets.root-password.neededForUsers = true;
  sops.secrets.stella-password.neededForUsers = true;

  users.users.root.hashedPasswordFile = config.sops.secrets.root-password.path;
  programs.zsh.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  users.users.stella = {
    description = "Assembly";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets.stella-password.path;
  };

  nixpkgs.config.allowUnfree = true; 

  system.stateVersion = "24.11";
}

