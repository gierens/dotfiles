# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  cargo-leet = pkgs.callPackage ./cargo-leet.nix { };
  z3_4_12_5 = pkgs.callPackage ./z3 { };
}
