{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    package = (pkgs.chromium.override { enableWideVine = true; });
    extensions = [
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      # { id = "naepdomgkenhinolocfifgehidddafch"; } # browserpass: installed in hosts/common/desktop
      # { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin: not supported anymore
      { id = "lgblnfidahcdcjddiepkckcfdhpknnjh"; } # stands adblocker
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
      { id = "inlikjemeeknofckkjolnjbpehgadgge"; } # distill
      { id = "laankejkbhbdhmipfmgcngdelahlfoji"; } # stayfocusd
      { id = "kbdngfhhepjodhilpfmnfbfiogachdkp"; } # no content warning youtube
    ];
  };
}
