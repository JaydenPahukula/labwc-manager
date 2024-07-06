# https://labwc.github.io/labwc-config.5.html#resize

{ lib, ... }:

{
  options.programs.labwc.config.resize = with lib; {
    popupShow = mkOption {
      type = types.enum [ "Never" "Always" "Nonpixel" ];
      default = "Never";
      description = ''
        Show a small indicator on top of the window when resizing or moving. When the application sets size-hints
        (usually X11 terminal emulators), the indicator will show the dimensions divided by size hints instead. In
        the case of terminal emulators this usually means columns x rows.

        The different values mean:
          - Never - Do not render the indicator
          - Always - Render the indicator while moving and resizing windows
          - Nonpixel - Only render the indicator during resize for windows using size-hints
        
        Default is Never.
      '';
    };
  };
}
