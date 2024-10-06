{
  lib,
  stdenvNoCC,
  style ? null,
  version,
  ...
}: let
  # null is used to represent a complete package.
  pname =
    if (style == null)
    then "wallpapers"
    else "wallpapers-${style}";

  pathsToCopy =
    if (style == null)
    then "./*"
    else "./${style}";
in
  stdenvNoCC.mkDerivation {
    inherit pname version;

    src = builtins.path {
      path = ../wallpapers;
      name = "${pname}-${version}";
    };

    strictDeps = true;

    preInstall = ''
      mkdir -p $out/share/wallpapers
    '';

    # It does matter that we do copying recursively here (-r)
    # for compatibility between full package and split packages.
    installPhase = ''
      runHook preInstall
      cp -rvf ${pathsToCopy} $out/share/wallpapers
      runHook postInstall
    '';

    meta = {
      description = "Pure and reproducible wallpaper collection for Nix users";
      license = lib.licenses.mit;
      platforms = lib.platforms.all;
      maintainers = with lib.maintainers; [NotAShelf];
    };
  }
