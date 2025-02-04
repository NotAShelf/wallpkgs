# Wallpkgs

Somewhat curated collection of various wallpapers that I have came across, or
were contributed by other users hoping to allow for a centralized wallpapers
repository.

## Usage

To use a wallpaper in wallpkgs, you add the flake to your flake inputs.
You then may use each of the wallpapers however you please.

```nix
{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        wallpkgs.url = "github:NotAShelf/wallpkgs";
    };

    outputs = { nixpkgs, wallpkgs, ... }: let
        genSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];
        pkgsFor = system: import nixpkgs {inherit system;};
    in {
        overlays.default = _final: prev: {
            catppuccinWalls = prev.callPackage ./wallpapers.nix {
                wallpapers = builtins.filter (wall: builtins.elem "catppuccin" wall.tags) (builtins.attrValues wallpkgs.wallpapers)
            };
        };
    }
}
```

## Contributing

My vision for Wallpkgs is for it to be a community collection of Wallpapers. As
such, new wallpapers are always welcome, whatever the theme.

For the sake of organization and avoiding potential infringement, please do
separate wallpapers based off of their distinctive features and **do give**
credit when it is due.

I unfortunately do not have a mechanism for per-image credits yet. Please
contact me in private if you would like your wallpaper to be removed.

## 📜 License

I will do my best to avoid infringing individual rights as much as possible. But
given the nature of how I (and many others in the Linux/FOSS community) find
wallpapers, the authors may sometimes be ambiguous.

If you find any work here that belongs to you, which you are willing to share
with the community with credits given, please
[let me know](https://github.com/NotAShelf/wallpkgs/issues) and I will respond
as soon as possible. If you find any work here that belongs to you that you are
_not_ willing to share, then contact me via the same method to request removal.
Just please keep in mind that aggressive comments will be returned in kind.

As such, contributors are kindly requested to **specify source for wallpapers
created by individual artists** and published over the internet. If you cannot
find the source, please leave a note for the potential artist finding you, and
ask them to contact you about the copyright. Thanks for your understanding!
