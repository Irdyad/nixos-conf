{ self, inputs, ... }:

{
  flake.nixosModules.nvim = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myNvim
    ];
  };

  perSystem = { pkgs, ... }:
    let
      nvf = inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;

        modules = [
          {
            config.vim = {
              enableLuaLoader = true;

              viAlias = false;
              vimAlias = false;

              options = {
                number = true;
                relativenumber = true;

                expandtab = true;
                shiftwidth = 2;
                tabstop = 2;

                signcolumn = "yes";
                termguicolors = true;
              };

              globals = {
                mapleader = " ";
                maplocalleader = " ";
              };

              keymaps = [
                {
                  key = "<leader>w";
                  mode = "n";
                  action = "<cmd>write<cr>";
                  desc = "Save";
                }

                {
                  key = "<leader>q";
                  mode = "n";
                  action = "<cmd>quit<cr>";
                  desc = "Quit";
                }

                {
                  key = "<leader>h";
                  mode = "n";
                  action = "<cmd>nohlsearch<cr>";
                  desc = "Clear search highlight";
                }
              ];

              theme = {
                enable = true;
                name = "tokyonight";
                style = "night";
              };

              statusline.lualine.enable = true;

              telescope.enable = true;

              treesitter = {
                enable = true;
                context.enable = true;
              };

              lsp.enable = true;

              languages = {
                nix = {
                  enable = true;
                  lsp.enable = true;
                  format.enable = true;
                };

                lua = {
                  enable = true;
                  lsp.enable = true;
                  format.enable = true;
                };
              };
            };
          }
        ];
      };
    in
    {
      packages.myNvim =
        inputs.wrapper-modules.wrappers.nvim.wrap {
          inherit pkgs;

          package = nvf.neovim;

          runtimePkgs = with pkgs; [
            git
            ripgrep
            fd
          ];
        };
    };
}
