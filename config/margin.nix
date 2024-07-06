# https://labwc.github.io/labwc-config.5.html#margin

{ lib, ... }:

{
  options.programs.labwc.config.margin = with lib; mkOption {
    type = types.submodule {
      options = {
        top = mkOption {
          type = types.int;
          default = 0;
        };
        bottom = mkOption {
          type = types.int;
          default = 0;
        };
        left = mkOption {
          type = types.int;
          default = 0;
        };
        right = mkOption {
          type = types.int;
          default = 0;
        };
        output = mkOption {
          type = types.str;
          default = "";
        };
      };
    };
    default = {
      top = 0;
      bottom = 0;
      left = 0;
      right = 0;
      output = "";
    };
    description = ''
      Specify the number of pixels to reserve at the edges of an output (typically a display/screen/monitor). New, maximized
      and tiled windows will not be placed in these areas. The use-case for <margin> is as a workaround for clients such as
      panels that do NOT support the wlr-layer-shell protocol.

      output is optional; if this attribute is not provided (rather than leaving it an empty string) the margin will be applied
      to all outputs.
    '';
  };
}
