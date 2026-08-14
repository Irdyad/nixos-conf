{self, inputs, ...}: {
	flake.nixosModules.decktop_base = {config, pkgs, lib, ...}: {
		imports = with self.nixosModules; [
			niri
		];
    programs.firefox.enable = true;
	};
}
