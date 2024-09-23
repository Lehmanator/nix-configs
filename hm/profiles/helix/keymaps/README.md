# Helix Keybindings

[Helix Docs](https://docs.helix-editor.com/keymap.html)

Options: `programs.helix.settings.keys.<mode>.<key> = <action>...;`

## Key Names

### Modifier Keys

CTRL:  `C-`
SHIFT: `S-`
ALT:   `A-`

### Named Special Keys

Enter: `ret`
Backspace: `backspace`
Space: `space`
`-`: `minus`
Left-arrow: `left`
Right-arrow: `right`
Up-arrow: `up`
Down-arrow: `down`
Home: `home`
End: `end`
Page-Up: `pageup`
Page-Down: `pagedown`
Tab: `tab`
Delete: `del`
Insert: `ins`
Escape: `esc`

null

### Minor Modes

`v` = select_mode
`g` = goto mode
`m` = match mode
`:` = command_mode
`z` = view mode
`Z` = sticky view mode
`C-w` = window mode
`space` = space mode

## Directory Structure

- [ ] TODO: Call `haumea.lib.load` to import configs in mode dir, excluding `default-*.nix` files.

`./keys/<mode>/default-helix.nix` - Contains default keymaps for Helix.
`./keys/<mode>/default-vim.nix`   - Contains default keymaps for Vim.
`./keys/<mode>/default-emacs.nix` - Contains default keymaps for Emacs.
`./keys/<mode>/default.nix`       - Imports all other files in `./keys/<mode>/*.nix`
`./keys/<mode>/*.nix`             - Allows organizing keymaps in files named by theme.

[LGUG2Z/helix-vim](https://github.com/LGUG2Z/helix-vim) - Vim-like Helix configuration. See: `config.toml`

## Free Keys

See [wiki: Keymap brainstorm - suggestions](https://github.com/helix-editor/helix/wiki/Keymap-brainstorm#suggestions)

## To-Do

- [ ] Create [keymap image](https://www.keyboard-layout-editor.com/#/gists/0e45da1f7e56b54c7f287551415b3fa8) like [this](https://user-images.githubusercontent.com/91177333/192541110-19a94459-9467-41f6-bbd8-56d02e99ba32.png)

- [ ] Add snippet below

```nix
{ keys = 
  let
    normal = importTOML ./keys.normal.toml;
    mapping_table = {
      # searching for all command having a correspondence with extend_ prefix
      # https://github.com/helix-editor/helix/blob/master/helix-term/src/commands.rs
      # see also: https://docs.helix-editor.com/keymap.html#select--extend-mode
      # > Select mode echoes Normal mode, but changes any movements to extend
      # > selections rather than replace them. Goto motions are also changed to extend [...]
      # goto commands seems to have a different handling
      "move_char_left" = "extend_char_left";
      "move_char_right" = "extend_char_right";
      "move_line_down" = "extend_line_down";
      "move_line_up" = "extend_line_up";
      "move_visual_line_down" = "extend_line_down";
      "move_visual_line_up" = "extend_line_up";
      "move_prev_word_start" = "extend_prev_word_start";
      "move_next_word_end" = "extend_next_word_end";
      "move_prev_long_word_start" = "extend_prev_long_word_start";
      "move_next_long_word_end" = "extend_next_long_word_end";
      "move_parent_node_start" = "extend_parent_node_start";
      "move_parent_node_end" = "extend_parent_node_end";
      "find_till_char" = "extend_till_char";
      "find_next_char" = "extend_next_char";
      "till_prev_char" = "extend_till_prev_char";
      "find_prev_char" = "extend_prev_char";
      "search_next" = "extend_search_prev";
      "search_prev" = "extend_search_prev";
    };
  in 
  {
    inherit normal;
    select = mapAttrs (_: v: mapping_table.${v} or v) normal // 
    { # rebound select mode key in normal mode -> override "append" in select mode
      "a"   = "no_op";
      "C-a" = "no_op";
    };
  };
}
```
