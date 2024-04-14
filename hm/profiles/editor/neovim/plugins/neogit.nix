{ inputs
, config
, ...
}:
{

  # TODO: Compare neogit vs. fugitive
  programs.nixvim.plugins.neogit = {
    enable = true;
    autoRefresh = true;
    integrations.diffview = config.programs.nixvim.plugins.diffview.enable;

    #commitPopup.kind = null;
    #disableBuiltinNotifications = null; disableCommitConfirmation = null; disableContextHighlighting = null;
    #disableHint = null;                 disableSigns = null;
    #kind = null;
    #mappings.status = null;
    #useMagitKeybindings = null;
  };

}
