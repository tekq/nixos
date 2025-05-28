{
  description = "Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:NixOS/nixpkgs/nixos-25.05-small";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    nixcord.url = "github:kaylorben/nixcord";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    impermanence.url = "github:nix-community/impermanence";
    # nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
  };

  outputs = { self, nixpkgs, nixpkgs-small, ... }@inputs: {
    nixosConfigurations."2B" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
	./common/all.nix

        ./machines/2b/configuration.nix
        ./machines/2b/nvidia.nix
	./machines/2b/gaming.nix
        ./machines/2b/impermanence.nix

	./user/common.nix

        ./virt/podman.nix

        ./networking/tailscale.nix

        # Security
        ./security/sudo.nix
        ./security/no-def.nix
        ./security/auditd.nix
	./security/wipe-root.nix
        ./security/secure-boot.nix

        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager
        inputs.chaotic.nixosModules.nyx-cache
        inputs.chaotic.nixosModules.nyx-overlay
        inputs.chaotic.nixosModules.nyx-registry
	inputs.impermanence.nixosModules.impermanence
        inputs.lanzaboote.nixosModules.lanzaboote
	# inputs.nixos-cosmic.nixosModules.default

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.stella = import ./user/stella.nix;
          home-manager.sharedModules = [ inputs.nixcord.homeModules.nixcord ];
        }
      ];
    };

    nixosConfigurations."9S" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	./common/all.nix

	./user/common.nix

        ./machines/9s/configuration.nix

	inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager

        { 
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.stella = import ./user/stella.nix;
          home-manager.sharedModules = [ inputs.nixcord.homeModules.nixcord ];
        }
      ];
    };

    nixosConfigurations."15O" = nixpkgs-small.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	./common/all.nix

	./user/common.nix

	./virt/podman.nix

        ./machines/15o/configuration.nix

	inputs.sops-nix.nixosModules.sops

	{
          system.autoUpgrade = {
            enable = true;
            flake = inputs.self.outPath;
            flags = [
              "--update-input"
              "nixpkgs"
              "-L" # print build logs
            ];
            dates = "10:00";
            randomizedDelaySec = "45min";
          };
      	}
      ];
    };
    
    nixosConfigurations."6O" = nixpkgs-small.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	./common/all.nix

	./user/common.nix

        ./machines/6o/configuration.nix
        
	inputs.sops-nix.nixosModules.sops

	{
          system.autoUpgrade = {
            enable = true;
            flake = inputs.self.outPath;
            flags = [
              "--update-input"
              "nixpkgs"
              "-L" # print build logs
            ];
            dates = "2:00";
            randomizedDelaySec = "45min";
          };
        }
      ];
    };
  };
}
