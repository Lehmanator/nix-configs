# Repo History

This is the very same repo I have used since my very first introduction to Nix & NixOS. As such, there are **tons** of instances where you can find configs/code that are sloppy, unused, unconventional, unidiomatic, unsupported, untested, & otherwise unusable. Lots of things were hacky or bad practice when they were implemented.

I have since learned a lot, but in the process, this repo has accumulated all the failures used to build my current understanding. Refactors suck and this repo is a personal project, so the idea of reworking/revisiting the uninteresting boilerplate and doing repo janitorial work is extremely low priority.

## Nix Ecosystem Reality

Nix is incredibly open-ended, providing few guide rails for repo organization, directory structure, attrset layouts, and data passing.
Having `nixpkgs` as a giant monorepo for Nix & NixOS is both a blessing and a curse.
It's really nice having one single centralized source for everything required to use the Nix package manager or build NixOS systems, developer shells, and more.

However, this comes with some problems:

- `nixpkgs` being huge means any decisions have substantial, widespread impact.
- Decisions having substantial, widespread impact means changes may introduce breakages elsewhere in `nixpkgs` or in downstream projects.
- Decisions being likely to cause breakages causes decision-making to be very important to many people.
- Decisions being very important to many people means governance must have widespread community consensus.
- Requiring broad consensus means everything but the most conservative of changes will require a period of debate, where many changes will be rejected.
- This essentially enforces `nixpkgs` maintainers to act conservatively, rejecting changes they would otherwise like to see because the collective maintainers don't weigh the change as important enough to warrant the effort to implement.
- This means users will avoid suggesting changes to `nixpkgs` directly, understanding they will likely be rejected and their ideas and/or code ripped apart by a bunch of people.
- This means users will package their stuff as community projects.
- This means that there will be tons of community projects to handle everything-under-the-sun.
- This means that these projects will have significant overlap, little integration, and no knowledge of the presence of parallel projects.
- This means no single community project will get enough steam to get enough contributors to become a de facto norm or default flake input.
- This means end-users will be forced to discover, learn, and weigh the pros/cons vs. alternatives for every community project to solve a given problem.

*So naturally, there are a **fuckton** of libs and frameworks for organization, structure, importing, etc. of the various types of Nix configs.*

This makes choosing between them hard, leading to my dilemma.

## My Indecisiveness

I've long been grappling with the decision of how to organize the configs in this repository. Particularly, how to best organize profiles, collections of profiles, and similar config items. Every time I feel close to settling on an organization scheme and directory layout, I discover some new Nix framework or lib that puts the certainty of my decision into question. Oftentimes, these frameworks place restrictive constraints on directory structure, so I have been putting off commiting to a framework until I fully understand its pros and cons.

See [`./frameworks-pros-cons.md`](./frameworks-pros-cons.md) for descriptions of these frameworks and their pros / cons.

## Impact on Repo Status

The unfortunate result of this indecisiveness is the existence of lots of unused configs, boilerplate, and flake inputs that are no longer used...each specific to each framework I have messed around with.
If it impacts builds, I comment out the offending parts, and rebuild.
The main reason I do not remove it entirely is to preserve the insights and lessons learned by adding it. I am operating under the assumption that I will revisit the decision at a later point. 
Leaving the code in-tact in actively used branches forces me to keep contextualize the associated framework and its constraints as I make new changes to the *actually used* configs. This is mostly because keeping the old code in-tree on active branches is *far* more discoverable than having to remember the existance of the framework, remember when I used the framework, and traverse the git history to when the framework was in use.



