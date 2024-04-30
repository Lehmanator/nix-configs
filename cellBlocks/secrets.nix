{ blockTypes }:
with blockTypes; [
  # --- Certs --------------------------
  (files "cert-tls")
  (files "cert-pkcs")
  (files "cert-ssh")

  # --- Keys ---------------------------
  (data "key")
  (files "key-age")
  (files "key-gpg")
  (files "key-luks")
  (files "key-ssh")

  # --- Secrets ------------------------
  # --- Generic -----------------
  (data "secret")
  (data "secret-user")
  (data "secret-host")
  (data "secret-repo")
  (data "secret-service")
  (files "secret-database")
  (files "secret-files")

  # --- SOPS -----------------
  (files "sops")
  (files "sops-user")
  (files "sops-host")
  (files "sops-repo")
  (files "sops-service")

  # --- Password Databases ---
  (data "password")
  (files "browser-password-database")
  (data "browser-password-entry")
  (files "keepass-database")
  (data "keepass-entry")
  (files "pass-database")
  (data "pass-entry")

  (data "keyring")
  (data "keystore")
]
