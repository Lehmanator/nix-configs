# Framework Laptop (12th Gen i7): Improve Battery Life

- Enable Panel Self-Refresh:
  1. [X] Add kernel cmdline parameter: `i915.enable_psr=1`

- Improve suspend power usage:
  1. Enable hibernation
  2. Use `deep` sleep instead of `s2idle`
  3. Add kernel cmdline parameter: `nvme.noacpi=1`

- Enable GPU rendering in Firefox
  See More:
  - [Arch Wiki: Firefox](https://wiki.archlinux.org/title/Firefox#Hardware_video_acceleration)
  - [Arch Wiki: Hardware Video Acceleration](https://wiki.archlinux.org/title/Hardware_video_acceleration)
  - [ArchLinux Forums](https://bbs.archlinux.org/viewtopic.php?id=244031)
  1. Check: `about:support` field: `Compositing = WebRender`
  2. Set Firefox `about:config` flags:
    - `media.rdd-ffmpeg.enabled = true`
    - `media.navigator.mediadatadecoder_vpx_enabled = true`
    - Enable VAAPI:             `media.ffmpeg.vaapi.enabled = true`
    - Force hardware WebRender: `gfx.webrender.all = true`
  3. Set Firefox wayland environment variable: ` [[ "${XDG_SESSION_TYPE}" = "wayland" ]] && export MOZ_ENABLE_WAYLAND=1`

- Enable GPU rendering in Chromium
  See More:
  - [Arch Wiki: Chromium](https://wiki.archlinux.org/index.php/Chromium#Hardware_video_acceleration)
  - [Arch Wiki: Hardware Video Acceleration](https://wiki.archlinux.org/title/Hardware_video_acceleration)
  - [ArchLinux Forums](https://bbs.archlinux.org/viewtopic.php?id=244031)
  0. Check:
    - `chrome://media-internals` field: `video_decoder`
    - `chrome://gpu`             field: `Video Decode: Hardware accelerated`
  1. Install packages:
    - `intel-media-driver`
    - `intel-gpu-tools`
  2. Set Chromium flags in either `~/.config/chromium-flags.conf` or `chrome://flags`:
    - `--enable-gpu-rasterization`
    - `--ignore-gpu-blacklist`
    - `--disable-gpu-driver-workarounds`
