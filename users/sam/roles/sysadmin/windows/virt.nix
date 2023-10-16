{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [ ];

  home.packages = [
    # TODO: WINE & Bottles
    pkgs.waagent # The Microsoft Azure Linux Agent (waagent) manages Linux provisioning and VM interaction with the Azure Fabric Controller
    pkgs.msbuild # Mono version of Microsoft Build Engine, the build platform for .NET, and Visual Studio
    pkgs.playonlinux # GUI for managing Windows programs under linux
    pkgs.proton-caller # Run Windows programs with Proton
    pkgs.wibo # Quick-and-dirty wrapper to run 32-bit windows EXEs on linux
    pkgs.quickemu # Quickly create + run optimised Windows, macOS & Linux desktop virtual machines
    pkgs.gnome.gnome-boxes # Simple GNOME 3 application to access remote or virtual systems
    pkgs.guacamole-server # Clientless remote desktop gateway
    pkgs.guacamole-client # Clientless remote desktop gateway
    pkgs.remote-touchpad # Control mouse and keyboard from the webbrowser of a smartphone.
    pkgs.remotebox # VirtualBox client with remote management
  ];

}
