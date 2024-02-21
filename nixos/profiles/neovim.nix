{
  inputs,
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with inputs; [
    pkgs.universal-ctags

    (nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
      inherit pkgs;
      module = import self.nixvimModules.default;
      extraSpecialArgs = {
        inherit inputs;
        osConfig = config;
        user = "sam";
      };
    })

    # TODO: Reimplement with overrides using `nixvimExtend` once
    #  https://github.com/nix-community/nixvim/pull/1142 is merged
    #(self.packages.${pkgs.system}.nvim.nvimExtend
    #  (import self.nixvimModules.nixos))
  ];
}
