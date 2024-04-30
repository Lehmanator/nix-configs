# Hive `nixosSuites`

Suites are collections of related profiles.
Profiles for a machine should match the primary use case for the device.
Most role-related config should be in `homeSuites` instead.

## Suites

- [ ] TODO: Impolement these

- `server` - Server devices
  - `cluster-node` - Kubernetes cluster nodes (`server` + Kubernetes-specifics)
    - `cluster-worker` - Kubernetes cluster non-master nodes (`cluster-node` + worker-specifics)
    - `cluster-master` - Kubernetes cluster master nodes (`cluster-node` + master-specifics)

### Form Factor

- `ff-server` - Stationary server machines

  - `ff-sbc` - Stationary single-board-computer (SBC) machines

- `ff-desktop` - Stationary workstation machines

- `ff-portable` - Stationary workstation machines
  - `ff-laptop` - Mobile workstation machines
  - `ff-mobile` - Mobile phone or tablet devices
    - `ff-phone` - Mobile phone devices (`mobile` + phone-specifics)
    - `ff-tablet` - Mobile tablet devices (`mobile` + tablet-specifics)

### Device Usage

- `usage-workstation` - Any machine using a desktop environment

  - `usage-development` - Workstation used for development.
  - `usage-office` - Workstation used for documents & work-related stuff.
  - `usage-media-consumption` - Workstation for media creation.`
  - `usage-media-creation` - Workstation for media creation.`

- `usage-social` - Devices with chat & social software installed

  - `usage-chat`
  - `usage-social`

- `usage-gaming` - Devices with games installed
  - `usage-streaming` - Gaming device with streaming software

### Technologies

- `display-x11` - `X11` enabled

  - `display-x11-only` - `X11` without `wayland`

- `display-wayland` - `Wayland` enabled

  - `display-wayland-only` - `Wayland` without `Xwayland`.

- `pipewire` - `pipewire` enabled
  - `pipewire-only` - `pipewire` without `alsa`

### Behaviors

- `hardening` - Collection of profiles to benefit security posture.

  - `harden-network`
  - `harden-environment`
    - Install Rust util alternatives.
    - Harden privilege escalation. (`sudo` / `polkit`)
  - `harden-boot`
    - Secure boot
    - TPM verity
    - Impermanence
    - Kernel config

- `privacy` - Collection of profiles to benefit privacy posture.

  - Tor interface
  - i2p interface
  - VPN enabled by default

- `perf` - Collection of profiles to benefit performance.
  - `perf-responsive` - Collection of profiles to increase system responsiveness.
    - oomd
    - zen-kernel
    - network latency
    - io latency
  - `perf-throughput` - Collection of profiles to increase system throughput.
  - `perf-battery` - Collection of profiles to increase battery life.

## Look Into

- `mkSuites` (omnibus) [example](https://github.com/GTrunSec/omnibus/blob/main/units/nixos/nixosProfiles/cloud.nix#L43)
