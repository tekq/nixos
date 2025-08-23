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

    open = true;
    
    nvidiaSettings = true;

    # package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
  };

  boot.kernelParams = [
    "mem_sleep_default=deep"
  ];
}
