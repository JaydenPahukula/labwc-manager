# https://labwc.github.io/labwc-config.5.html#regions

{ lib, ... }:

{
  options.programs.labwc.config.regions = with lib; let
    percent = types.addCheck types.str (s: hasSuffix "%" s);
  in mkOption {
    type = types.listOf (types.submodule {
      options = {
        name = mkOption {
          type = types.str;
        };
        x = mkOption {
          type = percent;
        };
        y = mkOption {
          type = percent;
        };
        width = mkOption {
          type = percent;
        };
        height = mkOption {
          type = percent;
        };
      };
    });
    default = [];
    description = "Define snap regions. The regions are calculated based on the usable area of each output. Usable area
      in this context means space not exclusively used by layershell clients like panels. The \"%\" character is required.
      Windows can either be snapped to regions by keeping a keyboard modifier pressed while moving a window (Ctrl, Alt,
      Shift, Logo) or by using the SnapToRegion action. By default there are no regions defined.";
  };
}
