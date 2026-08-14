{ inputs, self, ... }:

{
  perSystem = { pkgs, system, ... }:
    let
      nvf = inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;

        modules = [
          ./features/neovim/nvf.nix
        ];
      };

      wrapper = inputs.wrapper-modules.lib.evalModule {
        modules = [
          ({ ... }: {
            imports = [
              inputs.wrapper-modules.wrapperModules.neovim
            ];

            package = nvf.neovim;

            runtimePkgs = with pkgs; [
              git
              ripgrep
              fd
            ];

            binName = "nvim";
          })
        ];
      };
    in
    {
      packages.neovim = wrapper.config.wrapper;
    };
}
