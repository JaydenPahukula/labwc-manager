# https://labwc.github.io/labwc-config.5.html#keyboard

{ lib, ... }:

{
  options.programs.labwc.config.keyboard = with lib; {
    numlock = mkOption {
      type = types.bool;
      default = true;
      description = "When recognizing a new keyboard enable or disable Num Lock. Default is on.";
    };
    layoutScope = mkOption {
      type = types.enum [ "global" "window" ];
      default = "global";
      description = "Stores the keyboard layout either globally or per window and restores it when switching back to the
        window. Default is global.";
    };
    keybinds = mkOption {
      type = types.listOf (types.submodule {
        options = {
          key = mkOption {
            type = types.str;
          };
          layoutDependent = mkOption {
            type = types.bool;
            default = false;
          };
          actions = mkOption {
            type = types.listOf (types.addCheck (types.attrsOf types.str) (x: hasAttr "name" x));
          };
        };
      });
      default = [];
      description = ''
        Define a key binding in the format modifier-key, where supported modifiers are:
          - S (shift)
          - C (control)
          - A or Mod1 (alt)
          - H or Mod3 (hyper)
          - W or Mod4 (super / logo)
          - M or Mod5 (meta)
        Multiple modifiers can be combined like A-S-f for Alt-Shift-f. The key itself can be any unicode character or a
        keyname like Return.
        
        Unlike Openbox, multiple space-separated key combinations and key-chains are not supported. The application "wev"
        (wayland event viewer) is packaged in a lot of distributions and can be used to view all available keynames.

        layoutDependent [yes|no] Make this specific keybind depend on the currently active keyboard layout. If enabled,
        a keybind using a key which does not exist in the currently active layout will not be executed. The physical key
        to trigger a keybind may also change along with the active layout. If set to "no" (or is absent) the keybind will
        be layout agnostic. Default is no.

        Note: conditional actions are not yet supported.
      '';
    };
    default = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Load the default keybinds listed below. This is an addition to the openbox specification and provides a way to
        keep config files simpler whilst allowing your specific keybinds. Note that if no rc.xml is found, or if no
        <keyboard><keybind> entries exist, the same default keybinds will be loaded even if the <default /> element is
        not provided.

        A-Tab - next window
        W-Return - alacritty
        A-F3 - run bemenu
        A-F4 - close window
        W-a - toggle maximize
        A-<arrow> - move window to edge
        W-<arrow> - resize window to fill half the output

        Audio and MonBrightness keys are also bound to amixer and brightnessctl, respectively.
      '';
    };
    repeatRate = mkOption {
      type = types.int;
      default = 25;
      description = "Set the rate at which keypresses are repeated per second. Default is 25.";
    };
    repeatDelay = mkOption {
      type = types.int;
      default = 600;
      description = "Set the delay before keypresses are repeated in milliseconds. Default is 600.";
    };
  };
}
