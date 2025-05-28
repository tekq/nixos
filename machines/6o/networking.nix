{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [ "8.8.8.8"
 ];
    defaultGateway = "165.227.128.1";
    defaultGateway6 = {
      address = "";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="165.227.137.2"; prefixLength=20; }
{ address="10.19.0.5"; prefixLength=16; }
        ];
        ipv6.addresses = [
          { address="fe80::8001:9ff:fe49:3d39"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "165.227.128.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = ""; prefixLength = 128; } ];
      };
            eth1 = {
        ipv4.addresses = [
          { address="10.114.0.3"; prefixLength=20; }
        ];
        ipv6.addresses = [
          { address="fe80::3c3f:ccff:fe54:e26f"; prefixLength=64; }
        ];
        };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="82:01:09:49:3d:39", NAME="eth0"
    ATTR{address}=="3e:3f:cc:54:e2:6f", NAME="eth1"
  '';
}
