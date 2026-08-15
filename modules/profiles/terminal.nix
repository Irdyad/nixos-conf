{self, inputs, ...}: {
  flake.nixosModules.terminal_base = {config, pkgs, lib, ...}: {
    imports = with self.nixosModules; [
      nvim
      bash
      git
    ];
  };
}
