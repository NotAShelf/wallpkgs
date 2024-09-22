# 📒 Wallpkgs

A potentially curated collection of various wallpapers, packed for easier
packaging, sharing and consuming.

## Installing

There are several methods of getting wallpapers from Wallpkgs. The most simple
method would be to add it as a flake input, and pick a collection of wallpapers
that you may be interested in. Current list of collections include:

- Catppuccin
- Cities
- Monochrome
- Nature
- Space
- Unorganized

You may choose to install a specific category exposed as a package to reduce
your store size, or get all packages if storage space is not a concern. If the
list here is outdated, refer to `nix flake show github:notashelf/wallpkgs` for a
list of package outputs.

> [!NOTE]
> Available wallpaper packages can be installed on non-NixOS with
> `nix profile install`. This will make your wallpapers available under
> /etc/profiles/per-user/$USER while using a multi-user system.

Example:

```bash
$ nix profile install github:notashelf/wallpkgs#monochrome
```

### On NixOS/Home-Manager (Flakes)

The recommended and by far the easiest method of installing Wallpkgs is to add
it as a flake input, then consume exposed packages per your needs. Add Wallpkgs
to your `flake.nix` as follows:

```nix
inputs = {
    wallpkgs = {
        url = "github:notashelf/wallpkgs";
        inputs.nixpkgs.follows = "nixpkgs";
        # «https://github.com/nix-systems/nix-systems»
        # inputs.systems.follows = "systems"; # if using nix-systems
    };
};
```

This will allow you to reference any collection as a package as exposed by the
flake, for example, `inputs.wallpkgs.packages.${pkgs.system}.catppuccin` in any
given Nix file as long as `inputs` is in the argset. A more complete example
would be:

```nix
# configuration.nix
{inputs, pkgs, ...}: {
    environment = {
        etc."wallpapers".source = inputs.wallpkgs.packages.${pkgs.system}.catppuccin;
    };
}
```

Which would link `/etc/wallpapers` to the store path of your selected package
for a persistent path - which you can then tell your wallpaper manager to look
into, or use for scripting.

You may also use the package
(`inputs.wallpkgs.packages.${pkgs.system}.catppuccin`) by interpolating strings,
e.g., while writing configuration files with home-manager. How you approach this
is your choice, and this is left as an exercise to the reader.

## Using the wallpapers

> The `wallpkgs` package moves included wallpapers to `$out/share/wallpapers` by
> default. You may reference those files at
> `$NIX_USER_PROFILE_DIR/share/wallpapers/${style}` if they are installed via
> `nix profile install` (multi-user Nix), or reference the package path if
> installed via flake inputs with `${pkgs.wallpkgs}` inside NixOS
> configurations.

## Contributing

My vision for Wallpkgs is for it to be a community collection of Wallpapers. As
such, new wallpapers are always welcome, whatever the theme.

For the sake of organization and avoiding potential infringement, please do
separate wallpapers based off of their distinctive features and **do give**
credit when it is due.

I unfortunately do not have a mechanism for per-image credits yet. Please
contact me in private if you would like your wallpaper to be removed.

## 📜 License issues

I will do my best to avoid infringing individual rights as much as possible. But
given the nature of how I (and many others in the Linux/FOSS community) find
wallpapers, the authors may sometimes be ambiguous.

If you find any work here that belongs to you, which you are willing to share
with the community with credits given, please [contact me](../../issues) and I
will respond as soon as possible. If you find any work here that belongs to you
that you are _not_ willing to share, then contact me via the same method to
request removal. Just please keep in mind that aggressive comments will be
returned in kind.

As such, contributors are kindly requested to **specify source for wallpapers
created by individual artists** and published over the internet. If you cannot
find the source, please leave a note for the potential artist finding you, and
ask them to contact you about the copyright. Thanks for your understanding!
