{ config, pkgs, ... }:

{
  # Steam + Optimizations
  programs.steam = {
        enable = true;
        platformOptimizations.enable = true;
        remotePlay.openFirewall = false;
        dedicatedServer.openFirewall = false;
        localNetworkGameTransfers.openFirewall = false;
  };

  # Xpadneo
  hardware.xpadneo.enable = true;
}
