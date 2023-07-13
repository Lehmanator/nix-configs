{
  config, lib, pkgs,
  ...
}:

{
  imports = [
  ];

  environment.systemPackages = [
    # Tasks lists in clock panel next to calendar
    # - Local tasks
    # - Endeavour (Tasks app)
    # - Evolution (Mail client)
    # - GNOME Online Accounts (all providers that support tasks)
    # - Thunderbird (Mail client)
    #task-widget
    pkgs.gnomeExtensions.weather-or-not    # Display clickable weather status panel button next to clock
  ];

}
