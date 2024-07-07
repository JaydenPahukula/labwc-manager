# Labwc Manager

Manage your labwc configuration with Nix Home Manager!

Warning: This is an ongoing project and option implementation is subject to change. I use this module in my own home manager configuration, but there are parts that are not thoroughly tested, so let me know or open an issue if you find a bug.

## Usage:

Add `labwc-manager` to your flake inputs:

```nix
# flake.nix
{
  inputs = {
    # ...
    labwc-manager.url = "github:JaydenPahukula/labwc-manager";
  }
}
```

Then you can add the module to your home manager configuration:

```nix
homeConfigurations = {
  "user" = home-manager.lib.homeManagerConfiguration {
    # ...
    modules = [
      # ...
      labwc-manager
    ]
  }
}
```

Once you enable labwc, you can configure it in your home manager configuration! Here is an example:

```nix
# home.nix
{
  programs.labwc.enable = true;
  programs.labwc.config.core.decoration = "server";
}
```

This module's options mimic the options specified in the [labwc manual](https://labwc.github.io/manual.html). I am working on adding documentation, so in the meantime I recommend looking at the source code to see how the non-trivial options are implemented in nix.
