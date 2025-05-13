final: prev: {
  picom = prev.picom.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "jonaburg";
      repo = "picom";
      rev = "65ad706ab8e1d1a8f302624039431950f6d4fb89";
      sha256 = "";
    };
  });
}
