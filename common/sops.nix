{ config, ... }:

{
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.age.keyFile = "/nix/persist/var/lib/sops-nix/keys.txt";
  sops.age.generateKey = true;
  sops.secrets.stella-password.neededForUsers = true;
}
