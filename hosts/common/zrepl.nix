{
  pkgs,
  config,
  ...
}: {
  networking.extraHosts = ''
    127.0.0.1  zr1.${config.networking.domain}  zr1
  '';
  services.zrepl = {
    enable = true;
    package = pkgs.zrepl;
    settings = {
      jobs = [
        {
          name = "${config.networking.hostName}_root_to_zr1";
          type = "push";
          connect = {
            type = "tls";
            address = "zr1.${config.networking.domain}:8888";
            ca = "/etc/zrepl/ca.crt";
            cert = "/etc/zrepl/${config.networking.hostName}.${config.networking.domain}.crt";
            key = "/etc/zrepl/${config.networking.hostName}.${config.networking.domain}.key";
            server_cn = "zr1.${config.networking.domain}";
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
