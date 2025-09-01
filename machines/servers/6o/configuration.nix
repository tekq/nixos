{ pkgs, ... }: {
  boot.tmp.cleanOnBoot = true;

  zramSwap.enable = true;

  networking.hostName = "6O";

  services.openssh.enable = true;

  services.tailscale.enable = true;
  
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPortRanges = [];
  };

  system.stateVersion = "25.05";
}
