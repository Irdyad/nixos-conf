{self, inputs, ...}: {
  flake.nixosConfiguration.tower = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.towerConfig
    ];
  };
}
