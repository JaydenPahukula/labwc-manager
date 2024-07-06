# https://labwc.github.io/labwc-config.5.html#tablet

{ lib, ... }:

{
  options.programs.labwc.config.tablet = with lib; {
    mapToOutput = mkOption {
      type = types.str;
      default = "";
      description = "The tablet cursor movement can be restricted to a single output. If the output name is left
        empty or the output does not exists, the tablet will span all outputs.";
    };
    rotate = mkOption {
      type = types.enum [ 0 90 180 270 ];
      default = 0;
      description = "The tablet orientation can be changed in 90 degree steps. Default is no rotation (0). Rotation
        will be applied after applying tablet area transformation. See also calibrationMatrix in libinput section
        below for advanced transformation.";
    };
    area = mkOption {
      type = types.submodule {
        options = {
          top = mkOption {
            type = types.float;
            default = 0.0;
          };
          left = mkOption {
            type = types.float;
            default = 0.0;
          };
          width = mkOption {
            type = types.float;
            default = 0.0;
          };
          height = mkOption {
            type = types.float;
            default = 0.0;
          };
        };
      };
      default = {};
      description = ''
        By default the complete tablet area is mapped to the full output. The area element can be used to truncate
        the active area of the tablet surface. By truncating the active area, it is e.g. possible to maintain the
        same aspect ratio between output and tablet.

        The active tablet area can be specified by setting the top/left coordinate (in mm) and/or width/height (in mm).
        If width or height are omitted or default (0.0), width/height will be set to the remaining width/height seen
        from top/left.

        Aspect ratio example: The dimensions of the tablet are 215mm x 115mm and the output has a resolution of
        3440x1440. When setting height to "90", because 215 x 1440 / 3440 = 90, the responsive tablet area height
        will be truncated to match the 21:9 aspect ratio of the output. By additionally setting top to "12.5", the
        active area is centered vertically on the tablet surface.
      '';
    };
    mouseEmulation = mkOption {
      type = types.bool;
      default = false;
      description = "The tablet can be forced to always use mouse emulation. This prevents tablet specific restrictions,
        e.g. no support for drag-and-drop, but also omits tablet specific features like reporting pen pressure.";
    };
    map = mkOption {
      type = types.attrsOf types.str;
      default = {
        Tip = "Left";
        Stylus = "Right";
        Stylus2 = "Middle";
      };
      description = ''
        Pen buttons emulate regular mouse buttons. If not specified otherwise, the first pen button (Stylus) is mapped
        to right mouse button click and the second pen button (Stylus2) emulates a middle mouse button click. For mouse
        emulation, the tip (Tip) is mapped to left mouse click.

        Supported map buttons are:
          - Tip (mouse emulation only)
          - Stylus
          - Stylus2
          - Stylus3
          - Pad
          - Pad2..Pad9

        The stylus buttons (Stylus, Stylus2 and Stylus3) can be mapped to:
          - Right
          - Middle
          - Side

        The tablet pad buttons can be mapped to all available mouse buttons. When using mouse emulation only, the tip
        and stylus buttons can also be mapped to all available mouse buttons. See mouse section above for all supported
        mouse buttons.
      '';
    };
  };
}
