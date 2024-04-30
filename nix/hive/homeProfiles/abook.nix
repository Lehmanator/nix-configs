{ inputs , config , lib , pkgs , ... }: {
  # --- Address Book ---
  programs.abook = {
    enable = true;
    extraConfig = ''
      # --- Extra Fields ---
      field address_lines = Address, list
      field birthday = Birthday, date
      field anniversary = Anniversary, date
      field meetDate = Date Met, date
      field death = Death, date
      field usernames = Usernames, list
      field preferredMedium = Preferred Contact Method, string
      field ringtone = Ringtone File, string
      field vibration = Vibration Pattern, string
      field photo = Photo, string
      field color = Color, string
      field organization = Organization, string
      field notes = Notes, string
      field phonetic = Phonetic Spelling, string
      field gpgKey = GPG Key, string
      field sshKey = SSH Key, string
      field sshCert = SSH Certificate, string
      field ageKey = age Key, string

      # --- Views ---
      view CONTACT = name, email, organization
      view ADDRESS = address_lines, city, state, zip, country
      view PHONE = phone, workphone, pager, mobile, fax
      view INTERNET = url, email, usernames
      view DATES = birthday, anniversary, death, meetDate
      view SETTINGS = ringtone, vibration, color, photo
      view OTHER = notes

      # --- Options ---
      set address_style=us
      set add_email_prevent_duplicates=false
      set autosave=true
      set index_format=" {name:22} {email:40} {phone:12|workphone|mobile}"
      set preserve_fields=all
      set show_all_emails=true
      set use_ascii_only=false
    '';
  };
}
