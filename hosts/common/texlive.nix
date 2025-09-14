{
  pkgs,
  ...
}: {
  environment.systemPackages = [
    (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-full
      ;
    })
  ];
}
