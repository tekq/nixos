{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
  ];

  boot.tmp.cleanOnBoot = true;

  zramSwap.enable = true;

  networking.hostName = "6O";

  services.openssh.enable = true;

  system.stateVersion = "24.11";

  services.tailscale.enable = true;
  
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    git
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPortRanges = [];
  };
}
