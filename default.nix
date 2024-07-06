{ lib, ... }:

{
  imports = [
    ./autostart
    ./config
    ./environment
    # ./menu
  ];

  options.programs.labwc.enable = lib.mkEnableOption ''
    Enable configuration management for labwc.
  '';
}