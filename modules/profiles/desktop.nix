{self, inputs, ...}: {
	flake.nixosModules.desktop_base = {config, pkgs, lib, ...}: {
		imports = with self.nixosModules; [
			niri
		];
    programs.firefox.enable = true;
	};
}
