{ pkgs, ... }:
{
  virtualization.containers.enable = true;
  virtualization = {
    podman = {
      enable = true;

      dockerCompat = true;

      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    podman-tui
    docker-compose
  ];
}
