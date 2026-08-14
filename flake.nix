{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; #fetch pakages

    flake-parts.url = "github:hercules-ci/flake-parts"; #framework for dendritic pattern
    import-tree.url = "github:vic/import-tree"; #recursively import all modules

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules"; #allow to bundle programs

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Avoid nixpgks duplication
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  };

  # Import modules/ automatically
  outputs = inputs: inputs.flake-parts.lib.mkFlake 
  {inherit inputs;} 
  (inputs.import-tree ./modules);
}
