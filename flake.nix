{ 
  description = "A pack of the custom sound effects used in the hit GBA game series Megaman Batte Network";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  
  outputs = { self, nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forEachSystem = nixpkgs.lib.genAttrs systems;

      overlayList = [ self.overlays.default ];

      pkgsBySystem = forEachSystem ( system:
        import nixpkgs {
          inherit system;
          overlays = overlayList;
        }
      );

      pname = "mmbn-sfx";
      version = "1.0";
    in {

      overlays.default = final: prev: {
        ${pname} = final.callPackage ./package.nix { inherit pname version; };
      };

      packages = forEachSystem ( system: {
        ${pname} = pkgsBySystem.${system}.${pname};
        default = pkgsBySystem.${system}.${pname};
      });
    };
}
