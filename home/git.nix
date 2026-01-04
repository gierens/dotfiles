{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Sandro-Alessio Gierens";
        email = "sandro@gierens.de";
      };
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
