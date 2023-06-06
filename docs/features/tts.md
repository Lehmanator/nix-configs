# Text-to-Speech

## TTS Engines

### eSpeak

1. Install package: `pkgs.espeak-ng`
2. Write config: `~/.config/speech-dispatcher/speechd.conf`
  ```
    AddModule "espeak-ng"                "sd_espeak-ng" "espeak-ng.conf"
    DefaultModule espeak-ng
  ```

### Hunspell

1. Install package: `pkgs.hunspell`, `pkgs.hunspellDicts.en_US`, ...
## Use TTS on system

### Firefox

1. Enable Speech Synthesis:
   Set flag: `media.webspeech.synth.enabled = true`

2. Disable Fingerprinting Protection: (WARNING: privacy downgrade)
   Set flag: `privacy.resistFingerprinting = false`
