{ self, ... }:

{
  flake.nixosModules.workstation = {
    imports = with self.nixosModules; [
      git
      kitty
      foot
      shell
      nvim
      firefox
    ];
  };
}
