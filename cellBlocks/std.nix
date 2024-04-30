{ blockTypes }:
with blockTypes; [
  # --- std --------------------------------------

  # --- actions --------------
  (functions "actions")

  # TODO: Explicitly create blockTypes for some of these custom cellBlocks.
  # TODO: D-Bus API message
  # TODO: GraphQL API request
  # TODO: REST API request
  # TODO: Secrets
  # - actions.crypto-sign-file
  # - actions.crypto-verify-signature
  # - actions.encrypted-key-add
  # - actions.encrypted-key-generate
  # - actions.encrypted-key-remove
  # - actions.encrypted-key-rotate
  # - actions.encrypted-file-edit
  # - actions.encrypted-file-decrypt
  # - actions.encrypted-file-show

  # --- blockTypes -----------
  #(functions "blockTypes")

  # TODO: Password Stores
  # - blockTypes.keepass-database
  # - blockTypes.keepass-entry
  # - blockTypes.pass-entry
  # - blockTypes.pass-database

  # TODO: Secrets
  # - blockTypes.sops-file-dict
  # - blockTypes.sops-file-text
  # - blockTypes.sops-file-bin

]
