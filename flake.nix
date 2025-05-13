{
  description = "Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations."2B" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./machines/2b/configuration.nix
        ./machines/2b/nvidia.nix
	./machines/2b/gaming.nix
        ./machines/2b/impermanence.nix
	# ./machines/2b/nh.nix
        ./virt/podman.nix

	# ./user/dwm/picom.nix

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

    nixosConfigurations."15O" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/15o/configuration.nix
      ];
    };
    
    nixosConfigurations."6O" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/6o/configuration.nix
      ];
    };     
  };
}
