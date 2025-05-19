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

  services.xserver.enable = true;

  hardware.bluetooth.enable = true; 
  hardware.bluetooth.powerOnBoot = true; 
  services.blueman.enable = true;

  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  services.xserver.displayManager.startx.enable = true;

  nixpkgs.overlays = [ ( final: prev: { dwl = prev.dwl.overrideAttrs { patches = [ 
    (pkgs.fetchpatch {
	url = "https://codeberg.org/dwl/dwl-patches/raw/commit/0bd725d0786248e1dfedbe6aa7453edfe736de43/patches/relative-mouse-resize/relative-mouse-resize.patch";
	hash = "sha256-tSp1CRpJof1dGWddr9vltbOSMsQBdw43zu2Q4iWQqsw=";
    })
    (pkgs.fetchpatch {
	url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/alwayscenter/alwayscenter.patch";
	hash = "sha256-JaM/YAXioRi16TRKLvDvHAsn4HQ9jpaBAhvHyp/r/+I=";
    })
    (pkgs.fetchpatch {
	url = "https://codeberg.org/dwl/dwl-patches/raw/commit/d235f0f88ed069eca234da5a544fb1c6e19f1d33/patches/ipc/ipc.patch";
	hash = "sha256-ULN1P31X70QbbtLgBw2WI4KgNIDOxHSAdRhSh5gr9bw=";
    })
    (pkgs.fetchpatch {
	url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/autostart/autostart-0.7.patch";
	hash = "sha256-aOPdNtf5sU8ZIV5Bum8LB9l9B6UTTxXStavPkWWdXrI=";
    })
  ]; }; }) ]; 

  ## DWM
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.dwm.package = pkgs.dwm.override {
    conf = ../../user/dwm/config.h;
    patches = [
      (pkgs.fetchpatch {
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
      (pkgs.fetchpatch {
	url = "https://dwm.suckless.org/patches/fullgaps/dwm-fullgaps-6.4.diff";
	hash = "sha256-+OXRqnlVeCP2Ihco+J7s5BQPpwFyRRf8lnVsN7rm+Cc=";
      })
    ];
  };
  
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

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
    nerd-fonts.hack
  ];

  # virtualisation.waydroid.enable = true;

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  services.hardware.openrgb.enable = true;

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.age.keyFile = "/persist/var/lib/sops-nix/keys.txt";
  sops.age.generateKey = true;
  sops.secrets.stella-password.neededForUsers = true;

  environment.systemPackages = [
    pkgs.vim
    pkgs.git
    pkgs.yajl
    pkgs.qmk-udev-rules
    pkgs.qmk_hid

    (pkgs.dwl.override {
      configH = ../../user/dwl/config.h; 
    })
  ];

  environment.variables.EDITOR = "vim";

  system.stateVersion = "24.11";
}

