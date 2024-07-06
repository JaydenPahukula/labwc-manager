# https://labwc.github.io/labwc-config.5.html#focus

{ lib, ... }:

{
  options.programs.labwc.config.focus = with lib; {
    followMouse = mkOption {
      type = types.bool;
      default = false;
      description = "Make focus follow mouse, i.e. focus is given to window under mouse cursor. Default is no.";
    };
    followMouseRequiresMovement = mkOption {
      type = types.bool;
      default = true;
      description = "Requires cursor movement if followMouse is enabled. It is the same as the \"underMouse\" setting in
      Openbox. If set to \"no\", labwc will additionally focus the window under the cursor in all situations which change
      the position of a window (e.g. switching workspaces, opening/closing windows). Focusing a different window via
      A-Tab is still possible, even with this setting set to \"no\". Default is yes.";
    };
    raiseOnFocus = mkOption {
      type = types.bool;
      default = false;
      description = "Raise window to top when focused. Default is no.";
    };
  };
}
