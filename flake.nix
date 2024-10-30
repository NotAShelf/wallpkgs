{
  description = ''
    Pure and reproducible, and possibly curated collection of wallpapers.
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
    version = self.shortRev or "dirty";
  in {
    overlays.default = _: prev: let
      callWallpaper = style:
        prev.callPackage ./nix/builder.nix {
          inherit style version;
        };
    in rec {
      # Complete repository: larger and more varied collection.
      # Naturally, means longer build times.
      full = wallpkgs;
      wallpkgs = callWallpaper null;

      # Call individual collections by category.
      catppuccin = callWallpaper "catppuccin";
      oxocarbon = callWallpaper "oxocarbon";
      cities = callWallpaper "cities";
      monochrome = callWallpaper "monochrome";
      nature = callWallpaper "nature";
      space = callWallpaper "space";
      unorganized = callWallpaper "unorganized";
      tokyo_night = callWallpaper "tokyo_night";
      gruvbox = callWallpaper "gruvbox";
      rose_pine = callWallpaper "rose_pine";
    };

    # Generate package outputsfrom available overlay packages.
    packages = genSystems (system:
      (self.overlays.default null pkgsFor.${system})
      // {
        default = self.packages.${system}.wallpkgs;
      });

    # I do not accept anything else.
    formatter = genSystems (system: pkgsFor.${system}.alejandra);
  };
}
