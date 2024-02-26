{ inputs, ... }: {
  imports = [];
  disko.devices.disk.main.content.partitions.luks = {
    size = "100%";
    content = {
      type = "luks";
      name = "crypted";
      askPassword = true;
      settings.allowDiscards = true;
    };
  };
}
