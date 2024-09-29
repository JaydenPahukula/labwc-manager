# ~/.config/labwc/rc.xml

{ config, lib, ... }:

{
  imports = [
    ./core.nix
    ./desktops.nix
    ./focus.nix
    ./keyboard.nix
    ./libinput.nix
    ./magnifier.nix
    ./margin.nix
    ./menu.nix
    ./mouse.nix
    ./placement.nix
    ./regions.nix
    ./resistance.nix
    ./resize.nix
    ./snapping.nix
    ./tablet.nix
    ./theme.nix
    ./touch.nix
    ./windowrules.nix
    ./windowswitcher.nix
  ];

  config = with lib; mkIf (config.programs.labwc.enable) {
    xdg.configFile."labwc/rc.xml".text = let
      
      # functions for pretty formatting
      toStr = obj:
        if isBool obj && obj
          then "true"
        else if isBool obj
          then "false"
        else toString obj;
      space = n: strings.fixedWidthString n " " "";
      indent = num: s: removeSuffix (space num) (stringAsChars (c:
        if c == "\n"
          then "\n"+(space num)
        else c
      ) s);
      formatAction = action: "<action name=\"${action.name}\" ${concatMapStrings
        (x: "${x.name}=\"${toStr x.value}\" ")
        (mapAttrsToList (n: v: {name=n;value=v;}) (filterAttrs (n: v: n != "name") action))
      }/>";
      formatList = f: list: removeSuffix "\n" (concatMapStrings f list);

      cfg = config.programs.labwc.config;

    # too many edge cases to do this programatically (skill issue ik)
    in ''
      <?xml version="1.0"?>
      <labwc_config>
        <core>
          <decoration>${toStr cfg.core.decoration}</decoration>
          <gap>${toStr cfg.core.gap}</gap>
          <adaptiveSync>${toStr cfg.core.adaptiveSync}</adaptiveSync>
          <allowTearing>${toStr cfg.core.allowTearing}</allowTearing>
          <reuseOutputMode>${toStr cfg.core.reuseOutputMode}</reuseOutputMode>
        </core>
        <placement>
          <policy>${toStr cfg.placement.policy}</policy>
        </placement>
        <theme>
          <name>${toStr cfg.theme.name}</name>
          <cornerRadius>${toStr cfg.theme.cornerRadius}</cornerRadius>
          <keepBorder>${toStr cfg.theme.keepBorder}</keepBorder>
          <dropShadows>${toStr cfg.theme.dropShadows}</dropShadows>
          ${indent 4 (formatList (x: ''
            <font place="${toStr x.place}">
              <name>${toStr x.name}</name>
              <size>${toStr x.size}</size>
              <slant>${toStr x.slant}</slant>
              <weight>${toStr x.weight}</weight>
            </font>
          '') cfg.theme.fonts)}
        </theme>
        <windowSwitcher>
          <show>${toStr cfg.windowSwitcher.show}</show>
          <preview>${toStr cfg.windowSwitcher.preview}</preview>
          <outlines>${toStr cfg.windowSwitcher.outlines}</outlines>
          <allWorkspaces>${toStr cfg.windowSwitcher.allWorkspaces}</allWorkspaces>
          <fields>
            ${indent 6 (formatList (x: ''
              <field>
                <content>${toStr x.content}</content>
                <format>${toStr x.format}</format>
                <width>${toStr x.width}</width>
              </field>
            '') cfg.windowSwitcher.fields)}
          </fields>
        </windowSwitcher>
        <resistance>
          <screenEdgeStrength>${toStr cfg.resistance.screenEdgeStrength}</screenEdgeStrength>
          <windowEdgeStrength>${toStr cfg.resistance.windowEdgeStrength}</windowEdgeStrength>
        </resistance>
        <resize>
          <popupShow>${toStr cfg.resize.popupShow}</popupShow>
        </resize>
        <focus>
          <followMouse>${toStr cfg.focus.followMouse}</followMouse>
          <followMouseRequiresMovement>${toStr cfg.focus.followMouseRequiresMovement}</followMouseRequiresMovement>
          <raiseOnFocus>${toStr cfg.focus.raiseOnFocus}</raiseOnFocus>
        </focus>
        <snapping>
          <range>${toStr cfg.snapping.range}</range>
          <overlay>
            <enabled>${toStr cfg.snapping.overlay.enabled}</enabled>
            <delay>
              <inner>${toStr cfg.snapping.overlay.delay.inner}</inner>
              <outer>${toStr cfg.snapping.overlay.delay.outer}</outer>
            </delay>
          </overlay>
          <topMaximize>${toStr cfg.snapping.topMaximize}</topMaximize>
          <notifyClient>${toStr cfg.snapping.notifyClient}</notifyClient>
        </snapping>
        <desktops>
          <popupTime>${toStr cfg.desktops.popupTime}</popupTime>
          <names>
            ${indent 6 (formatList (x: ''
              <name>${toStr x}</name>
            '') cfg.desktops.names)}
          </names>
          <number>${toStr cfg.desktops.number}</number>
        </desktops>
        <regions>
          ${indent 4 (formatList (x: ''
            <region>
              <name>${toStr x.name}</name>
              <x>${toStr x.x}</x>
              <y>${toStr x.y}</y>
              <height>${toStr x.height}</height>
              <width>${toStr x.width}</width>
            </region>
          '') cfg.regions)}
        </regions>
        <keyboard>
          <numlock>${toStr cfg.keyboard.numlock}</numlock>
          <layoutScope>${toStr cfg.keyboard.layoutScope}</layoutScope>
          <repeatRate>${toStr cfg.keyboard.repeatRate}</repeatRate>
          <repeatDelay>${toStr cfg.keyboard.repeatDelay}</repeatDelay>
          ${indent 4 (formatList (x: ''
            <keybind key="${toStr x.key}" layoutDependent="${toStr x.layoutDependent}" onRelease="${toStr x.onRelease}" allowWhenLocked="${toStr x.allowWhenLocked}">
              ${indent 2 (formatList (y: ''
                <action name="${toStr y.name}">
                  ${indent 2 (formatList (z: ''
                    <${z.name}>${toStr z.value}</${z.name}>
                  '') (mapAttrsToList (n: v: {name=n;value=v;}) (filterAttrs (n: v: n != "name") y)))}
                </action>
              '') x.actions)}
            </keybind>
          '') cfg.keyboard.keybinds)}${if cfg.keyboard.default then "\n    <default/>" else ""}
        </keyboard>
        <mouse>
          <doubleClickTime>${toStr cfg.mouse.doubleClickTime}</doubleClickTime>
          <scrollFactor>${toStr cfg.mouse.scrollFactor}</scrollFactor>
          ${if cfg.mouse.default then "<default/>" else ""}
          ${indent 4 (formatList (x: ''
            <context name="${toStr x.name}">
              ${indent 2 (formatList (y: ''
                <mousebind button="${toStr y.button}" direction="${toStr y.direction}" action="${toStr y.action}">
                ${formatList (z: "  ${formatAction z}\n") y.actions}
                </mousebind>
              '') x.value)}
            </context>
          '') (mapAttrsToList (n: v: {name=n;value=v;}) cfg.mouse.mousebinds))}
        </mouse>
        <touch deviceName="${toStr cfg.touch.deviceName}" mapToOutput="${toStr cfg.touch.mapToOutput}" />
        <tablet>
          <mapToOutput>${toStr cfg.tablet.mapToOutput}</mapToOutput>
          <rotate>${toStr cfg.tablet.rotate}</rotate>
          <mouseEmulation>${toStr cfg.tablet.mouseEmulation}</mouseEmulation>
          <area>
            <top>${toStr cfg.tablet.area.top}</top>
            <left>${toStr cfg.tablet.area.left}</left>
            <width>${toStr cfg.tablet.area.width}</width>
            <height>${toStr cfg.tablet.area.height}</height>
          </area>
          ${indent 4 (formatList (x: ''
            <map button="${toStr x.button}" to="${toStr x.to}" />
          '') (mapAttrsToList (name: value: {button=name;to=value;}) cfg.tablet.map))}
        </tablet>
        <libinput>
          ${indent 4 (formatList (x: ''
            <device category="${x.category}">
              <naturalScroll>${toStr x.vals.naturalScroll}</naturalScroll>
              <leftHanded>${toStr x.vals.leftHanded}</leftHanded>
              <pointerSpeed>${toStr x.vals.pointerSpeed}</pointerSpeed>
              <accelProfile>${toStr x.vals.accelProfile}</accelProfile>
              <tap>${toStr x.vals.tap}</tap>
              <tapButtonMap>${toStr x.vals.tapButtonMap}</tapButtonMap>
              <tapAndDrag>${toStr x.vals.tapAndDrag}</tapAndDrag>
              <dragLock>${toStr x.vals.dragLock}</dragLock>
              <middleEmulation>${toStr x.vals.middleEmulation}</middleEmulation>
              <disableWhileTyping>${toStr x.vals.disableWhileTyping}</disableWhileTyping>
              <clickMethod>${toStr x.vals.clickMethod}</clickMethod>
              <sendEventsMode>${toStr x.vals.sendEventsMode}</sendEventsMode>
              <calibrationMatrix>${toStr x.vals.calibrationMatrix}</calibrationMatrix>
            </device>
          '') (mapAttrsToList (name: value: {category=name;vals=value;}) cfg.libinput))}
        </libinput>
        <windowRules>
          ${indent 4 (formatList (x: ''
            <windowRule identifier="${toStr x.criteria.identifier}" title="${toStr x.criteria.title}" sandboxEngine="${toStr x.criteria.sandboxEngine}" sandboxAppId="${toStr x.criteria.sandboxAppId}" type="${toStr x.criteria.type}" matchOnce="${toStr x.criteria.matchOnce}">
              <serverDecoration>${toStr x.properties.serverDecoration}</serverDecoration>
              <skipTaskbar>${toStr x.properties.skipTaskbar}</skipTaskbar>
              <skipWindowSwitcher>${toStr x.properties.skipWindowSwitcher}</skipWindowSwitcher>
              <ignoreFocusRequest>${toStr x.properties.ignoreFocusRequest}</ignoreFocusRequest>
              <ignoreConfigureRequest>${toStr x.properties.ignoreConfigureRequest}</ignoreConfigureRequest>
              <fixedPosition>${toStr x.properties.fixedPosition}</fixedPosition>
              ${formatList (y: "${formatAction y}\n") x.actions}
            </windowRule>
          '') cfg.windowRules )}
        </windowRules>
        <menu>
          <ignoreButtonReleasePeriod>${toStr cfg.menu.ignoreButtonReleasePeriod}</ignoreButtonReleasePeriod>
        </menu>
        <magnifier>
          <width>${toStr cfg.magnifier.width}</width>
          <height>${toStr cfg.magnifier.height}</height>
          <initScale>${toStr cfg.magnifier.initScale}</initScale>
          <increment>${toStr cfg.magnifier.increment}</increment>
          <useFilter>${toStr cfg.magnifier.useFilter}</useFilter>
        </magnifier>
      </labwc_config>
    '';
  };
}
