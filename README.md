_WARNING: I no longer use labwc personally, so I've stopped updating this project. It works but there are many features that have not really been tested (and won't be). Use at your own risk, and feel free to open PRs._

# Labwc Manager

Manage your labwc configuration with Nix Home Manager!

## Usage:

_Make sure you have labwc installed before beginning!_

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
