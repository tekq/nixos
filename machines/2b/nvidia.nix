{ config, lib, pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable = true;
      finegrained = false;
    };

    open = false;
    
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  boot.kernelParams = [
    "mem_sleep_default=deep"
  ];
}
