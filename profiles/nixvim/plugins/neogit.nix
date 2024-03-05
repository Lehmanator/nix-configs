{
  inputs,
  config,
  ...
}: {
  # TODO: Compare neogit vs. fugitive
  plugins.neogit = {
    enable = true;
    settings = {
      autoRefresh = true;
      integrations.diffview = config.plugins.diffview.enable;
    };

    #commitPopup.kind = null;
    #disableBuiltinNotifications = null; disableCommitConfirmation = null; disableContextHighlighting = null;
    #disableHint = null;                 disableSigns = null;
    #kind = null;
    #mappings.status = null;
    #useMagitKeybindings = null;
  };
}
