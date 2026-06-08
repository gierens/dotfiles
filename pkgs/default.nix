# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: rec {
  # example = pkgs.callPackage ./example { };
  cargo-leet = pkgs.callPackage ./cargo-leet.nix { };
  z3_4_12_5 = pkgs.callPackage ./z3 { };
  vargo = pkgs.callPackage ./vargo.nix { };
  verus = pkgs.callPackage ./verus { inherit vargo z3_4_12_5; };
  verus-analyzer = pkgs.callPackage ./verus-analyzer.nix { };
}
