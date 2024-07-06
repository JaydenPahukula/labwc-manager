# https://labwc.github.io/labwc-config.5.html#touch

{ lib, ... }:

{
  options.programs.labwc.config.touch = with lib; {
    deviceName = mkOption {
      type = types.str;
      default = "";
      description = "A touch configuration can be bound to a specific device. If device name is left empty, the
        touch configuration applies to all touch devices or functions as a fallback. Multiple touch configurations
        can exist. See the libinput device section for obtaining the device names.";
    };
    mapToOutput = mkOption {
      type = types.str;
      default = "";
      description = "Direct cursor movement to a specified output. If the compositor is running in nested mode,
        this does not take effect.";
    };
  };
}
