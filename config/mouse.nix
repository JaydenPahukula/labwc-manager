# https://labwc.github.io/labwc-config.5.html#mouse

{ lib, ... }:

{
  options.programs.labwc.config.mouse = with lib; {
    doubleClickTime = mkOption {
      type = types.int;
      default = 500;
      description = "Set double click time in milliseconds. Default is 500.";
    };
    scrollFactor = mkOption {
      type = types.float;
      default = 1.0;
      description = "Set scroll factor. Default is 1.0.";
    };
    mousebinds = mkOption {
      type = types.attrsOf (types.listOf (types.submodule {
        options = {
          button = mkOption {
            type = types.enum [ "" "Left" "Middle" "Right" "Side" "Extra" "Forward" "Back" "Task" ]; 
            default = "";
          };
          direction = mkOption {
            type = types.enum [ "" "Up" "Down" "Left" "Right" ];
            default = "";
          };
          action = mkOption {
            type = types.enum [ "" "Press" "Release" "Click" "DoubleClick" "Drag" "Scroll" ];
            default = "";
          };
          actions = mkOption {
            type = with types; listOf (addCheck (attrsOf (either str bool)) (x: hasAttr "name" x));
            default = [];
          };
        };
      }));
      default = {
        TitleBar = [
          { button="Left"; action="Press"; actions=[
            { name="Focus"; }
            { name="Raise"; }
          ];}
          { button="Right"; action="Click"; actions = [
            { name="Focus"; }
            { name="Raise"; }
          ];}
          { direction="Up"; action="Scroll"; actions = [
            { name="Unshade"; }
            { name="Focus"; }
          ];}
          { direction="Down"; action="Scroll"; actions = [
            { name="Unshade"; }
            { name="Focus"; }
          ];}
        ];
        Title = [
          { button="Left"; action="Drag"; actions = [
            { name="Move"; }
          ];}
          { button="Left"; action="DoubleClick"; actions = [
            { name="ToggleMaximize"; }
          ];}
          { button="Right"; action="Click"; actions = [
            { name="ShowMenu"; menu="client_menu"; }
          ];}
        ];
        Maximize = [
          { button="Left"; action="Click"; actions = [
            { name="ToggleMaximize"; }
          ];}
          { button="Right"; action="Click"; actions = [
            { name="ToggleMaximize"; direction="horizontal"; }
          ];}
          { button="Middle"; action="Click"; actions = [
            { name="ToggleMaximize"; direction="vertical"; }
          ];}
        ];
        WindowMenu = [
          { button="Left"; action="Click"; actions = [
            { name="ShowMenu"; menu="client_menu"; }
          ];}
          { button="Right"; action="Click"; actions = [
            { name="ShowMenu"; menu="client_menu"; }
          ];}
        ];
        Iconify = [
          { button="Left"; action="Click"; actions = [
            { name="Iconify"; }
          ];}
        ];
        Close = [
          { button="Left"; action="Click"; actions = [
            { name="Close"; }
          ];}
        ];
        Client = [
          { button="Left"; action="Press"; actions = [
            { name="Focus"; }
            { name="Raise"; }
          ];}
          { button="Middle"; action="Press"; actions = [
            { name="Focus"; }
            { name="Raise"; }
          ];}
          { button="Right"; action="Press"; actions = [
            { name="Focus"; }
            { name="Raise"; }
          ];}
        ];
        Root = [
          { button="Left"; action="Press"; actions = [
            { name="ShowMenu"; menu="root_menu"; }
          ];}
          { button="Right"; action="Press"; actions = [
            { name="ShowMenu"; menu="root_menu"; }
          ];}
          { button="Middle"; action="Press"; actions = [
            { name="ShowMenu"; menu="root_menu"; }
          ];}
          { direction="Up"; action="Scroll"; actions = [
            { name="GoToDesktop"; to="left"; wrap=true; }
          ];}
          { direction="Down"; action="Scroll"; actions = [
            { name="GoToDesktop"; to="right"; wrap=true; }
          ];}
        ];
      };
      description = ''
        Multiple <mousebind> can exist within one <context>; and multiple <action> can exist within one <mousebind>.

        Define a mouse binding. Supported context-names include:
          - TitleBar: The decoration on top of the window, where the window buttons and the window title are shown.
          - Title: The area of the titlebar (including blank space) between the window buttons, where the window title is displayed.
          - WindowMenu: The button on the left.
          - Iconify: The button that looks like an underline.
          - Maximize: The button that looks like a box.
          - Close: The button that looks like an X.
          - Top: The top edge of the window's border.
          - Bottom: The bottom edge of the window's border.
          - Left: The left edge of the window's border.
          - Right: The right edge of the window's border.
          - TRCorner: The top-right corner of the window's border.
          - TLCorner: The top-left corner of the window's border.
          - BLCorner: The bottom-left corner of the window's border.
          - BRCorner: The bottom-right edge of the window's border.
          - Client: The client area of a window, inside its decorations. Events bound to Client are also passed to applications.
          - Frame: Any part of a window, but events bound to Frame are not passed through to the application.
          - Desktop: The desktop background, where no windows are present.
          - Root: A synonym for Desktop (for compatibility).
          - All: Anywhere on the screen.
        
        Supported mouse buttons are:
          - Left
          - Middle
          - Right
          - Side
          - Extra
          - Forward
          - Back
          - Task
        
        Supported scroll directions are:
          - Up
          - Down
          - Left
          - Right
        
        Mouse buttons and directions can be combined with modifier-keys (shift (S), super/logo (W), control (C), alt (A),
        meta (M) and hyper (H)), for example: <mousebind button="A-Right" action="Press">

        Supported mouse actions include:
          - Press: Pressing the specified button down in the context.
          - Release: Releasing the specified button in the context.
          - Click: Pressing and then releasing inside of the the context.
          - DoubleClick: Two presses within the doubleClickTime.
          - Drag: Pressing the button within the context, then moving the cursor.
          - Scroll: Scrolling in specified direction in the context.
      '';
    };
    default = mkOption {
      type = types.bool;
      default = false;
      description = "Load default mousebinds. This is an addition to the openbox specification and provides a way to keep
        config files simpler whilst allowing user specific binds. Note that if no rc.xml is found, or if no <mouse><mousebind>
        entries exist, the same default mousebinds will be loaded even if the <default /> element is not provided.";
    };
  };
}
