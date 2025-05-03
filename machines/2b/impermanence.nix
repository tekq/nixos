{
  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/lib/nixos"
      "/var/lib/bluetooth"
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
    ];

    files = [
      "/var/lib/tailscale/tailscaled.state"
    ];
  };
}
