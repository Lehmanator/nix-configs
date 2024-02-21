{ inputs
, ...
}:
{

  # TODO: Compare neogit vs. fugitive
  plugins.neogit = {
    enable = true;
    autoRefresh = true;
    integrations.diffview = true;

    #commitPopup.kind = null;
    #disableBuiltinNotifications = null; disableCommitConfirmation = null; disableContextHighlighting = null;
    #disableHint = null;                 disableSigns = null;
    #kind = null;
    #mappings.status = null;
    #useMagitKeybindings = null;
  };

}
