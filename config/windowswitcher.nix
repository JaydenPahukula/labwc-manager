# https://labwc.github.io/labwc-config.5.html#margin

{ lib, ... }:

{
  options.programs.labwc.config.windowSwitcher = with lib; {
    show = mkOption {
      type = types.bool;
      default = true;
      description = "Draw the OnScreenDisplay when switching between windows. Default is yes.";
    };
    preview = mkOption {
      type = types.bool;
      default = true;
      description = "Preview the contents of the selected window when switching between windows. Default is yes.";
    };
    outlines = mkOption {
      type = types.bool;
      default = true;
      description = "Draw an outline around the selected window when switching between windows. Default is yes.";
    };
    allWorkspaces = mkOption {
      type = types.bool;
      default = false;
      description = "Show windows regardless of what workspace they are on. Default no (that is only windows on the current
        workspace are shown).";
    };
    fields = mkOption {
      type = types.listOf (types.submodule {
        options = {
          content = mkOption {
            type = types.enum [ "type" "identifier" "trimmed_identifier" "title" "workspace" "state" "type_short" "output" "custom" ];
            description = ''
              content defines what the field shows and can be any of:
                - type - Show view type ("xdg-shell" or "xwayland")
                - identifier - Show identifier (app_id for native Wayland windows and WM_CLASS for XWayland clients)
                - trimmed_identifier - Show trimmed identifier. Trimming removes the first two nodes of 'org.' strings.
                - title - Show window title if different to app_id
                - workspace - Show workspace name
                - state Show - window state, M/m/F (max/min/full)
                - type_short - Show view type ("W" or "X")
                - output Show - output id, if more than one output detected
                - custom - A printf style config that can replace all the above fields are:
                  - 'B' - shell type, values [xwayland|xdg-shell]
                  - 'b' - shell type (short form), values [X|W]
                  - 'S' - state of window, values [M|m|F] (3 spaces allocated) (maximized, minimized, fullscreen)
                  - 's' - state of window (short form), values [M|m|F] (1 space)
                  - 'I' - wm-class/app-id
                  - 'i' - wm-class/app-id trimmed, remove "org." if available
                  - 'W' - workspace name
                  - 'w' - workspace name (if more than 1 ws configured)
                  - 'O' - output name
                  - 'o' - output name (show if more than 1 monitor active)
                  - 'T' - title of window
                  - 't' - title of window (if different than wm-class/app-id)
                Recommend using with a monospace font, to keep alignment.
                - custom - subset of printf options allowed -- man 3 printf
                  - random text may be inserted
                  - field length, example "%10" use 10 spaces, even if text uses less
                  - left justify text, example "%-"
                  - right justify text, example "%" instead of "%-"
                  - example, %-10 would left justify and make room for 10 characters
                  - Only one custom format allowed now. Future enhancements may allow more than one.
            '';
          };
          format = mkOption {
            type = types.str;
            default = "";
            description = "printf style format string, used when content = \"custom\".";
          };
          width = mkOption {
            type = types.addCheck types.str (s: hasSuffix "%" s);
            description = "width defines the width of the field expressed as a percentage of the overall window switcher
              width. The \"%\" character is required.";
          };
        };
      });
      default = [
        { content = "type"; width = "25%"; }
        { content = "trimmed_identifier"; width = "25%"; }
        { content = "title"; width = "50%"; }
      ];
      description = "Define window switcher fields.";
    };
  };
}
