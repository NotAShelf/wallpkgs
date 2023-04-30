# 📒 Wallpkgs

> A potentially curated collection of wallpapers with various color palettes. Packaged
> with nix for ease of installation and referencing.

## Building

> Wallpkgs exposes a default package which you can build without extra args.

```console
# Build default (full) package
$ nix build .
```

```console
# Or build only the catppuccin package
$ nix build .#catppuccin
```

## Install

> Wallpkgs can be installed on non-NixOS with nix profile install. Do note that this
> will copy the packages to your nix profile and not nix store.

```console
$ nix profile install github:notashelf/wallpkgs
```

> On NixOS, it's recommended that you add wallpkgs to your flake inputs.

```nix
inputs = {
    wallpkgs = "github:notashelf/wallpkgs";
};
```

## Using the wallpapers

> The `wallpkgs` package moves included wallpapers to `$out/share/wallpapers` by
> default. You may reference those files at `$NIX_USER_PROFILE_DIR/share/wallpapers/${style}`
> if they are installed via `nix profile install` (multi-user Nix), or reference the
> package path if installed via flake inputs with `${pkgs.wallpkgs}` inside NixOS
> configurations.

You can also reference the package path with ${pkgs.wallpkgs}, optionally providing a style:

```nix
{inputs, ...}:
let
    wallpkgs = inputs.wallpkgs.packages.${pkgs.system}.catppuccin;
in {
    home.packages = [
        wallpkgs
    ];
}
```

In this example, wallpapers will be installed to `$out/share/wallpapers/catppuccin` and only the catppuccin wallpapers will be included. Using the `default` package will use the full wallpapers directory and make it available at `$out/share/wallpapers`.

This can be used to choose wallpaper sets from the inputs packages.
You may also try using the overlay, but using packages is recommended.

## Contributing

**New Wallpapers**

> My vision for Wallpkgs is for it to be a community collection of Wallpapers. As such,
> new wallpapers are always welcome, whatever the theme. For the sake of organization and
> avoiding potential infringement, please do separate wallpapers based off of their distinctive
> features and give credit when it is due.

**Nix**

> I am nowhere near the best when it comes to Nix. This was meant to be a project for
> me to explore with as well as a wallpaper collection for me and others to use, and thus
> please do feel free to refactor/rewrite/add/remove any nix code as you see fit. PRs will ba
> reviewed with utmost interest. See [todo](../TODO) for my current list of to-do items.

## 📜 License issues

> I will do my best to avoid infringing individual rights as much as possible. But given
> the nature of how I (and many others in the Linux & OSS community) find wallpapers,
> the authors may sometimes be ambigious. If you find any work here tha belongs to you, which
> you are willing to share with the community with credits given, please [contact me](../../issues) and I will respond
> as soon as possible.

> Contributors are kindly requested to **specify source for wallpapers created by individual artists**.
> and published over the internet. If you cannot find the source, please leave a note for the potential artist finding you, and ask them to contact you about the copyright.
> Thanks for your understanding!

---
