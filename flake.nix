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
          value = throw ''
            As of #15, wallpkgs no longer uses packages.$${system} for wallpapers, as wallpapers
            should never have been system-dependant. All wallpapers have been moved to a top-level
            'wallpapers' attribute under the repository.

            To use your own wallpapers, you must conform to the new filename format.

            For example, 'inputs.wallpkgs.packages.wallpapers.catppuccin-01' now refers to what used
            to reside in /share/wallpapers/catppuccin/01.png. To suppress this error, get wallpapers
            from the packages output.
          '';
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
