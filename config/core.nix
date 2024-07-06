# https://labwc.github.io/labwc-config.5.html#core

{ lib, ... }:

{
  options.programs.labwc.config.core = with lib; {
    decoration = mkOption {
      type = types.enum [ "server" "client" ];
      default = "server";
      description = "Specify server or client side decorations for xdg-shell views. Note that it is not always possible
        to turn off client side decorations. Default is server.";
    };
    gap = mkOption {
      type = types.int;
      default = 0;
      description = "The distance in pixels between views and output edges when using movement actions, for example
        MoveToEdge. Default is 0.";
    };
    adaptiveSync = mkOption {
      type = types.enum [ true false "fullscreen" ];
      default = false;
      description = "Enable adaptive sync. Default is no. fullscreen enables adaptive sync whenever a window is in
        fullscreen mode.";
    };
    allowTearing = mkOption {
      type = types.bool;
      default = false;
      description = "Allow tearing to reduce input lag. Default is no. This option requires setting the environment
        variable WLR_DRM_NO_ATOMIC=1. yes allow tearing if requested by the active window.";
    };
    reuseOutputMode = mkOption {
      type = types.bool;
      default = false;
      description = "Try to re-use the existing output mode (resolution / refresh rate). This may prevent unnecessary
        screenblank delays when starting labwc (also known as flicker free boot). If the existing output mode can not be
        used with labwc the preferred mode of the monitor is used instead. Default is no.";
    };
  };
}
