{ lib, config, ... }:
{
  powerManagement = {

    # Moderate CPU frequency governor by default.
    cpuFreqGovernor = lib.mkDefault "ondemand";

    # Power usage monitoring util
    powertop.enable = true;
  };

  # --- Power management daemons ---------------------------
  # Note: Only enable one at a time


  # --- power-profiles-daemon ---
  # Notes:
  # - Manual profile toggling, unless using other util to automate profile switching
  # - Integrates nicely with GNOME's QuickSettings toggle
  # - Three profiles: power-saver, balanced, performance
  # - Profiles only control power consumption & CPU perf under medium/high load.
  # - Profiles have minimal effect on idle power consumption
  # - Profiles have hard-coded behavior.
  # - Only adjusts three settings covered by TLP:
  #   - `PLATFORM_PROFILE_ON_AC`       / `PLATFORM_PROFILE_ON_BAT`
  #   - `CPU_ENERGY_PERF_POLICY_ON_AC` / `CPU_ENERGY_PERF_POLICY_ON_BAT` (only activated when above unsupported by hardware)
  #   - `CPU_BOOST_ON_AC`              / `CPU_BOOST_ON_BAT`              (disabled at high CPU temps when above item is active)
  services.power-profiles-daemon.enable = !config.services.tlp.enable;

  # --- TLP ---
  # Notes:
  # - More active adjustment than ppp, but no simple equivalent to the 3 manual profiles.
  # - More characteristics are configurable than with ppp
  # - Two profiles: AC & BAT
  # - Profiles automatically selected based on power source: AC or battery
  # - Profiles can be manually selected using CLI command: `$ sudo tlp ac|bat`
  # - Closest ways to approximate ppp's 3 profiles:
  #   1. Map: `balanced` -> `AC`  & `power-saver` -> `BAT`
  #   2. Map: `balanced` -> `BAT` & `performance` -> `AC`
  # NOTE: All params must be specified pairwise for both `AC` & ``BAT`
  # DOCS: https://linrunner.de/tlp/introduction.html
  services.tlp = {
    enable = lib.mkDefault true;
    settings =
      let
        shared = { CPU_BOOST_ON_AC = 1; CPU_BOOST_ON_BAT = 0; };
        mapping1 = shared // {
          PLATFORM_PROFILE_ON_AC = "balanced"; # # May also have additional profiles.
          PLATFORM_PROFILE_ON_BAT = "low-power"; # Check by running: `tlp-stat -p`
          CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance"; # CPU energy/perf policies:
          CPU_ENERGY_PERF_POLICY_ON_BAT = "power"; # `power`->`balance_power`->`default`->`balance_performance`->`performance`
        };
        mapping2 = shared // {
          PLATFORM_PROFILE_ON_AC = "performance"; # Default profiles: `low-power`, `balanced`, `performance`
          PLATFORM_PROFILE_ON_BAT = "balanced"; # # Other profiles: `quiet`, `cool`, `balanced-performance`
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance"; #        # Default: `balance_performance`
          CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance"; # Default: `balance_power`
        };
        # --- System Suspend Mode ---
        suspend = {
          #      # WARNING: Changing may cause instability/data-loss. Get modes: `tlp-stat -s`
          MEM_SLEEP_ON_AC = "s2idle"; # Idle standby. Pure software, lightweight, system sleep state.
          MEM_SLEEP_ON_BAT = "deep"; ## Suspend to RAM. Entire system put into low-power state, except RAM. Usually more power savings than `s2idle`
        };
        cpu-other = {
          # CPU scaling driver operation mode. Config depends on the active driver
          #  Driver: `intel_pstate`: `active`, `passive`
          CPU_DRIVER_OPMODE_ON_AC = "active";
          CPU_DRIVER_OPMODE_ON_BAT = "active";

          # CPU scaling governor. Automatic frequency scaling. Config depends on active driver.
          #  Get modes: `$ tlp-stat -p` (may need to run `tlp start` before modular kernels discover all)
          #  Mode=Active:  `powersave`, `performance`
          #  Mode=Passive: `powersave`, `performance`, `conservative`, `userspace`
          #                `ondemand` (usual default), `schedutil` (new default)
          CPU_SCALING_GOVERNOR_ON_AC = "ondemand";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          # Set min/max frequency available for scaling governor. Possible values depend on CPU.
          #  NOTE: Must always set both min/max for **both** `AC` & `BAT`
          #  NOTE: Best results usually from default governors w/o frequency limits
          #  WARN: Dont use w/ `intel_pstate` driver in `active` mode. Instead, use:
          #   `CPU_{MIN,MAX}_PERF_ON_{AC,BAT}`
          CPU_SCALING_MIN_FREQ_ON_AC = 0;
          CPU_SCALING_MAX_FREQ_ON_AC = 9999999;
          CPU_SCALING_MIN_FREQ_ON_BAT = 0;
          CPU_SCALING_MAX_FREQ_ON_BAT = 9999999;

          # Min/max P-state for Intel CPUs. Values are percentage (0-100) of total available processor perf.
          #  Limit power dissipation of CPU. Driver may impose limit>0 on min P-state. See: `min_perf_pct`
          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 60;

          # Turbo Boost.
          CPU_BOOST_ON_AC = 1;
          CPU_BOOST_ON_BAT = 0; # 1=allow-boosting. 2=disable-boosting
          CPU_HWP_DYN_BOOST_ON_AC = 1;
          CPU_HWP_DYN_BOOST_ON_BAT = 0; # Dynamic equiv of ^ when mode=`intel_pstate=active`
        };
      in
      {
        # --- Battery Discharge ---
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power"; #    # d:balance_power  # Lower power CPU energy/perf policy
        PLATFORM_PROFILE_ON_BAT = "low-power"; #      # d:balanced       # Lower power platform profile
        RUNTIME_PM_ON_BAT = "auto"; #                 # d:on             # Reduce fan noise/power
        CPU_BOOST_ON_BAT = 0; #                       # d:1              # Disable turbo-boost
        CPU_HWP_DYN_BOOST_ON_BAT = 0; #               # d:1              # Disable dynamic turbo-boost
        WIFI_PWR_ON_BAT = "on"; #                     # d:off            # Wi-Fi power-save
        SOUND_POWER_SAVE_ON_BAT = 10; # d:1              # Audio power-save mode timeout++
        SOUND_POWER_SAVE_CONTROLLER = "Y"; # d:Y              # Power off controller w/ sound chip

        # --- AC-Connected ---
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance"; # d:balance_performance # More perf CPU policy on AC
        PLATFORM_PROFILE_ON_AC = "performance"; #     # d:balanced            # More perf platform profile
        RUNTIME_PM_ON_AC = "auto"; #                  # d:on                  # Reduce fan noise/power
        CPU_BOOST_ON_AC = 1; #                        # d:1                   # Use turbo-boost
        CPU_HWP_DYN_BOOST_ON_AC = 1; #                # d:1                   # Use dynamic turbo-boost
        WIFI_PWR_ON_AC = "off"; #                     # d:off                 # No Wi-Fi power-save
        SOUND_POWER_SAVE_ON_AC = 0; # d:1                   # Audio power-save mode disable
      };
  };
}
