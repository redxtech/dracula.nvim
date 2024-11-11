{
  description = "dracula colorscheme for neovim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem = { config, self', inputs', pkgs, system, lib, ... }: {
        # define the packages provided by this flake
        packages = {
          dracula-nvim = pkgs.vimUtils.buildVimPlugin {
            pname = "dracula-nvim";
            version = "2024-11-11";

            src = ./.;
          };

          default = self'.packages.dracula-nvim;
        };
      };
    };
}
