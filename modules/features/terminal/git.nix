{ self, inputs, ... }: {
  # Name the hook so you can import it in your host config
  flake.nixosModules.git = { config, pkgs, ... }: {
    programs.git = {
      enable = true;
      
      config = {
        # Identity
        user = {
          name = "Irdyad";
          email = "lele.depaoli@gmail.com";
        };

        # Default init behavior
        init.defaultBranch = "main";

        # Use your new Neovim configuration for commit messages
        core.editor = "nvim";

        # Quality of life improvements
        pull.rebase = true;
        fetch.prune = true;
        
        # Colorize output
        color.ui = "auto";

        # Useful global aliases
        alias = {
          co = "checkout";
          br = "branch";
          ci = "commit";
          st = "status";
          unstage = "reset HEAD --";
          last = "log -1 HEAD";
          # A nice, readable git log graph
          graph = "log --graph --oneline --decorate --all";
        };
      };
    };
  };
}
