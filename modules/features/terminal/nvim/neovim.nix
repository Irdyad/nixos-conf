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

              viAlias = true;
              vimAlias = true;

              # Let NVF handle the runtime packages directly
              extraPackages = with pkgs; [
                git
                ripgrep
                fd
              ];

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
                # --- Core Commands ---
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

                # --- File Explorer (NvimTree) ---
                {
                  key = "<leader>e";
                  mode = "n";
                  action = "<cmd>NvimTreeToggle<cr>";
                  desc = "Toggle File Explorer";
                }
                {
                  key = "<leader>o";
                  mode = "n";
                  action = "<cmd>NvimTreeFocus<cr>";
                  desc = "Focus File Explorer";
                }

                # --- Window Navigation ---
                {
                  key = "<C-h>";
                  mode = "n";
                  action = "<C-w>h";
                  desc = "Go to left window";
                }
                {
                  key = "<C-j>";
                  mode = "n";
                  action = "<C-w>j";
                  desc = "Go to lower window";
                }
                {
                  key = "<C-k>";
                  mode = "n";
                  action = "<C-w>k";
                  desc = "Go to upper window";
                }
                {
                  key = "<C-l>";
                  mode = "n";
                  action = "<C-w>l";
                  desc = "Go to right window";
                }

                # --- Telescope (Fuzzy Finding) ---
                {
                  key = "<leader>ff";
                  mode = "n";
                  action = "<cmd>Telescope find_files<cr>";
                  desc = "Find Files";
                }
                {
                  key = "<leader>fg";
                  mode = "n";
                  action = "<cmd>Telescope live_grep<cr>";
                  desc = "Live Grep";
                }
                {
                  key = "<leader>fb";
                  mode = "n";
                  action = "<cmd>Telescope buffers<cr>";
                  desc = "Find Buffers";
                }
                {
                  key = "<leader>fk";
                  mode = "n";
                  action = "<cmd>Telescope keymaps<cr>";
                  desc = "Find Keymaps";
                }
                {
                  key = "<leader>fh";
                  mode = "n";
                  action = "<cmd>Telescope help_tags<cr>";
                  desc = "Find Help";
                }

                # --- LSP Keybinds ---
                {
                  key = "gd";
                  mode = "n";
                  action = "<cmd>Telescope lsp_definitions<cr>";
                  desc = "Go to definition";
                }
                {
                  key = "gr";
                  mode = "n";
                  action = "<cmd>Telescope lsp_references<cr>";
                  desc = "Go to references";
                }
                {
                  key = "K";
                  mode = "n";
                  action = "<cmd>lua vim.lsp.buf.hover()<cr>";
                  desc = "Hover Documentation";
                }
                {
                  key = "<leader>rn";
                  mode = "n";
                  action = "<cmd>lua vim.lsp.buf.rename()<cr>";
                  desc = "Rename symbol";
                }
                {
                  key = "<leader>ca";
                  mode = "n";
                  action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
                  desc = "Code action";
                }
              ];

              theme = {
                enable = true;
                name = "gruvbox";
                style = "dark";
              };

              statusline.lualine.enable = true;
              telescope.enable = true;

              # Show keybins when pressing any key and pausing
              binds.whichKey.enable = true;
              
              # Enable file explorer
              filetree.nvimTree.enable = true;

              # Enable floating terminal
              terminal.toggleterm = {
                enable = true;
                lazygit.enable = true;
              };
              
              # Shows modifications
              git = {
                enable = true;
                gitsigns.enable = true;
              };
              
              autopairs.nvim-autopairs.enable = true;
              comments.comment-nvim.enable = true;

              treesitter = {
                enable = true;
                context.enable = true;
              };

              lsp = {
                enable = true;
                formatOnSave = true;
              };

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
                
                clang = {
                  enable = true;
                  lsp.enable = true;
                };
              };

              # Makefile tabs rule
              luaConfigRC.makefile_tabs = ''
                vim.api.nvim_create_autocmd("FileType", {
                  pattern = "make",
                  callback = function()
                    vim.opt_local.expandtab = false
                    vim.opt_local.shiftwidth = 4
                    vim.opt_local.tabstop = 4
                  end,
                })
              '';
            };
          }
        ];
      };
    in
    {
      packages.myNvim = nvf.neovim;
    };
}
