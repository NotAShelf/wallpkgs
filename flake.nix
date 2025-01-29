{
  description = ''
    Pure and reproducible, and possibly curated collection of wallpapers.
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs = {
    nixpkgs,
    systems,
    ...
  }: let
    inherit (nixpkgs) lib;

    genSystems = lib.genAttrs (import systems);
    pkgsFor = nixpkgs.legacyPackages;
  in {
    wallpapers = let
      fileExts = ["png" "jpg" "jpeg"];
    in
      builtins.mapAttrs (n: v: let
        findFile = builtins.filter builtins.pathExists (map (ext: ./wallpapers/${n}.${ext}) fileExts);
        file =
          if findFile == []
          then builtins.throw "Either ${n} isn't a file or it doesn't have the ${builtins.concatStringsSep ", " (lib.lists.init fileExts)} or ${lib.lists.last fileExts} extensions."
          else builtins.head findFile;
      in {
        path = file;
        tags =
          if (builtins.isString v)
          then lib.splitString " " v
          else v;
        hash = builtins.hashFile "sha256" file;
      }) {
        "catppuccin-01" = ["catppuccin"];
        "catppuccin-02" = ["catppuccin"];
        "catppuccin-03" = ["catppuccin"];
        "catppuccin-04" = ["catppuccin"];
        "catppuccin-05" = ["catppuccin"];
        "catppuccin-06" = ["catppuccin"];
        "cities-01" = ["cities"];
        "cities-02" = ["cities"];
        "cities-03" = ["cities"];
        "cities-04" = ["cities"];
        "cities-05" = ["cities"];
        "cities-06" = ["cities"];
        "cities-07" = ["cities"];
        "cities-08" = ["cities"];
        "cities-09" = ["cities"];
        "cities-10" = ["cities"];
        "cities-11" = ["cities"];
        "cities-12" = ["cities"];
        "cities-13" = ["cities"];
        "cities-14" = ["cities"];
        "gruvbox-01" = ["gruvbox"];
        "monochrome-01" = ["monochrome"];
        "nature-01" = ["nature"];
        "nature-02" = ["nature"];
        "nature-03" = ["nature"];
        "nature-04" = ["nature"];
        "nature-05" = ["nature"];
        "nature-06" = ["nature"];
        "nature-07" = ["nature"];
        "oxocarbon-01" = ["oxocarbon"];
        "oxocarbon-02" = ["oxocarbon"];
        "rose_pine-01" = ["rose_pine"];
        "rose_pine-02" = ["rose_pine"];
        "rose_pine-03" = ["rose_pine"];
        "rose_pine-04" = ["rose_pine"];
        "rose_pine-05" = ["rose_pine"];
        "rose_pine-06" = ["rose_pine"];
        "space-01" = ["space"];
        "space-02" = ["space"];
        "space-03" = ["space"];
        "space-04" = ["space"];
        "tokyo_night-01" = ["tokyo_night"];
        "tokyo_night-02" = ["tokyo_night"];
        "tokyo_night-03" = ["tokyo_night"];
        "tokyo_night-04" = ["tokyo_night"];
        "tokyo_night-05" = ["tokyo_night"];
        "unorganized-01" = ["unorganized"];
        "unorganized-02" = ["unorganized"];
        "unorganized-03" = ["unorganized"];
        "unorganized-04" = ["unorganized"];
        "unorganized-05" = ["unorganized"];
        "unorganized-06" = ["unorganized"];
        "unorganized-07" = ["unorganized"];
        "unorganized-08" = ["unorganized"];
        "unorganized-09" = ["unorganized"];
        "unorganized-10" = ["unorganized"];
        "unorganized-11" = ["unorganized"];
        "nord-01" = ["nord"];
        "nord-02" = ["nord"];
        "nord-03" = ["nord"];
        "nord-04" = ["nord"];
        "nord-05" = ["nord"];
      };

    # I do not accept anything else.
    formatter = genSystems (system: pkgsFor.${system}.alejandra);
  };
}
