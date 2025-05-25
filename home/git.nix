{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Sandro-Alessio Gierens";
    userEmail = "sandro@gierens.de";
    extraConfig = {
      core = {
        pager = "delta";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      delta = {
        navigate = true;  # use n and N to move between diff sections
        dark = true;
        side-by-side = true;
        line-numbers = true;
      };
      merge = {
        conflictstyle = "zdiff3";
      };
    };
  };
}
