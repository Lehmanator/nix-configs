# nix-direnv

File: `.envrc`
Example: [numtide/blueprint](https://github.com/numtide/blueprint/blob/main/templates/default/.envrc)

```sh
#!/usr/bin/env bash
# Used by https://direnv.net

# Automatically reload when this file changes
watch_file devshell.nix

# Load `nix develop`
use flake

# Extend the environment with per-user overrides
source_env_if_exists .envrc.local
```

## Prerequisites

### Mandatory

- Working `devShells.default`

### Semi-Mandatory

- Fast eval & build for `devShells.default`
- Useful things to do with `devShells.default`

### Optional

- Implement `shellProfiles`
- Implement `shellConfigurations`
