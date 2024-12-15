{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.initrd = {
    luks.devices."system".keyFile = "/etc/keys/root.key";
    
    secrets = {
      "/etc/keys/root.key" = /etc/keys/root.key;
    };
  };

  # Networking
  networking.hostName = "Hydra";
  networking.networkmanager.enable = true;
  systemd.services."NetworkManager-wait-online.service".wantedBy = lib.mkForce [ ];
  services.vnstat.enable = true;

  # Time and Locale
  time.timeZone = "Europe/Bucharest";
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   keyMap = "us";
  #   useXkbConfig = true;
  # };
  
  # X11/UI 
  services.xserver = {
    enable = true;
    #displayManager.gdm.enable = true;
    #desktopManager.gnome.enable = true;
    xkb.layout = "us";
  };

  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  # services.gnome.core-utilities.enable = false;
  # environment.gnome.excludePackages = [ pkgs.gnome-tour ];
  services.xserver.excludePackages = [ pkgs.xterm ];

  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';

  environment.systemPackages = [
    pkgs.logiops
  ];

  programs.zsh.enable = true;

  services.printing.enable = true;

  hardware.pulseaudio.enable = false; 
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # services.libinput.enable = true;

  # Kernel
  #boot.kernelPackages = pkgs.linuxPackages_cachyos-rc;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernel.sysctl = {
    "kernel.core_pattern" = "/dev/null";
  };


  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = true;
  sops.secrets.my-password.neededForUsers = true;

  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nixpkgs.config.allowUnfree = true;
 
  nix.settings.trusted-users = [ "root" "lexi" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.optimise.automatic = true;

  system.stateVersion = "24.05";
}

