{ ... }:

{
  programs.zsh = {
    shellAliases = {
	docker = "sudo podman";
    };
  };
}
