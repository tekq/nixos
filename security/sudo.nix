{ ... }:

{
  # Switch to sudo-rs
  security.sudo.enable = false;
  security.sudo-rs.enable = true;

  security.sudo-rs.execWheelOnly = true;

  security.sudo-rs.extraConfig = ''
        Defaults pwfeedback
  '';
}
