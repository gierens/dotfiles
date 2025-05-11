{
  inputs,
  lib,
  pkgs,
  ...
}: {
  services.zrepl = {
    enable = true;
    package = pkgs.zrepl;
    settings = {
      jobs = [
        {
          name = "reaper_root_to_zr1";
          type = "push";
          connect = {
            type = "tls";
            address = "zr1.gierens.de:8888";
            ca = "/etc/zrepl/ca.crt";
            cert = "/etc/zrepl/reaper.gierens.de.crt";
            key = "/etc/zrepl/reaper.gierens.de.key";
            server_cn = "zr1.gierens.de";
          };
          filesystems = {
            "zpool<" = true;
          };
          send = {
            raw = true;
            encrypted = true;
            compressed = true;
          };
          snapshotting = {
            type = "periodic";
            prefix = "zrepl_";
            interval = "10m";
          };
          pruning = {
            keep_sender = [
              {
                type = "not_replicated";
              }
              {
                type = "last_n";
                count = 10;
              }
            ];
            keep_receiver = [
              {
                type = "grid";
                grid = "1x1h(keep=all) | 24x1h | 30x1d | 6x30d";
                regex = "^zrepl_";
              }
              {
                type = "regex";
                regex = "^zrepl_";
                negate = true;
              }
            ];
          };
        }
      ];
    };
  };
}
