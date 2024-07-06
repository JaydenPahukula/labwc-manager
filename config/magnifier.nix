# https://labwc.github.io/labwc-config.5.html#magnifier

{ lib, ... }:

{
  options.programs.labwc.config.magnifier = with lib; {
    width = mkOption {
      type = types.int;
      default = 400;
      description = "Width of magnifier window in pixels. Default is 400. Set to -1 to use fullscreen magnifier.";
    };
    height = mkOption {
      type = types.int;
      default = 400;
      description = "Height of magnifier window in pixels. Default is 400. Set to -1 to use fullscreen magnifier.";
    };
    initScale = mkOption {
      type = types.float;
      default = 2.0;
      description = "Initial number of times by which magnified image is scaled. Value is the default at boot; can be
        modified at run-time in a keyboard or mouse binding by calling 'ZoomIn' or 'ZoomOut'. Default is x2.0.";
    };
    increment = mkOption {
      type = types.float;
      default = 0.2;
      description = "Step by which magnification changes on each call to 'ZoomIn' or 'ZoomOut'. Default is 0.2.";
    };
    useFilter = mkOption {
      type = types.enum [ true false "default" ];
      default = true;
      description = "Whether to apply a bilinear filter to the magnified image, or just to use nearest-neighbour.
        Default is true - bilinear filtered.";
    };
  };
}
