# Configures <ALT>. to insert last arg (like !$)
  {
    name: insert_last_token
    modifier: alt
    keycode: char_.
    mode: emacs
    event: [
      { edit: InsertString, value: " !$" }
      { send: Enter }
    ]
  }
  {
    mode: vi_insert
    modifier: alt
    keycode: char_.
    event: {
        send: executeHostCommand
        cmd: "commandline --insert (history | last | get command | parse --regex '(?P<arg>[^ ]+)$' | get arg | first)"
    }
  }
