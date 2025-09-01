{ config, ... }:

{
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.age.keyFile = "/persist/var/lib/sops-nix/keys.txt";
  sops.age.generateKey = false;
  sops.secrets.stella-password.neededForUsers = true;
}
