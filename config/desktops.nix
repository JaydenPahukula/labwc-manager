# https://labwc.github.io/labwc-config.5.html#workspaces

{ lib, ... }:

{
  options.programs.labwc.config.desktops = with lib; {
    number = mkOption {
      type = types.nullOr types.int;
      default = 1;
      description = "The number attribute defines the minimum number of workspaces. Default is 1. The number attribute is optional. If the number attribute
        is specified, names.name is not required.";
    };
    names = mkOption {
      type = types.listOf types.str;
      default = [ "Default" ];
      description = "Specify the names of workspaces";
    };
    popupTime = mkOption {
      type = types.int;
      default = 1000;
      description = "Define the timeout after which to hide the workspace OSD. A setting of 0 disables the OSD. Default is 1000 ms.";
    };
    prefix = mkOption {
      type = types.str;
      default = "Workspace";
      description = "Set the prefix to use when using \"number\" above. Default is \"Workspace\"";
    };
  };
}
