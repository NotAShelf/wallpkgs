# This is the wallpkgs... un-extended library. It appends a few useful functions
# based on their nixpkgs.lib variants, without any reliance on nixpkgs' own lib.
# Idea is that we do not need to pull an input for nixpkgs library alone, since
# wallpapers here are no longer packages. If implementing a new function, please
# remember to keep it lib-free. If it *must* rely on lib, then implement the
# function or functions you need as well as the main function.
let
  splitString = separator: str: let
    # "Nix doesn't have for loops it's a functional programming language!"
    # You know what it has now? For loops. Nerd.
    loop = str: acc: currentPos: currentSegment:
      if currentPos == builtins.stringLength str
      then
        # end of string: add the current segment (even if it's empty)
        acc ++ [currentSegment]
      else let
        char = builtins.substring currentPos 1 str;
      in
        if char == separator
        then
          # separator; add the current segment (even if it's empty) to acc
          # and start a new segment for the next part
          loop str (acc ++ [currentSegment]) (currentPos + 1) ""
        else loop str acc (currentPos + 1) (currentSegment + char);
  in
    loop str [] 0 "";

  filterAttrs = f: attrs: let
    names = builtins.attrNames attrs;
    filteredNames = builtins.filter (name: f name (attrs.${name})) names;
  in
    builtins.listToAttrs (map (name: {
        name = name;
        value = attrs.${name};
      })
      filteredNames);

  genAttrs = names: f:
    builtins.listToAttrs (map (name: {
        name = name;
        value = f name;
      })
      names);
  # Yoinked from nixpkgs
  hasSuffix = suffix: content: let
    lenContent = builtins.stringLength content;
    lenSuffix = builtins.stringLength suffix;
  in (
    lenContent >= lenSuffix && builtins.substring (lenContent - lenSuffix) lenContent content == suffix
  );

  # TODO: This needs to be extensible, possibly in order to allow additional directories.
  # In theory, we should only need to handle path*s* instead of a path, and search multiple
  # paths by extension instead of just once, right?
  toWallpkgs = path: extensions: let
    hasValidExtension = file: builtins.foldl' (acc: elem: (hasSuffix elem "${file}") || acc) false extensions;

    fetchPath = path:
      filterAttrs (n: t: t == "directory" || (t == "regular" && hasValidExtension n)) (
        builtins.readDir path
      );

    getFiles = path:
      builtins.listToAttrs (
        builtins.attrValues (
          builtins.mapAttrs (
            n: v:
              if v == "directory"
              then {
                name = n;
                value = getFiles "${path}/${n}";
              }
              else let
                name = builtins.head (splitString "." n);
              in {
                inherit name;
                value = {
                  path = "${path}/${n}";
                  tags = splitString "-" name;
                  hash = builtins.hashFile "md5" "${path}/${n}"; # in theory, md5 is the fastest option because it produces a 128-bit hash instead of >= 160
                };
              }
          ) (fetchPath path)
        )
      );
  in
    getFiles path;
in {
  # Partial re-implementations of functions from Nixpkgs.
  # They may not work as intended, as the implementation is *completely* different. If this is
  # the case while contributing, please create an issue!
  inherit splitString filterAttrs genAttrs;

  # Main function to create the final collection of wallpapers from a given directory.
  inherit toWallpkgs;
}
