{
  description = "Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    nixcord.url = "github:kaylorben/nixcord";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations."9R" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./machines/9r/configuration.nix
        ./machines/9r/nvidia.nix
	./machines/9r/gaming.nix
        ./machines/9r/impermanence.nix
        ./virt/podman.nix

        ./networking/tailscale.nix

        # Security
        ./security/sudo.nix
        ./security/no-def.nix
        ./security/auditd.nix
	./security/wipe-root.nix

        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager
        inputs.chaotic.nixosModules.nyx-cache
        inputs.chaotic.nixosModules.nyx-overlay
        inputs.chaotic.nixosModules.nyx-registry
	inputs.impermanence.nixosModules.impermanence

        { 
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.stella = import ./user/stella.nix;
          home-manager.sharedModules = [ inputs.nixcord.homeModules.nixcord ];
        }
      ];
    };
  };
}
