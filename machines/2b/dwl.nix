{ pkgs, ... }:

{
  nixpkgs.overlays = 
  [ 
    ( 
      final: prev: 
      { 
        dwl = prev.dwl.overrideAttrs { 
          patches = [ 
            
          ]; 
        }; 
      }
    ) 
  ];
}
