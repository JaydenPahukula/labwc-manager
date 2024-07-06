# https://labwc.github.io/labwc-config.5.html#window_snapping

{ lib, ... }:

{
  options.programs.labwc.config.snapping = with lib; {
    range = mkOption {
      type = types.int;
      default = 1;
      description = "If an interactive move ends with the cursor a maximum distance range, (in pixels) from the
        edge of an output, the move will trigger a SnapToEdge action for that edge. A range of 0 disables snapping
        via interactive moves. Default is 1.";
    };
    overlay = {
      enabled = mkOption {
        type = types.bool;
        default = true;
        description = "Show an overlay when snapping to a window to an edge. Default is yes.";
      };
      delay = mkOption {
        type = types.submodule {
          options = {
            inner = mkOption {
              type = types.int;
              default = 500;
            };
            outer = mkOption {
              type = types.int;
              default = 500;
            };
          };
        };
        default = {
          inner = 500;
          outer = 500;
        };
        description = "Sets the delay to show an overlay when snapping a window to each type of edge. Defaults
          are 500 ms. inner edges are edges with an adjacent output and outer edges are edges without an adjacent
          output.";
      };
    };
    topMaximize = mkOption { 
      type = types.bool;
      default = true;
      description = "If yes, an interactive move that snaps a window to the top edge will maximize the window. If
        no, snapping will behave as it does with other edges, causing the window to occupy the top half of an output.
        Default is yes.";
    };
    notifyClient = mkOption {
      type = types.enum [ "always" "region" "edge" "never" ];
      default = "always";
      description = ''
        Snapping windows can trigger corresponding tiling events for native Wayland clients. Clients may use these
        events to alter their rendering based on knowledge that some edges of the view are confined to edges of a
        snapping region or output. For example, rounded corners may become square when tiled, or media players may
        letter-box or pillar-box video rather than imposing rigid aspect ratios on windows that will violate the
        constraints of window snapping.
          - When always is specified, any window that is snapped to either an output edge or a user-defined region will receive a tiling event.
          - When region is specified, only windows snapped to a user-defined region will receive an event.
          - When edge is specified, only windows snapped to an output edge will receive an event.
          - When never is specified, tiling events will never be triggered.
        The default is "always".
      '';
    };
  };
}
