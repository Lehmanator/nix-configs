{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  # --- Binary Cache -------------------
  # TODO: Rename file `./substituters.nix`
  # TODO: Questions
  # - How does `nix.settings.substituters`, etc. interact with flake attr: `nixConfig.extra-substituters`?
  # - What is the difference between `substituters` & `trusted-substituters`?
  # - Do you need items in `trusted-substituters` to be in `substituters` also?
  # - Does home-manager use substituters from NixOS?
  nix.settings = {
    builders-use-substitutes = true; # Allow builders to use binary caches
    substitute = true;
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org/"
      "https://nix-on-droid.cachix.org/"
      "https://robotnix.cachix.org/"
      "https://nrdxp.cachix.org/"
      "https://numtide.cachix.org/"
      "https://snowflakeos.cachix.org/"
      "https://cache.thalheim.io/"
      "https://lehmanator.cachix.org/"
      "https://hyprland.cachix.org/"
      "https://wasmcloud.cachix.org/"
      "https://gvolpe-nixos.cachix.org/"
      "https://wire-server.cachix.org/"
      "https://tweag-nickel.cachix.org/"
      "https://cachix.cachix.org/"
      "https://colemickens.cachix.org/"
      "https://cross-armed.cachix.org"
      "https://r-ryantm.cachix.org/"
      "https://rycee.cachix.org/"
      "https://all-hies.cachix.org/"
      "https://iohk.cachix.org/"
      "https://arm.cachix.org/"
      "https://static-haskell-nix.cachix.org/"
      "https://nixpkgs-wayland.cachix.org/"
      "https://nixpkgs-update.cachix.org/"
    ];
    trusted-substituters = [
      "https://cache.nixos.org/"
      "https://hydra.nixos.org/"
      "https://nix-community.cachix.org/"
      "https://nix-on-droid.cachix.org/"
      "https://robotnix.cachix.org/"
      "https://nrdxp.cachix.org/"
      "https://numtide.cachix.org/"
      "https://snowflakeos.cachix.org/"
      "https://lehmanator.cachix.org/"
      "https://nixpkgs-update.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
    # TODO: Get public keys for missing caches
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU="
      "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "snowflakeos.cachix.org-1:gXb32BL86r9bw1kBiw9AJuIkqN49xBvPd1ZW8YlqO70="
      "cache.thalheim.io-1:R7msbosLEZKrxk/lKxf9BTjOOH7Ax3H0Qj0/6wiHOgc="
      "lehmanator.cachix.org-1:kT+TO3tnSoz+lxk2YZSsMOtVRZ7Gc57jaKWL57ox1wU="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "wasmcloud.cachix.org-1:9gRBzsKh+x2HbVVspreFg/6iFRiD4aOcUQfXVDl3hiM="
      "gvolpe-nixos.cachix.org-1:0MPlBIMwYmrNqoEaYTox15Ds2t1+3R+6Ycj0hZWMcL0="
      "wire-server.cachix.org-1:fVWmRcvdsqzKek3X5Ad8nYNsBSjKZ9Um2NMLfMLS77Y="
      "tweag-nickel.cachix.org-1:GIthuiK4LRgnW64ALYEoioVUQBWs0jexyoYVeLDBwRA="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "colemickens.cachix.org-1:bNrJ6FfMREB4bd4BOjEN85Niu8VcPdQe4F4KxVsb/I4="
      "cross-armed.cachix.org-1:v+RBneV2nKPSKRe3/qUFhOG6/9GE+o0lw9/NW/wX9Hk="
      "r-ryantm.cachix.org-1:gkUbLkouDAyvBdpBX0JOdIiD2/DP1ldF3Z3Y6Gqcc4c="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "all-hies.cachix.org-1:JjrzAOEUsD9ZMt8fdFbzo3jNAyEWlPAwdVuHw4RD43k="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
      "arm.cachix.org-1:fGqEJIhp5zM7hxe/Dzt9l9Ene9SY27PUyx3hT9Vvei0="
      "static-haskell-nix.cachix.org-1:Q17HawmAwaM1/BfIxaEDKAxwTOyRVhPG5Ji9K3+FvUU="
      "qyliss-x220:bZQtoCyr68idLFb8UQeDjnjitO/xAj52gOo9GoKZuog="
      "cole-h.cachix.org-1:qmEJ4uAe5tWwFxU/U5T/Nf2+wzXM3/rCP0SIGbK0dgU="
      "nixpkgs-update.cachix.org-1:6y6Z2JdoL3APdu6/+Iy8eZX2ajf09e4EE9SnxSML1W8="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "tartavull.cachix.org-1:xxmUheA3nzwan59bFhfKEShnPeDXMeii+sWHnbq8PsQ="
      "rewine.cachix.org-1:aOIg9PvwuSefg59gVXXxGIInHQI9fMpskdyya2xO+7I="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "coq.cachix.org-1:5QW/wwEnD+l2jvN6QRbRRsa4hBHG3QiQQ26cxu1F5tI="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "pandoc-crossref.cachix.org-1:LI9ABFTkGpPCTkUTzoopVSSpb1a26RSTJNMsqVbDtPM="
      "rycee.cachix.org-1:TiiXyeSk0iRlzlys4c7HiXLkP3idRf20oQ/roEUAh/A="
      "copier.cachix.org-1:sVkdQyyNXrgc53qXPCH9zuS91zpt5eBYcg7JQSmTBG4="
      "nixjs.cachix.org-1:3v2zgxvA0y7kmoD1/oIXfVRnDWZA+F3ysfT9TbBBg/E="
      "nammayatri.cachix.org-1:PiVlgB8hKyYwVtCAGpzTh2z9RsFPhIES6UKs0YB662I="
      "ryan4yin.cachix.org-1:Gbk27ZU5AYpGS9i3ssoLlwdvMIh0NxG0w8it/cv9kbU="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "bbigras-nix-config.cachix.org-1:aXL6Q9Oi0jyF79YAKRu17iVNk9HY0p23OZX7FA8ulhU="
      "fufexan.cachix.org-1:LwCDjCJNJQf5XD2BV+yamQIMZfcKWR9ISIFy5curUsY="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "veloren-nix.cachix.org-1:zokfKJqVsNV6kI/oJdLF6TYBdNPYGSb+diMVQPn/5Rc="
      "sandkasten.cachix.org-1:Pa7qfdlx7bZkko+ojaaEG9pyziZkaru9v4TfcioqNZw="
      "matrix.cachix.org-1:h2ZM1LtvJBQhCb7a2Z/UpO8PKKIUlIvifvrFKfnHkro="
      "hie-nix.cachix.org-1:EjBSHzF6VmDnzqlldGXbi0RM3HdjfTU3yDRi9Pd0jTY="
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      "hercules-ci.cachix.org-1:ZZeDl9Va+xe9j+KqdzoBZMFJHVQ42Uu/c/1/KMC5Lw0="
      "viperml.cachix.org-1:qZhKBMTfmcLL+OG6fj/hzsMEedgKvZVFRRAhq7j8Vh8="
      "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
      "toonn-nur.cachix.org-1:aeZ38ZZXR12hNBHKmb9sFQwiouA2HGKBdekzxVpd+9c="
      "zeek.cachix.org-1:Jv0hB/P5eF7RQUZgSQiVqzqzgweP29YIwpSiukGlDWQ="
      "nix-gaming.cachix.org-1:vn/szRSrx1j0IA/oqLAokr/kktKQzsDgDPQzkLFR9Cg="
      "neovim-nightly.cachix.org-1:feIoInHRevVEplgdZvQDjhp11kYASYCE2NGY9hNrwxY="
    ];
  };

}
