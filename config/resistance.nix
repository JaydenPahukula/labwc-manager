# https://labwc.github.io/labwc-config.5.html#resistance

{ lib, ... }:

{
  options.programs.labwc.config.resistance = with lib; mkOption {
    type = types.submodule {
      options = {
        screenEdgeStrength = mkOption {
          type = types.int;
          default = 20;
        };
        windowEdgeStrength = mkOption {
          type = types.int;
          default = 20;
        };
      };
    };
    default = {
      screenEdgeStrength = 20;
      windowEdgeStrength = 20;
    };
    description = ''
      Resist interactive moves and resizes of a window across screen edges or the edges of any other window, respectively.

      When an edge strength is positive, it indicates a distance, in pixels, that the cursor must move past any relevant
      encountered edge before an interactive move or resize operation will continue across that edge.

      When the strength is negative, any interactive move or resize operation that brings the cursor within the absolute
      value of the specified distance, in pixels, from any relevant edge will snap the operation to that edge. Thus, as a
      move or resize approaches an edge, it will "attract" the cursor to that edge within the specified distance. As the
      move or resize continues past the edge, it will provide resistance until the cursor has moved beyond the distance.

      A strength of zero disables the corresponding resistance effect.

      The default value for both parameters is 20 pixels.
    '';
  };
}
