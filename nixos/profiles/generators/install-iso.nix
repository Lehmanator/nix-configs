{ inputs, user, ... }@parentArgs:
{
  # https://github.com/nix-community/nixos-generators
  # TODO: Tor OpenSSH server for remote access
  imports = [
    # inputs.nixos-generators.nixosModules.all-formats
    inputs.nixos-generators.nixosModules.install-iso
    (inputs.self + /nixos/profiles/disko.nix)
  ];

  formatConfigs = {
    #iso = { };
    #install-iso-hyperv = install-iso // { };
    install-iso = { config, lib, pkgs, ... }: {

      # TODO: Graphical / Minimal installer environments
      imports = let
        graphical = false;
        variant = with parentArgs.config.services;
          # if services.graphical-desktop then "graphical-gnome" 
          if graphical && xserver.desktopManager.gnome.enable  then "graphical-gnome"              else
          if graphical && xserver.desktopManager.plasma.enable then "graphical-plasma5-new-kernel" else
          if graphical && desktopManager.plasma6.enable        then "graphical-calamares-plasma6"  else
          "minimal-new-kernel";
      in [(parentArgs.modulesPath + /installer/cd-dvd/installation-cd-${variant}.nix)];
    
      # Use longer timeout than default
      boot.loader.timeout = lib.mkForce 10;

      # Allow setting EFIVARS
      boot.loader.efi.canTouchEfiVariables = lib.mkForce true;

      # Detect hardware at boot
      boot.hardwareScan = true;
      
      # Don't configure installer filesystems using Disko.
      disko.enableConfig = false;

      networking = {
        networkmanager.enable = lib.mkForce false;
        useDHCP = lib.mkForce false;
      };
      
      # Use flakes & Lix
      nix = {
        package = pkgs.lix;
        settings.experimental-features = [ "nix-command" "flakes"];
      };
      
      # Use sudo over sudo-rs in installer
      security = {
        sudo.enable = lib.mkForce true;
        sudo-rs.enable = lib.mkForce false;
      };
      
      services.openssh = {
        # Make sure OpenSSH server is enabled. 
        enable = true;
        
        # Allow more auth attempts in installer.
        extraConfig = ''
          MaxAuthTries 600
        '';
      };
      
      # Make sure our default user is added to admins & has SSH keys installed for remote SSH access
      users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];

        # TODO: Is this necessary?
        openssh.authorizedKeys.keys = config.users.users.${user}.openssh.authorizedKeys.keys;
      };

      environment.systemPackages = (with pkgs; [
        (parentArgs.config.programs.git.package or git)
        bat eza fastfetch fd fzf
        helix
        neovim
        lsd
        pls
      ]) ++
        # Add disko packages to install using diskoConfigurations
        (with inputs.disko.packages.${pkgs.system}; [ disko disko-doc ]) ++ 
        
        # Add sops-nix packages to manage secrets
        (with inputs.sops-nix.packages.${pkgs.system}; [
          sops-import-keys-hook
          sops-init-gpg-key
          sops-install-secrets
          ssh-to-pgp
          lint
          pkgs.rage
          pkgs.sops
          pkgs.ssh-to-age
          pkgs.rage
          pkgs.sops
          pkgs.ssh-to-age
      ]);
    };
  };
}
