# To-Do: Security Hardening

- [ ] Enable Full Disk Encryption
  - [ ] Configure Plymouth to use graphical disk unlock
- [ ] Enable Secure Boot
- [ ] Follow as many recommendations from `lynis` as possible
- [ ] Write system-wide script that notifies primary user upon SSH login.
  `sudo -u USERNAME DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/<UID>/bus notify-send`
  - [ ] Configure PAM to run this script on remote login

