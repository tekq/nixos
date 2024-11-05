{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    home-manager = {
	url = "github:nix-community/home-manager/master";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-gaming, chaotic, sops-nix, ... }@inputs: {
    nixosConfigurations.Hydra = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
	./nvidia.nix
	./systemd.nix
	./gaming.nix
	./kernel.nix
	./kvm.nix	

	inputs.nix-gaming.nixosModules.platformOptimizations
	chaotic.nixosModules.default
	sops-nix.nixosModules.sops

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

	  users.users.lexi.isNormalUser = true;
          home-manager.users.lexi = import ./home.nix;
        }
      ];
    };
  };
}
