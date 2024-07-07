# ~/.config/labwc/menu.xml
# WIP - does not work! make your own menu.xml!

{ config, lib, ... }:

with lib; {

  options.programs.labwc.menus = mkOption {
    type = types.attrsOf (types.listOf (types.addCheck (types.attrsOf types.str) (x: hasAttr "actionName" x)));
    default = {};
    description = "Set environment variables";
  };

}
