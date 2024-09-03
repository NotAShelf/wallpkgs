{
  description = ''
    A collection of various wallpapers, packed with a Nix Flake
    for easier organization and curation.
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs = {
    self,
    nixpkgs,
    systems,
  }: let
    inherit (nixpkgs) lib;
    genSystems = lib.genAttrs (import systems);
    pkgsFor = nixpkgs.legacyPackages;
    version = self.shortRev;
  in {
    overlays.default = _: prev: let
      stdenv = prev.stdenvNoCC;
      callWallpaper = style:
        prev.callPackage ./nix/default.nix {
          inherit style version stdenv;
        };
    in rec {
      # Complete repository: larger and more varied collection.
      # Naturally, means longer build times.
      full = wallpkgs;
      wallpkgs = callWallpaper null;

      # Call individual collections by category.
      catppuccin = callWallpaper "catppuccin";
      cities = callWallpaper "cities";
      monochrome = callWallpaper "monochrome";
      nature = callWallpaper "nature";
      space = callWallpaper "space";
      unorganized = callWallpaper "unorganized";
    };

    packages = genSystems (system:
      (self.overlays.default null pkgsFor.${system})
      // {
        default = self.packages.${system}.wallpkgs;
      });

    formatter = genSystems (system: pkgsFor.${system}.alejandra);
  };
}
