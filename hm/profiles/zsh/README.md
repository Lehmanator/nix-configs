# Zsh Config

## Docs & Tuts

- <http://zsh.sourceforge.net/Doc/Release/Completion-System.html>
- <http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Visual-effects>

### Tutorials

- <https://thevaluable.dev/zsh-completion-guide-examples/> - Dotfiles below.
- <https://thevaluable.dev/zsh-install-configure-mouseless> - Same author as above

### Examples / Inspiration

- <https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh>
- <https://github.com/Phantas0s/.dotfiles/blob/master/zsh/completion.zsh> - Dotfiles of author from thevaluable.dev

### Completers

Syntax: `:completion:<function>:<completer>:<command>:<argument>:<tag>`

- See: `man zshoptions` - Search for “Completion”

Note: Use `<CTRL-X> H` to display help/info for completing current command.

- `_approximate`
- `_complete`
- `_expand_alias`
- `_extensions`

### Keybindings

Show all keymaps

1. Run `zmodload zsh/zleparameter` if not loaded
2. Show `keymaps` associative array.
   `echo $keymaps | tr ' ' '\n' | sort`

#### Keybinding Modes

- `menuselect`

### Modules

See: `man zshmodules` then search "THE ZSH/COMPLIST MODULE"

### setopt

See: man `zshoptions`

- `ALWAYS_TO_END` - Always place cursor to end of word completed.
- `AUTO_MENU` - Display completion menu after two TAB presses
- `AUTO_COMPLETE` - Select 1st match given by completion menu. Overrides `AUTO_MENU`
- `AUTO_PARAM_SLASH` - When dir completed, add trailing slash, not space
- `COMPLETE_IN_WORD` - Default: cursor goes at end of word at completion start. Setting this will not move cursor & the completion will happen on both ends of word completed.
- `GLOB_COMPLETE` - Trigger completion after glob \*, not expand
- `LIST_PACKED` - Completion menu takes less space.
- `LIST_ROWS_FIRST` - Matches are sorted in rows instead of columns.

### Widgets

Show all widgets:

1. Run `zmodload zsh/zleparameter` if not loaded
2. Show `widgets` associative array.
   `echo $widgets | tr ' ' '\n' | sort`

#### Builtin

- `accept-line` - Validate the selection and leave the menu.
- `send-break` - Leaves the menu selection and restore the previous command.
- `clear-screen` - Clear the screen without leaving the menu selection.
- `accept-and-hold` - Insert the match in your command and let the completion menu open to insert another match.
- `accept-and-infer-next-history` - Insert the match and, in case of directories, open completion menu to complete its children.
- `undo` - Undo.
- `vi-forward-blank-word` - Move cursor to next group of match.
- `vi-backward-blank-word` - Move cursor to previous group of match.
- `beginning-of-buffer-or-history` - Move the cursor to the leftmost column.
- `end-of-buffer-or-history` - Move the cursor to the rightmost column.
- `vi-insert` - Toggle between normal and interactive mode. We’ve seen the interactive mode above.
- `history-incremental-search-forward` and history-incremental-search-backward - Begin incremental search.
- `backward-word` / `forward-word`
- `vi-insert`

#### 3rd-Party

- `_navi_widget`

### zstyles

Syntax: `:<zsh-setting>:function:completer:command:argument:tag`

Note: Use `<CTRL-X> H` to display help/info for completing current command.

#### zstyle tags

## To-Dos

- [ ] Better vim keybindings
- [ ] Keybind to prefix command with `sudo`
- [ ] Keybind to change first command
- [ ] Keybind to repeat last command w/ diff arg
- [ ] Keybind to insert last command, but diff command name

### Completion

- [ ] Accept partial suggestions from zsh-autosuggestions
- [ ] Typeahead completions like [marlonrichert/zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete), but w/ diff keybindings/behavior
- [ ] Navi integration
- [ ] Restyle the completion description (categories) labels
  - Use wider dash to create divider line
  - Recolor various categories
  - Center text?

### FZF

- [ ] Widget to complete files
- [ ] Widget to complete dirs
- [ ] Widget to complete recent dirs
- [ ] Widget to complete bookmarks

### Plugin Ideas

- [ ] bat file/dir preview when you type in a file/dir name
      ~
      []
      ()
      {}
      <>
      @
      '"`
      1lIiL|/\
      pqbdg
