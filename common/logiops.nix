{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.logiops ];

  systemd.services.logid = {
    description = "Logi Daemon";

    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.logiops}/bin/logid -v";
      ExecStop = "pkill logid";
      Restart = "on-failure";
    };

    wantedBy = [ "default.target" ];
  };

  systemd.services.logid.enable = true;

}
