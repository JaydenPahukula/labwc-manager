# ~/.config/labwc/autostart

{ config, lib, ... }:

with lib; {

  options.programs.labwc.autostart = mkOption {
    type = types.listOf types.str;
    default = [
      "swaybg -c '#113344'"
      "kanshi"
      "waybar"
      "mako"
      "swayidle -w
        timeout 300 'swaylock -f -c 000000'
        timeout 600 'wlopm --off \*'
        resume 'wlopm --on \*'
        before-sleep 'swaylock -f -c 000000'"
    ];
    description = "Commands to execute on startup. All commands are piped to /dev/null";
  };

  config = mkIf (config.programs.labwc.enable && (length config.programs.labwc.autostart) > 0) {
    xdg.configFile."labwc/autostarttest".text = ''
      # labwc autostart file
      ${concatMapStrings (s: s+" >/dev/null 2>&1 &\n") config.programs.labwc.autostart}
    '';
  };
  
}
