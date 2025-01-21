# Nix Framework Pros / Cons

Here's a quick-n-dirty list of frameworks and libs considered/used to organize this repo at some point.


## Base libs

These two are flexible, integrate with other frameworks, and have the fewest constraints on directory layout.

- [`numtide/flake-parts`](https://github.com/numtide/flake-parts) - Module system for flake outputs.
- [`nix-community/haumea`](https://github.com/nix-community/haumea) - Loaders for Nix configurations.

Pros:

- Flexible
- Integrate with tons of other tools
- Many frameworks target `flake-parts` by supplying a `flakeModule`
- Few constraints on repo organization.

Cons:

- Haumea requires lots of boilerplate
- Not much is automatic.

## std ecosystem

- [`divnix/std`](https://github.com/divnix/std) - Software development lifecycle framework for Nix.
- [`divnix/hive`](https://github.com/divnix/hive) - Like `std`, but for NixOS-related flake outputs.
- [`divnix/flops`](https://github.com/divnix/flops) - POP libs for flake outputs.
- [`tao3k/omnibus`](https://github.com/tao3k/omnibus) - POP definitions for common flake outputs.

Pros:

- Great separation of concerns.
- Well-defined units of organization.
- Rigid (sub-)directory layout enforces consistency.
- Rigid module args `inputs, cell` enforces good hygiene for passing data.
- Reduces organizational decision-making.
- Nifty `paisano-tui` integration.
- Integrates lots of different utils via custom `blockTypes`
- Provides a `flakeModule`

Cons:

- Incompatible with other frameworks.
- Adds otherwise useless flake outputs to use `paisano-tui`
- State of documentation is **terrible**...yes, even compared to the rest of the Nix ecosystem.
- Provided `flakeModule` usage doesn't reach parity with raw `std` usage.
- Provided `flakeModule` is undocumented.

## Clan

- [`clan.lol`](https://git.clan.lol/clan/clan-core) - Machine & inventory declaration system enabling some really cool integrations.

Pros:

- Integration with configurator util cli, gui, & web UI.
- Provides really nice cross-machine integrations like setting up mesh networks.
- Really nice for bootstrapping secrets or data.
- Provides a `flakeModule`

Cons:
- Relatively inflexible, requiring quite a few repo layout constraints to get the full set of benefits it provides.
- The functionality it enables is *quite powerful*, so workarounds can be considered to integrate it.

## Blueprint

- [`numtide/blueprint`](https://github.com/numtide/blueprint) - 

## Previously including

- [`snowfallorg/lib`](https://github.com/snowfallorg/lib)


