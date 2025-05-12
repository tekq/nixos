{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_6_12;

  # services.scx.enable = true;

  networking.hostName = "2B";
  networking.networkmanager.enable = true;
  networking.hostId = "cc81040a";

  time.timeZone = "Europe/Bucharest";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-utilities.enable = false;

  ## COSMIC
  # services.desktopManager.cosmic.enable = true;
  # services.displayManager.cosmic-greeter.enable = true;

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };


  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "dvorak";
  console.useXkbConfig = true;

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "@wheel" ];
  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  users.users.stella = {
    description = "Assembly";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets.stella-password.path;
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  virtualisation.waydroid.enable = true;

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  services.hardware.openrgb.enable = true;

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.age.keyFile = "/persist/var/lib/sops-nix/keys.txt";
  sops.age.generateKey = true;
  sops.secrets.stella-password.neededForUsers = true;

  nixpkgs.overlays = [ ( final: prev: { dwl = prev.dwl.overrideAttrs { patches = [ ./user/dwl/ipc.patch ]; }; }) ]; 

  environment.systemPackages = [
    pkgs.vim
    pkgs.git
    # pkgs.dwl
    pkgs.foot
  ];

  environment.variables.EDITOR = "vim";

  system.stateVersion = "24.11";
}

