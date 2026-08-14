{self, inputs, ...}: {
  flake.nixosConfigurations.tower = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.towerConfig
      inputs.nvf.nixosModules.default
    ];
  };
}
