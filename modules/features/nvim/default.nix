{ inputs, pkgs, ... }:

let
  nvf = inputs.nvf.lib.neovimConfiguration {
    inherit pkgs;

    modules = [
      ./nvf.nix
    ];
  };
in
{
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
}
