{ config, pkgs, ... }:

{
  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  chaotic.scx.enable = true;
  # chaotic.scx.scheduler = "scx_rustland";

  boot.kernel.sysctl = {
    "kernel.core_pattern" = "/dev/null";
  };
}
