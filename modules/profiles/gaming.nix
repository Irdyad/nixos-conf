{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.gaming_base = {
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = with self.nixosModules; [
      steam
    ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true; # Critical for 32-bit games & Steam
    };
  };
}
