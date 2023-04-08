
{ self, inputs, config, lib, pkgs,
  host, network, repo,
  device ? "flame",
  oem    ? "google",
  ...
}:
let
  # --- Chromium Patchsets ---------------------------------
  fdroid-repos = let
    inherit device oem;
  in {
    disabled = [
    ];

    enabled = [
      { name = "CalyxOS"; id="calyx";
        repo = "https://github.com/CalyxOS/calyx-fdroid-repo-${device}"; }
      { name = "GrapheneOS"; id="graphene";
        repo = ""; }
      { name = "DivestOS"; id="divest";
        repo = ""; }
      { name = "LineageOS"; id="lineage";
        repo = ""; }
    ];
  };
in
{
  imports = [];
  apps.fdroid.enable = true;

  # https://gitlab.com/fdroid/wiki/-/wikis/List-of-F-Droid-repositories
  # https://forum.f-droid.org/t/known-repositories
  apps.fdroid.additionalRepos = {
    fdroid = {
      enable = true;
      description = "F-Droid Official";
      url = "https://f-droid.org/repo";
      pubkey = "43238D512C1E5EB2D6569F4A3AFBF5523418B82E0A3ED1552770ABB9A9C9CCAB";
    };
    fdroid-archive = {
      enable = false;
      name = "F-Droid Archive";
      description = "Archived apps that were formerly on F-Droid official. Apps were archived because they had vulnerabilities, were unsupported, were incompatible with recent Android versions, or were left unmaintained.";
      url = "https://f-droid.org/archive";
      pubkey = "43238D512C1E5EB2D6569F4A3AFBF5523418B82E0A3ED1552770ABB9A9C9CCAB";
    };
    # --- ROM Repos ----------
    calyx = {
      enable = true;
      url = "https://calyxos.gitlab.io/calyx-fdroid-repo/fdroid/repo"; 
      pubkey = "C44D58B4547DE5096138CB0B34A1CC99DAB3B4274412ED753FCCBFC11DC1B7B6";
    };
    graphene = {
      enable = false;
      url = "";
      pubkey = "";
    };
    divest = {
      enable = true;
      url = "https://divestos.org/fdroid/official";
      pubkey = "E4BE8D6ABFA4D9D4FEEF03CDDA7FF62A73FD64B75566F6DD4E5E577550BE8467";
    };
    divest-unofficial = {
      enable = true;
      url = "https://divestos.org/fdroid/unofficial"; 
      pubkey = "A18CDB92F40EBFBBF778A54FD12DBD74D90F1490CB9EF2CC6C7E682DD556855D";
    };
    lineage = {
      enable = true;
      url = "";
      pubkey = "";
    };

    # --- Organizations ------
    guardian-project = {
      enable = true;
      url = "https://guardianproject.info/fdroid/repo";
      pubkey = "B7C2EEFD8DAC7806AF67DFCD92EB18126BC08312A7F2D6F3862E46013C7A6135";
    };
    guardian-project-archive = {
      enable = true;
      url = "https://guardianproject.info/fdroid/archive";
      pubkey = "B7C2EEFD8DAC7806AF67DFCD92EB18126BC08312A7F2D6F3862E46013C7A6135";
    };
    izzy-on-droid = {
      enable = true;
      url = "https://apt.izzysoft.de/fdroid/repo"; pubkey = "3BF0D6ABFEAE2F401707B6D966BE743BF0EEE49C2561B9BA39073711F628937A";
    };

    # --- Unofficial ---------
    firefox-unofficial = {
      enable = true;
      url = "https://rfc2822.gitlab.io/fdroid-firefox/fdroid/repo";
      pubkey = "8F992BBBA0340EFE6299C7A410B36D9C8889114CA6C58013C3587CDA411B4AED";
    };
    
    # --- Apps ---------------
    gitjournal = {
      enable = true;
      url = "https://gitjournal.io/fdroid/repo"; 
      pubkey = "E2EE4AA4380F0D3B3CF81EB17F5E48F827C3AA77122D9AD330CC441650894574";
    };
  };
}
