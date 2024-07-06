# ~/.config/labwc/environment

{ config, lib, ... }:

with lib; {

  options.programs.labwc.environment = mkOption {
    type = types.attrsOf types.str;
    default = {};
    description = "Set environment variables";
  };

  config = mkIf (config.programs.labwc.enable && (length config.programs.labwc.environment) > 0) {
    xdg.configFile."labwc/environment".text = ''
      # labwc environment file
      ${concatStringsSep "\n" (mapAttrsToList (name: value: "${name}=${value}") config.programs.labwc.environment)}
    '';
  };
  
}
