{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
  };

  boot.kernelModules = [ "amdgpu" ];
  boot.initrd.kernelModules = [ "amdgpu" "nvidia" ];
  # boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

  services.xserver.videoDrivers = ["nvidia"];

  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

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
