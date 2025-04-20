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
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations."9R" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./9r/configuration.nix
        ./9r/nvidia.nix
	./9r/gaming.nix
        ./virt/podman.nix

        ./networking/tailscale.nix

        # Security
        ./security/sudo.nix
        ./security/no-def.nix
        ./security/auditd.nix

        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager
        { 
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.stella = import ./user/stella.nix;
          home-manager.sharedModules = [ inputs.nixcord.homeManagerModules.nixcord ];
        }
      ];
    };
  };
}
