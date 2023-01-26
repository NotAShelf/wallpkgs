{
  lib,
  stdenv,
  ...
}:
stdenv.mkDerivation {
  pname = "wallpkgs";
  version = "0.0.1";

  strictDeps = true;

  src = ../wallpapers;

  configurePhase = ''
    runHook preConfigure
    mkdir -p $out/share/wallpapers
    runHook postConfigure
  '';

  installPhase = ''
    runHook preInstall
    cp -r ./* $out/share/wallpapers
    runHook postInstall
  '';

  meta = {
    description = "Test";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = ["notashelf"];
  };
}
