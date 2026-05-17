{
  description = ''
    Pure, reproducible, and *possibly curated* collection of wallpapers for Nix.
  '';

  outputs = _: let
    lib = import ./lib;
  in {
    # Construct the wallpapers output for wallpkgs from a directory and a list of
    # extensions allow.
    wallpapers = lib.toWallpkgs ./wallpapers ["png" "jpg" "jpeg" "gif"];
  };
}
