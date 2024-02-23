{ inputs
, conifg
, lib
, pkgs
, ...
}:
let
  # Verify domain ownership with Microsoft Azure
  # Host at: <domain>/.well-known/microsoft-identity-association.json
  microsoft-identity-association = ''
    {
      "associatedApplications": [
        {
          "applicationId": "bb76b9da-3e52-4c8a-bba8-c0c149aecf19"
        }
      ]
    }
  '';
in
{
  imports = [
  ];


}
