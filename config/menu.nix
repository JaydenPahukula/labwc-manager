# https://labwc.github.io/labwc-config.5.html#menu

{ lib, ... }:

{
  options.programs.labwc.config.menu.ignoreButtonReleasePeriod = with lib; mkOption {
    type = types.int;
    default = 250;
    description = "How long (in milliseconds) the initial button release event is ignored for. The reason for
      this logic and behaviour is to avoid a fast press-move-release sequence indended to just open the menu
      resulting in the closure of the menu or the selection of (typically the first) menu item. This behaviour
      only affects the first button-release. It is not anticipated that most users will want to change this,
      but the config option has been exposed for unusual use-cases. It is equivalent to Openbox's `<hideDelay>`.
      Default is 250 ms.";
  };
}
