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
      fileExts = ["png" "jpg" "jpeg" "gif"];
    in
      builtins.map (n: let
        findFile = builtins.filter builtins.pathExists (map (ext: ./wallpapers/${n}.${ext}) fileExts);
        file =
          if findFile == []
          then builtins.throw "Either ${n} isn't a file or it doesn't have the ${builtins.concatStringsSep ", " (lib.lists.init fileExts)} or ${lib.lists.last fileExts} extensions."
          else builtins.head findFile;
      in {
        path = file;
        tags = lib.splitString "-" n;
        hash = builtins.hashFile "sha256" file;
      })
      (map (n: builtins.head (lib.splitString "." n)) (
        builtins.attrNames (
          lib.filterAttrs (n: _: n != "README.md") (builtins.readDir ./wallpapers)
        )
      ));

    packages = genSystems (_:
      builtins.listToAttrs (map (n: {
          name = n;
          value = throw "As of #15, wallpkgs no longer uses packages for wallpapers instead preferring to use the `wallpapers` flake output. Sorry for any inconvenience.";
        }) [
          "catppuccin"
          "oxocarbon"
          "unorganized"
          "tokyo_night"
          "space"
          "gruvbox"
          "rose_pine"
          "nature"
          "cities"
          "monochrome"
          "nord"
        ]));

    # I do not accept anything else.
    formatter = genSystems (system: pkgsFor.${system}.alejandra);
  };
}
