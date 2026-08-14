{ self, inputs, ... }: {
  flake.nixosModules.user-irdyad = { config, pkgs, ... }: {
    users.users.irdyad = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };

    # Auto-login for this specific user
    services.getty.autologinUser = "irdyad";
  };
}
