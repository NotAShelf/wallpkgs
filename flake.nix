{
  description = ''
    Pure and reproducible, and possibly curated collection of wallpapers.
  '';

  outputs = _: let
    lib = import ./lib;

    systems = ["x86_64-linux" "aarch64-linux"];
    genSystems = lib.genAttrs (import systems);
  in {
    # Construct the wallpapers output for wallpkgs from a directory and a list of
    # extensions allow.
    wallpapers = lib.toWallpkgs ./wallpapers ["png" "jpg" "jpeg" "gif"];

    # For backwards compatibility. This should re removed in the future.
    packages = genSystems (_:
      builtins.listToAttrs (map (n: {
          name = n;
          value = throw ''
            As of #15, wallpkgs no longer uses packages.$${system} for wallpapers, as wallpapers
            should never have been system-dependent. All wallpapers have been moved to a top-level
            'wallpapers' attribute under the repository.

            To use your own wallpapers, you must conform to the new filename format.

            For example, 'inputs.wallpkgs.wallpapers.catppuccin-01' now refers to what used to
            reside in /share/wallpapers/catppuccin/01.png. To suppress this error, get wallpapers
            from the wallpapers output.
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
  };
}
