{ config, ... }:
{
  plugins.yanky = {
    highlight = {onPut = true; onYank = true;};
    #picker.select.action = "put('p')";
    picker = {
      telescope = {
        enable = true;
        #mappings = {};
        useDefaultMappings = true;
      };
    };
    preserveCursorPosition.enabled = true;
    ring = {
      #cancelEvent = "update";
      storage = "shada"; # shada|memory|sqlite
      syncWithNumberedRegisters = true;
      updateRegisterOnCycle = false;
    };
    systemClipboard.syncWithRing = true;
    textobj.enabled = true;

  };
}
