{
  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/run/secrets-for-users/"
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
    ];

    files = [
      "/var/lib/sops-nix/keys.txt"
    ];
  };
}
