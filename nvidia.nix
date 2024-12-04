{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
  };

  boot.initrd.kernelModules = [ "nvidia" ];
  # boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;

    nvidiaPersistenced = true;

    powerManagement.enable = false;

    powerManagement.finegrained = false;

    open = false;

    nvidiaSettings = false;

    forceFullCompositionPipeline = false;

    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
}
