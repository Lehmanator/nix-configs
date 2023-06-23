{ inputs
, ...
}:
{

  # TODO: Compare neogit vs. fugitive
  programs.nixvim.plugins.neogit = {
    enable = true;
    autoRefresh = true;
    #commitPopup.kind = null;
    #disableBuiltinNotifications = null; disableCommitConfirmation = null; disableContextHighlighting = null;
    #disableHint = null;                 disableSigns = null;
    integrations.diffview = true;
    #kind = null;
    #mappings.status = null;
  };

}
