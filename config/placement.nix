# https://labwc.github.io/labwc-config.5.html#placement

{ lib, ... }:

{
  options.programs.labwc.config.placement = with lib; {
    policy = mkOption {
      type = types.enum [ "center" "automatic" "cursor" ];
      default = "center";
      description = "Specify a placement policy for new windows. The \"center\" policy will always place windows at
        the center of the active output. The \"automatic\" policy will try to place new windows in such a way that
        they will have minimal overlap with existing windows. The \"cursor\" policy will center new windows under the
        cursor. Default is \"center\".";
    };
  };
}
