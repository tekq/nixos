{
  network = {
    description = "UwU";
  };

 "15O" = { config, pkgs, lib, ... }: {
    imports = [
	./machines/15o/configuration.nix
	./machines/15o/hardware-configuration.nix

        ./common/all.nix
        ./user/common.nix
        ./virt/podman.nix

        inputs.sops-nix.nixosModules.sops
    ];

    deployment.targetUser = "root";

    deployment.targetHost = "15O";

    users.allowNoPasswordLogin = true;
  }; 
}
