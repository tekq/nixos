{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "15O";

  networking = {
    dhcpcd.enable = true;
  };

  services.tailscale.enable = true;
  
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  time.timeZone = "Europe/Bucharest";

  users.mutableUsers = false;

  powerManagement.cpuFreqGovernor = lib.mkDefault "conservative";

  nix.settings.allowed-users = [ "root" ];

  fileSystems."/".options = [ "noexec" ];
  fileSystems."/etc/nixos".options = [ "noexec" ];
  fileSystems."/var/lib/tailscale".options = [ "noexec" ];
  fileSystems."/var/log".options = [ "noexec" ];
  fileSystems."/root/containers".options = [ "noexec" ];

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "stella" ];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  environment.etc."machine-id".source
    = "/nix/persist/etc/machine-id";
  environment.etc."ssh/ssh_host_rsa_key".source
    = "/nix/persist/etc/ssh/ssh_host_rsa_key";
  environment.etc."ssh/ssh_host_rsa_key.pub".source
    = "/nix/persist/etc/ssh/ssh_host_rsa_key.pub";
  environment.etc."ssh/ssh_host_ed25519_key".source
    = "/nix/persist/etc/ssh/ssh_host_ed25519_key";
  environment.etc."ssh/ssh_host_ed25519_key.pub".source
    = "/nix/persist/etc/ssh/ssh_host_ed25519_key.pub";

  system.stateVersion = "24.11";
}

