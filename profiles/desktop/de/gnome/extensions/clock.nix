{ 
  config, lib, pkgs,
  ...
}:

{
  imports = [
  ];

  environment.systemPackages = with pkgs.gnomeExtensions; [
    # Tasks lists in clock panel next to calendar
    # - Local tasks
    # - Endeavour (Tasks app)
    # - Evolution (Mail client)
    # - GNOME Online Accounts (all providers that support tasks)
    # - Thunderbird (Mail client)
    #task-widget
  ];

}
