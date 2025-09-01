{ config, lib, pkgs, ... }:

{
  sops.secrets = {
    secrets = {
      sopsFile = ../secrets/secrets.env;
    };
  };

  virtualisation.oci-containers.containers = {
    audiobookshelf = {
      image = "ghcr.io/advplyr/audiobookshelf:latest";
      ports = [ "13378:80" ];
      volumes = [
        "/audiobooks:/audiobooks"
        "/podcasts:/podcasts"
        "/config:/config"
        "/metadata:/metadata"
      ];
      environment = {
        TZ = "Europe/Bucharest";
      };
      extraOptions = [
        "--network=container:ts-audiobookshelf"
      ];
    };

    ts-audiobookshelf = {
      image = "tailscale/tailscale:latest";
      hostname = "audiobookshelf";
      environment = {
        TS_AUTHKEY = config.sops.secrets."secrets".json.15O_key;
        TS_SERVE_CONFIG = "/config/tailscale.json";
        TS_STATE_DIR = "/var/lib/tailscale";
      };
      volumes = [
        "/tailscale/state:/var/lib/tailscale:Z"
        "/tailscale/config:/config:Z"
      ];
      extraOptions = [
        "--device=/dev/net/tun:/dev/net/tun"
        "--cap-add=NET_ADMIN"
        "--cap-add=SYS_MODULE"
      ];
    };
  };
}
