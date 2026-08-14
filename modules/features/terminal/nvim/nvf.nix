{self, inputs, ...}: {

	flake.nixosModule.nvim = {pkgs, lib, ...}: {
		programs.nvim = {
			enable = true;
			package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNvim;
		};
	};

	perSystem = {pkgs, lib, ...}: {
		packages.myNvim = inputs.wrapper-modules.wrappers.nvim.wrap {
			inherit pkgs;
		};		
	};
}

