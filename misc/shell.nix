# https://nixos.wiki/wiki/Development_environment_with_nix-shell
# https://github.com/direnv/direnv/wiki/Nix#setting-up-a-project-to-use-nix
with import <nixpkgs> {};
mkShell {
  nativeBuildInputs = [
    # dependencies you want available in your shell
    # eg, zlib
  ];
}
