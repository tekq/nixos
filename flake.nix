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
    nixpkgs.follows = "nixos-cosmic/nixpkgs";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
  };

  outputs = { self, nixpkgs, home-manager, nix-gaming, chaotic, sops-nix, nixos-cosmic, ... }@inputs: {
    nixosConfigurations.Hydra = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
	./systemd.nix
	./gaming.nix
	./nvidia.nix
	./kvm.nix	
	./users.nix

	inputs.nix-gaming.nixosModules.platformOptimizations
	chaotic.nixosModules.default
	sops-nix.nixosModules.sops
        {
        nix.settings = {
             substituters = [ "https://cosmic.cachix.org/" ];
             trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
           };
         }
         nixos-cosmic.nixosModules.default

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
