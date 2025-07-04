{
  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/lib/nixos"
      "/var/lib/bluetooth"
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
      "/etc/secureboot"
      "/var/lib/tailscale"
    ];

    files = [
      "/nix/persist/var/lib/sops-nix/keys.txt"
      "/etc/logid.cfg"
    ];
  };
}
