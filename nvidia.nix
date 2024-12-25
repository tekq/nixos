{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
  };

  ## AMD
  # boot.kernelModules = [ "amdgpu" ];
  # boot.initrd.kernelModules = [ "amdgpu" "nvidia" ];
  

  # boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  
  # boot.initrd.kernelModules = [ "nvidia" ];

  # boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

  hardware.nvidia = {
    modesetting.enable = true;

    nvidiaPersistenced = true;

    powerManagement.enable = false;

    powerManagement.finegrained = false;

    open = false;

    nvidiaSettings = true;

    forceFullCompositionPipeline = false;

    package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
  };
}
