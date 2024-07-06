# https://labwc.github.io/labwc-config.5.html#theme

{ lib, ... }:

{
  options.programs.labwc.config.theme = with lib; {
    name = mkOption {
      type = types.str;
      default = "";
      description = "The name of the Openbox theme to use. It is not set by default.";
    };
    cornerRadius = mkOption {
      type = types.int;
      default = 8;
      description = "The radius of server side decoration top corners. Default is 8.";
    };
    keepBorder = mkOption {
      type = types.bool;
      default = true;
      description = "Even when disabling server side decorations via ToggleDecorations, keep a small border (and resize
        area) around the window. Default is yes.";
    };
    dropShadows = mkOption {
      type = types.bool;
      default = false;
      description = "Should drop-shadows be rendered behind windows. Default is no.";
    };
    fonts = mkOption {
      type = types.listOf (types.submodule {
        options = {
          place = mkOption {
            type = types.enum [ "" "ActiveWindow" "InactiveWindow" "MenuItem" "OnScreenDisplay" ];
            description = ''
              Places can be any of:
                - ActiveWindow - titlebar of active window
                - InactiveWindow - titlebar of all windows that aren't focused by the cursor
                - MenuItem - menu item (currently only root menu)
                - OnScreenDisplay - items in the on screen display
              If no place attribute is provided, the setting will be applied to all places.
            '';
          };
          name = mkOption {
            type = types.str;
            description = "Describes font name. Default is sans.";
          };
          size = mkOption {
            type = types.int;
            description = "Font size in pixels. Default is 10.";
          };
          slant = mkOption {
            type = types.enum [ "normal" "italic" ];
            description = "Font slant (normal or italic). Default is normal.";
          };
          weight = mkOption {
            type = types.enum [ "normal" "bold" ];
            description = "Font weight (normal or bold). Default is normal.";
          };
        };
      });
      default = [
        {
          place = "ActiveWindow";
          name = "sans";
          size = 10;
          slant = "normal";
          weight = "normal";
        }
        {
          place = "InactiveWindow";
          name = "sans";
          size = 10;
          slant = "normal";
          weight = "normal";
        }
        {
          place = "MenuItem";
          name = "sans";
          size = 10;
          slant = "normal";
          weight = "normal";
        }
        {
          place = "OnScreenDisplay";
          name = "sans";
          size = 10;
          slant = "normal";
          weight = "normal";
        }
      ];
      description = "The font to use for a specific element of a window, menu or OSD.";
    };
  };
}
