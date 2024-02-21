{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  # TODO: Create nixvimModules.base that is imported by all others
  # TODO: Create nixvimModules.home-manager
  # TODO: Create nixvimModules.nixos
  # TODO: Create nixvimModules.devshell-base
  # TODO: Create nixvimModules.devshell-base
  home.packages = [
    pkgs.universal-ctags

    (inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
      inherit pkgs;
      module = import inputs.self.nixvimModules.default;
      extraSpecialArgs = {
        inherit inputs;
        homeConfig = config;
        user = "sam";
      };
    })

    # TODO: Reimplement with overrides using `nixvimExtend` once
    #  https://github.com/nix-community/nixvim/pull/1142 is merged
    #(inputs.self.packages.${pkgs.system}.nvim.nvimExtend
    #  (import inputs.self.nixvimModules.home-manager))
  ];
}
