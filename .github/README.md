# Wallpkgs

A possibly curated list of various wallpapers. Packaged with Nix for ease of installation
and path access.

## Build

```console
$ nix build .
```

## Install 

```console
$ nix profile install .
```

or add to your flake inputs

```nix 
inputs = {
...
wallpkgs = "github:notashelf/wallpkgs";
};
```

## Using the wallpapers 

The `wallpkgs` package moves included wallpapers to `$out/share/wallpapers` by 
default. You may reference those files at `/nix/var/nix/profiles/per-user/<username>/profile/share/wallpapers`
if they are installed via `nix profile install`, or reference the package path if installed 
via flake inputs with `${pkgs.wallpkgs}` inside NixOS configurations. 

## Contributing

You may add your favorite wallpapers by simply opening a pull request. Contributions will 
always be welcome.

## License issues 

TBD
