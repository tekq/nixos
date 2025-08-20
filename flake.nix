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
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix.url = "github:Mic92/sops-nix";
    nixcord.url = "github:kaylorben/nixcord";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    impermanence.url = "github:nix-community/impermanence";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tidaLuna.url = "github:Inrixia/TidaLuna";
    colmena.url = "github:zhaofengli/colmena";
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

	./dev/rider.nix

        ./virt/all.nix

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

	inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.stella = import ./user/stella.nix;
          home-manager.sharedModules = [
		inputs.nixcord.homeModules.nixcord
		inputs.zen-browser.homeModules.twilight
	  ];
          home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};
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

    colmenaHive = inputs.colmena.lib.makeHive {
      meta = {
	nixpkgs = import nixpkgs-small {
	  system = "x86_64-linux";
	  overlays = [];
	};
      };

      "15O" = {
	deployment = {
	  targetHost = "15O";
	  targetUser = "root";
	};

	imports = [
	  ./common/configuration.nix

	  ./virt/podman.nix

	  ./machines/15o/configuration.nix

	  ./machines/15o/hardware-configuration.nix
	];

	users.allowNoPasswordLogin = true;
      };

    "6O" = {
        deployment = {
          targetHost = "6O";
          targetUser = "root";
        };

        imports = [
          ./common/configuration.nix

          ./virt/podman.nix

          ./machines/6o/configuration.nix

          ./machines/6o/digital-ocean.nix
        ];

        users.allowNoPasswordLogin = true;
      };
    };
  };
}
