{ lib, ... }:

{
  boot.initrd.postMountCommands = lib.mkAfter ''
    zfs rollback -r zroot/local/root@blank
  '';
}
