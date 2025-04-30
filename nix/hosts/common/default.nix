{
  imports = [ 
    ./users.nix
  ];

  networking.domain = "gierens.de";

  time.timeZone = "Europe/Berlin";

  environment.variables.EDITOR = "nvim";
}
