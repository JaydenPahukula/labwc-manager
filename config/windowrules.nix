# https://labwc.github.io/labwc-config.5.html#window_rules

{ lib, ... }:

{
  options.programs.labwc.config.windowRules = with lib; let 
    windowTypes = [
      "desktop" "dock" "toolbar" "menu" "utility" "splash" "dialog" "dropdown_menu" " popup_menu" "tooltip"
      "notification" "combo" "dnd" "normal"
    ];
  in mkOption {
    type = types.listOf (types.submodule { options = {
      criteria = mkOption {
        type = types.submodule { options = {
          identifier = mkOption {
            type = types.nullOr types.str;
            default = null;
          };
          title = mkOption {
            type = types.nullOr types.str;
            default = null;
          };
          sandboxEngine = mkOption {
            type = types.nullOr types.str;
            default = null;
          };
          sandboxAppId = mkOption {
            type = types.nullOr types.str;
            default = null;
          };
          type = mkOption {
            type = types.nullOr (types.enum windowTypes);
            default = null;
          };
          matchOnce = mkOption {
            type = types.nullOr types.bool;
            default = null;
          };
        };};
        description = ''
          Define a window rule for any window which matches the criteria defined by the attributes identifier, title,
          or type. If more than one is defined, AND logic is used, so all have to match. Matching against patterns
          with '*' (wildcard) and '?' (joker) is supported. Pattern matching is case-insensitive.

          - identifier relates to app_id for native Wayland windows and WM_CLASS for XWayland clients.
          - title is the title of the window.
          - sandboxEngine is a sandbox engine name from the security context.
          - sandboxAppId is a sandbox-specific identifier for an application from the security context.
          - type [desktop|dock|toolbar|menu|utility|splash|dialog|dropdown_menu|popup_menu|tooltip|notification|combo
            |dnd|normal] relates to NET_WM_WINDOW_TYPE for XWayland clients. Native wayland clients have type "dialog"
            when they have a parent or a fixed size, or "normal" otherwise.
          - matchOnce can be true|false. If true, the rule will only apply to the first instance of the window with
            the specified identifier or title.
        '';
      };
      properties = mkOption {
        type = types.submodule { options = {
          serverDecoration = mkOption {
            type = types.nullOr (types.enum [ true false "default" ]);
            default = null;
          };
          skipTaskbar = mkOption {
            type = types.nullOr (types.enum [ true false "default" ]);
            default = null;
          };
          skipWindowSwitcher = mkOption {
            type = types.nullOr (types.enum [ true false "default" ]);
            default = null;
          };
          ignoreFocusRequest = mkOption {
            type = types.nullOr (types.enum [ true false "default" ]);
            default = null;
          };
          ignoreConfigureRequest = mkOption {
            type = types.nullOr (types.enum [ true false "default" ]);
            default = null;
          };
          fixedPosition = mkOption {
            type = types.nullOr (types.enum [ true false "default" ]);
            default = null;
          };
        };};
        default = {};
        description = ''
          Property values can be yes, no or default.

          If a window matches criteria for multiple rules which set the same property, later config entries have higher
          priority. default can be useful in this situation.

          - serverDecoration over-rules any other setting for server-side window decoration on first map.
          - skipTaskbar removes window foreign-toplevel protocol handle so that it does not appear in clients such as
            panels and taskbars using that protocol.
          - skipWindowSwitcher removes window from the Window Switcher (alt-tab on-screen-display).
          - ignoreFocusRequest prevents window to activate itself.
          - ignoreConfigureRequest prevents a X11 window to position and size itself.
          - fixedPosition disallows interactive move/resize and prevents re-positioning in response to changes in reserved
            output space, which can be caused by <margin> settings or exclusive layer-shell clients such as panels.
        '';
      };
      actions = mkOption {
        type = types.listOf (types.addCheck (types.attrsOf types.str) (x: hasAttr "name" x));
        default = [];
      };
    };});
    default = []; 
  };
}
