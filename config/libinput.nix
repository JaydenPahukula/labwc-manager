# https://labwc.github.io/labwc-config.5.html#libinput

{ lib, ... }:

{
  options.programs.labwc.config.libinput = with lib; mkOption {
    type = types.attrsOf (types.submodule {
      options = {
        naturalScroll = mkOption {
          type = types.nullOr types.bool;
          default = null;
          description = "Use natural scrolling for this category if available.";
        };
        leftHanded = mkOption {
          type = types.nullOr types.bool;
          default = null;
          description = "Use your devices left-handed mode if available.";
        };
        pointerSpeed = mkOption {
          type = types.nullOr (types.numbers.between (-1.0) 1.0);
          default = null;
          description = "Set the pointer speed for this category. The speed is a number between -1.0 and 1.0, with
            0.0 being the default in most cases, and 1.0 being the fastest.";
        };
        accelProfile = mkOption {
          type = types.nullOr (types.enum [ "flat" "adaptive" ]);
          default = null;
          description = "Set the pointer's acceleration profile for this category. Flat applies no acceleration (the
            pointers velocity is constant), while adaptive changes the pointers speed based the actual speed of your
            mouse or finger on your touchpad.";
        };
        tap = mkOption {
          type = types.bool;
          default = true;
          description = "Enable or disable tap-to-click for this category. This is enabled by default for all
            categories.";
        };
        tapButtonMap = mkOption {
          type = types.nullOr (types.enum [ "lrm" "lmr" ]);
          default = null;
          description = "Set the buttons mapped to one-, two-, and three-finger taps to the left button, right
            button, and middle button, respectively (lrm) (the default), or to left button, middle button, and right
            button (lmr).";
        };
        tapAndDrag = mkOption {
          type = types.nullOr types.bool;
          default = null;
          description = "Enable or disable tap-and-drag for this category. Tap-and-drag processes a tap immediately
            followed by a finger down as the start of a drag.";
        };
        dragLock = mkOption {
          type = types.nullOr types.bool;
          default = null;
          description = "Enable or disable drag lock for this category. Drag lock ignores a momentary release of a
            finger during tap-and-dragging.";
        };
        middleEmulation = mkOption {
          type = types.nullOr types.bool;
          default = null;
          description = "Enable or disable middle button emulation for this category. Middle emulation processes a
            simultaneous left and right click as a press of the middle mouse button (scroll wheel).";
        };
        disableWhileTyping = mkOption {
          type = types.nullOr types.bool;
          default = null;
          description = "Enable or disable disable while typing for this category. DWT ignores any motion events
            while a keyboard is typing, and for a short while after as well.";
        };
        clickMethod = mkOption {
          type = types.nullOr (types.enum [ "none" "buttonAreas" "clickFinger" ]);
          default = null;
          description = ''
            Configure the method by which physical clicks on a touchpad are mapped to mouse-button events.

            The click methods available are:
              - buttonAreas - The bottom of the touchpad is divided into distinct regions corresponding to left,
                middle and right buttons; clicking within the region will trigger the corresponding event. Clicking
                the main area further up produces a left button event.
              - clickfinger - Clicking with one, two or three finger(s) will produce left, right or middle button
                event without regard to the location of a click.
              - none - Physical clicks will not produce button events.

            The default method depends on the touchpad hardware.
          '';
        };
        sendEventsMode = mkOption {
          type = types.nullOr (types.enum [ true false "disabledOnExternalMouse" ]);
          default = null;
          description = ''
            Optionally enable or disable sending any device events.

            The options available are:
              - yes - Events are sent as usual
              - no - No events are sent from this device
              - disabledOnExternalMouse - This device does not send events if an external mouse has been detected.

            It is possible to prevent events from a device in the config and then do a Reconfigure to temporarily enable / disable specific devices.

            By default, this setting is not configured.
          '';
        };
        calibrationMatrix = mkOption {
          type = types.nullOr (types.addCheck (types.listOf types.float) (x: (length x) == 6));
          default = null;
          description = ''
            Apply the 3x3 transformation matrix to absolute device coordinates. This matrix has no effect on relative events.

            Given a 6-element array [a b c d e f], the matrix is applied as
              [ a  b  c ]   [ x ]
              [ d  e  f ] * [ y ]
              [ 0  0  1 ]   [ 1 ]

            The most common matrices are:
              90 deg cw:      180 deg cw:     270 deg cw:     reflect along y axis:
              [ 0 -1 1]       [ -1  0 1]      [  0 1 0 ]      [ -1 0 1 ]
              [ 1  0 0]       [  0 -1 1]      [ -1 0 1 ]      [  1 0 0 ]
              [ 0  0 1]       [  0  0 1]      [  0 0 1 ]      [  0 0 1 ]
            
            visit https://wayland.freedesktop.org/libinput/doc/latest/absolute-axes.html#calibration-of-absolute-devices for more information.
          '';
        };
      };
    });
    default = {
      default = {};
    };
    description = ''
      Define a new libinput configuration category (profile).

      CATEGORY Defines a category of devices (by type or name) to apply the settings that follow. The category attribute
      as optional. If no category attribute is provided, a 'default' device profile will created that will act as the
      fallback for all libinput devices. Category can be set to any of the following types:
      
        - touch - Devices which have a defined width/height, but do not support multitouch (i.e. they cannot track
          multiple locations where the screen has been touched). Drawing tablets typically fall into this type.
        - touchpad - Same as 'touch' but support multitouch. This typically includes laptop track pads with two-finger
          scroll and swipe gestures.
        - non-touch - Anything not described above, for example traditional mouse pointers.
        - default - Defines a device-category applicable to all devices not matched by anything else. This can be useful
          for a fallback, or if you want the same settings to be applied to all devices.
      
      If the provided category value is different from all of the above key words, it will be used to match the device
      name directly.

      A list of device names can be obtained by running libinput list-devices (you may need to be root or a part of the
      input group to perform this).
    '';
  };
}
