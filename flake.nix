{
	description = "Hyprland on NixOS";

	inputs = {
		nixpkgs.url = "git+https://github.com/nixos/nixpkgs?ref=nixos-26.05";
		home-manager = {
			url = "git+https://github.com/nix-community/home-manager?ref=release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		zen-browser = {
			url = "github:youwen5/zen-browser-flake";
			inputs = {
				nixpkgs.follows = "nixpkgs";
			};
		};
	};
        
	outputs = { self, nixpkgs, home-manager, zen-browser, ... }@inputs: {
		nixosConfigurations.hyprland-btw = nixpkgs.lib.nixosSystem {
			specialArgs = {
				inherit inputs;
			};
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.shalamar = import ./home.nix;
						backupFileExtension = "backup";
					};
				}
			];
		};
	};
}
