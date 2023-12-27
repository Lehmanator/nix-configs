# Bootloader Documentation

## NixOS Bootloader Stuff

### systemd-repart

Can be used to make an installation image.

- TODO: Is this abstracted away be options/isoImage build targets?

#### repartConfig Options

 Partition Type UUIDs from the [Discoverable Partitions Spec](https://uapi-group.org/specifications/specs/discoverable_partitions_specification)
 [Boot Loader Spec](https://uapi-group.org/specifications/specs/boot_loader_specification)

 UUID = "";
 Priority = "<signed-bigint>;"
 Weight = <range:0-1000000>; # Available disk space is assigned according to relative "weights"
 PaddingWeight = <range:0-1000000>; # Similar to `Weight`, but for free space after the partition "("padding")"
 SizeMinBytes = "512M"; # PaddingMinBytes = ""512M";  "
 SizeMaxBytes = "25G";  # PaddingMaxBytes = ""25G";"
 CopyBlocks = <path>; # Block device node or directory or special value "auto". If specified & partition newly created, the data from the specified path is written to the newly created partition, on the block level. If dir specified, the backing block device of the fs containing the dir is determined, and data copied from that block device. **Useful for efficiently replicating existing filesystems onto new partitions on the block level...e.g. for building simple OS installer or OS image "builder."
  If "auto", the copy source is automatically picked up from running system (or the img specified w/ --image=). Will try to find partition matching `Type=` & directory mounted most appropriate for that part type. `CopyBlocks=auto` is useful for implementing "self-replicating" systems (i.e. systems that are their own installer). Never overwrites existing data! Incompatible w/ `Format=` & "`CopyFiles=`"
 Format = "btrfs";  # ext4 | btrfs | xfs | vfat | erofs | squashfs | "swap"
 CopyFiles = ""<srcPath:dstPath>";"
 ExcludeFiles=<src-abs-path>; #ExcludeFilesTarget=<dst-abs-path>;  # Excludes files from `CopyFiles=`, "etc."
 MakeDirectories = "<path> ..."; # Whitespace-sep paths of new paths to create within new "fs."
 Subvolumes = "<path> ...";  # BTRFS subvolumes to create, specified by destination "paths."
 Encrypt = "key-file+tpm2";  # off | key-file | tpm2 | key-file+tpm2 # Whether to format w/ LUKS2 "superblock."
 Verity = "off";  # off | data | hash | signature  # If "hash", part populated w/ verity hashes from matching verity data partition. If "signature", populated w/ JSON object containing sig of the verity root hash of the matching verity hash partition. If "off"/"data", populated w/ content as specified by `CopyBlocks=` or `CopyFiles=`. Matching verity partition is part w same verity match key (configured w/ `VerityMatchKey=`. Incompatible w/ option `Encrypt=`"
 VerityMatchKey = "";  # Short, user-chosen identifier string. Used to find sibling verity partitions for current verity partition.
 VerityDataBlockSizeBytes = 4096;  # Data block size of generated verity hash partition. Must be power-of-2 between 512 & 4096.
 VerityHashBlockSizeBytes = 4096;  # Like above, but for hash block size. Must be power-of-2 between 512 & 4096.
 FactoryReset = false;  # If true, partition marked for removal during factory reset operation.
 Flags = 64bit GPT partition flags field to set for partitions when creting.
 NoAuto = false. # Mount fs w/ `noauto`
 ReadOnly = false; # Mount fs read-only
 GrowFileSystem = false; # Grow FS upon mounting.
 SplitName = "%t";  # Suffix to append to split artifacts when using `--split` option. To disable split artifact generation for a partition, set `SplitName="-".
 Minimize = "off";  # off | guess | best  # If "best", part will have minimum req size to store sources from `CopyFiles=`. (only supported on read-only partitions). If "guess", part created at least as big. (may slow down repart if not read-only part.

 --- Special Strings ---
 These get expanded in some string options.

  Specifiers: (used in `Label=`, `CopyBlocks=`, `CopyFiles=`, `MakeDirectories=`, `SplitName=`.

  - "%a" - Architecture (x86_64 | arm64 | ...)
  - "%A" - OS image version. `IMAGE_VERSION` field of `/etc/os-release`
  - "%b" - Boot ID of the running system.
  - "%B" - OS build ID of running system. `BUILD_ID=` field of `/etc/os-release`
  - "%H" - Hostname of running system.
  - "%m" - Machine ID of running system.
  - "%M" - OS image identifier of running system.
  - "%o" - OS system ID of running system. `ID=` field of `/etc/os-release`
  - `%v` - Kernel release. Identical to `uname -r` output.
  - `%w` - OS version ID. `VERSION_ID=` field of `/etc/os-release`
  - `%W` - OS variant ID. `VARIANT_ID=` field of `/etc/os-release`
  - `%T` - Dir for temp files. Either `/tmp` or path `$TMPDIR`/`$TEMP`/`$TMP` set to.
  - `%V` - Dir for large and persistent temp files. Either `/var/tmp` or ` path `$TMPDIR`/`$TEMP`/`$TMP` set to.
  - `%%` - Single percent sign. Escape sequence for '%' symbol.

  Specifiers: (`SplitName=`)

  - "%T" - Partition type UUID
  - "%t" - Partition type identifier corresp. to part type UUID
  - `%u` - Partition UUID. As configured w/ `UUID=`





## Partitioning Documentation

 [Discoverable Partitions Spec](https://uapi-group.org/specifications/specs/discoverable_partitions_specification)
 [Boot Loader Spec](https://uapi-group.org/specifications/specs/boot_loader_specification)
 [Automatic Boot Assessment](https://systemd.io/AUTOMATIC_BOOT_ASSESSMENT)
 [The Bootloader Interface](https://systemd.io/BOOT_LOADER_INTERFACE/)

 On disks with an MBR partition table:
   - The boot partition — a partition with the type ID of 0xEA — shall be used as the single location for boot loader menu entries.

 On disks with GPT (GUID Partition Table):
   - The EFI System Partition (`ESP` for short) — a partition with a GPT type GUID of `c12a7328-f81f-11d2-ba4b-00a0c93ec93b` — may be used as one of two locations for boot loader menu entries.
   - Optionally, an Extended Boot Loader Partition (XBOOTLDR partition for short) — a partition with GPT type GUID of `bc13c2ff-59e6-4262-a352-b275fd6f7172` — may be used as the second of two locations for boot loader menu entries. This partition must be located on the same disk as the `ESP`.

 --- `$BOOT` Partition Placeholder (GPT tables) ---

 1. `XBOOTLDR`, if exists
 2. `ESP`,      as fallback


### OS Install Logic (GPT)

 - If `XBOOTLDR` partition exists, use as `$BOOT` & primary bootloader resource location.
 - Otherwise, if `ESP` partition is found & large enough, use as `$BOOT` & primary bootloader resource location.
 - Otherwise, create `ESP` partition of appropriate size then, use as `$BOOT` & primary bootloader resource location
 - Otherwise, create `XBOOTLDR` partition of appropriate size, use as `$BOOT` & primary bootloader resource location


### Recommended Mount Points

 Note: New boot entries written to `/boot/`.
 Note: Bootloader itself may have files under `/boot/` or `/efi/` depending on whether `XBOOTLDR` exists.
 Note: Traditionally, `ESP` was mounted to `/boot/efi/`, however, no longer recommended because:
   - The `vfat` filesystem has weak data integrity properties, so it should remain unmounted whenever possible.
   - Which means so it's recommended to mount `XBOOTLDR` & `ESP` with `autofs` because:
     - Mounting via `autofs` is prone to misconfiguration when the `ESP` (was `/boot/efi/`, now `/efi/`) is mounted nested within `XBOOTLDR` (`/boot/`).
 Note: `$BOOT` always should mount to `/boot/`. However, `$BOOT` refers to `XBOOTLDR` when available, but can also be `ESP`

 Ideally, these are the mount points:

 - If both `XBOOTLDR` & `ESP` present,
     - `XBOOTLDR` => `/boot/`
     - `ESP`      => `/efi/`

 - If only `ESP` present,
     - `ESP`      => `/boot/`


## Bootloader Entries



### Type 1 Boot Entries

 Type 1:
 - Text-based, simple, & wide support for firmware, architecture, & image types.

Entry Locations:

 - `$BOOT/loader/entries/`  (can always be used, but latter is preferred when `XBOOTLDR` exists)
 -  `$ESP/loader/entries/`  (only exists when `$ESP` separate from `$BOOT`. e.g. when `XBOOTLDR` exists.)
 i.e.:
 - `/boot/loader/entries/` (preferred)
 - `/efi/loader/entries/`

 `../loader/entries` should **never** be located under the `/EFI/` subdirectory on the `ESP`.

 Other files:
 - `$BOOT/loader/entries.srel` - Contains string `type1` followed by UNIX newline to assure bootloader entries within follow this spec. (Some legacy stuff places stuff formatted differently in this directory. Helps minimize confusion & uncertainty. When present, bootloader should assume conformity to these standards.
 - `$BOOT/loader/loader.conf` -
 - `$BOOT/loader/random-seed` -


#### Entry File Recommendations

 - Key-Value Pairs: First word is used as key, separated by one or more spaces from the value.
   - `title`: Human-readable title for menu item. Recommend using `PRETTY_NAME` from `/etc/os-release`
   - `version`: Human-readable version for menu item. Usually kernel version. Intended for OSes to use to install multiple kernel versions w/ same `title` field. Field used for sorting entries, so bootloader can sort entries by age & auto-select newest entry.
   - `machine-id`: Per-machine unique ID from `/etc/machine-id`. Formatted as 32 lowercase hexadecimal characters (i.e. w/o any UUID formatting.)
   - `sort-key`: Short string used for sorting entries on display. Typically should be initialized from the `IMAGE_ID=` or `ID=` fields of `/etc/os-release`, possibly with suffix. (Optional field)
   - `linux`: Linux kernel image to execute. Takes a path relative to the root of the filesystem containing the boot entry snippet itself. Recommended every distro create an `entry-token/machine-id` & version-specific subdirectory to place its kernels & initrd images.
     e.g.: `linux /6a9857a393724b7a981ebb5b8495b9ea/3.8.0-2.fc19.x86_64/linux`
   - `initrd`: The initrd `cpio` image to use when executing the kernel. May appear more than once. If so, use all the specified images, in the order listed.
     e.g.: `initrd 6a9857a393724b7a981ebb5b8495b9ea/3.8.0-2.fc19.x86_64/initrd`
   - `efi`: Refers to an arbitrary EFI program. If set & system not EFI system, entry should be hidden.
   - `options`: Kernel parameters to pass to the Linux kernel to spawn. May appear more than once. If so, combine in the order listed. (Optional.)
     e.g.: `options root=UUID=6d3376e4-fc93-4509-95ec-a21d68011da2 quiet`
   - `devicetree`: Binary device tree to use when executing kernel. (Optional.)
     e.g.: `devicetree 6a9857a393724b7a981ebb5b8495b9ea/3.8.0-2.fc19.armv7hl/tegra20-paz00.dtb`
   - `devicetree-overlay`: List of device tree overlays that should be applied by the bootloader. Space-separated and applied in same order listed. (Optional. Requires key: `devicetree`)
     e.g.: `devicetree-overlay /6a9857a393724b7a981ebb5b8495b9ea/overlays/overlay_A.dtbo /6a9857a393724b7a981ebb5b8495b9ea/overlays/overlay_B.dtbo`
   - `architecture`: Target system architecture of the entry using the arch vocabulary defined by the EFI spec. (i.e. `IA32`, `x64`, `IA64`, `ARM`, `AA64`, ...)
     e.g.: `architecture aa64`


 Complete Entry Example:
 ```
 # /boot/loader/entries/6a9857a393724b7a981ebb5b8495b9ea-3.8.0-2.fc19.x86_64.conf
 title        Fedora 19 (Rawhide)
 sort-key     fedora
 machine-id   6a9857a393724b7a981ebb5b8495b9ea
 version      3.8.0-2.fc19.x86_64
 options      root=UUID=6d3376e4-fc93-4509-95ec-a21d68011da2 quiet
 architecture x64
 linux        /6a9857a393724b7a981ebb5b8495b9ea/3.8.0-2.fc19.x86_64/linux
 initrd       /6a9857a393724b7a981ebb5b8495b9ea/3.8.0-2.fc19.x86_64/initrd
 ```

 On EFI systems, all Linux kernel images should be EFI images.
   Recommended to only install EFI kernel images to increase compatibility, even on non-EFI systems, if supported.

 Recommended that kernel images are generic kernel images that make as few assumptions about the firmware they run on as possible.
   i.e. Good if both images ship as UEFI PE images, and any that are not, don't make unnecessary assumptions about the underlying firmware. (i.e. don't depend on legacy BIOS calls or UEFI boot services.)

 All files referred to by a Type 1 bootloader entry must:
 - Be located on the same partition
 - Use absolute paths relative to the root of that filesystem.
 - Never use unnormalized path constructs (like `..` or `.`).
 - Paths may include optional `/` as path prefix, but it makes no difference as path is always relative to root of partition where reference is made from.
 - Recommended to use same case in reference and actual filepath, even if `vfat` filesystems are typically case-insensitive.






### Type 2 Boot Entries (Unified Kernel Images)

 Type 2:
 - Single-file images that embed all metadata in the kernel binary itself.
     ...which is useful to cryptographically sign them as one file.
     This simplifies SecureBoot.
     Often referred to as Unified Kernel Images (UKIs) ??


 Single EFI PE executable combining an EFI stub loader, a kernel image, an initrd image, and the kernel command-line.
   See: `systemd-stub(7)` for details.

 Advantage is that all metadata & payload for boot entry is contained in a single PE file.
   This makes it easy to be signed cryptographically. greatly simplifiing EFI SecureBoot.

 Valid UKI must contain two PE sections:

 1. `.cmdline` section with the kernel command line.
 2. `.osrel` section with an embedded copy of the `/etc/os-release` file describing the image.

 Optional fields that affect bootloader handling of the entries:
 - `PRETTY_NAME=` field in `/etc/os-release` is used the same as `title`   in Type 1 entries.
 - `VERSION_ID=`  field in `/etc/os-release` is used the same as `version` in Type 1 entries.
 - Type 1 field: `options` is used like Type 2 field: `.cmdline`
 - Type 1 fields: `linux` & `initrd` are unnecessary.
 - Type 1 field: `machine-id` has no counterpart.

 OSes should place Unified EFI kernels **only** in the `$BOOT` partition (preferably `XBOOTLDR` => `/boot/`)

 Unified Kernel Image Location: (prefer: `XBOOTLDR` exists at `/boot/` & `ESP` exists at `/efi/`)
 - Primary  : `$BOOT/EFI/Linux` (prefer: `$BOOT`=`/boot/` => `/boot/EFI/Linux`)
 - Secondary:  `$ESP/EFI/Linux` (fallback:`$ESP`=`/efi/`  =>  `/efi/EFI/Linux`)

 Filenames should follow same rules & recommendations as Type 1 entries, but the file extension suffix is `.efi` instead of `.conf`


## All Entries (Both Type 1 & Type 2)

- TODO: Make a table comparison of the source & destination of entry fields for Type 1 vs. Type 2 entries.

Formatting & naming conventions are as follows:

 Filenames:

 - Charset: Only using ASCII upper + lower, digits, & chars `+`, `-`, `_`, `.`
 - Length: Between 0-255 characters (including filename suffix)
 - Path: `/boot/loader/entries/<entry-token|machine-id>-<version>.conf`, where:
   - `entry-token` is from `kernel-install` command.
   - `machine-id`  is from `/etc/machine-id` config file.
   - `version` is kernel version as returned by command `uname -r` (including the OS identifier.)
   e.g.: `/boot/loader/entries/6a9857a393724b7a981ebb5b8495b9ea-3.8.0-2.fc19.x86_64.conf`

 Entry Contents:

 - Encoding: UTF-8 w/ UNIX-style line-endings (i.e. lines separated by single newline character)
 - Comments: Use `#` character to ignore any content following character on same line.



## Behavior with Non-conformant Files

 Entries can exist that don't apply to all systems, and the bootloader should ignore. e.g.:
 - e.g. Type 1 entries using the `efi` key.
 - e.g. Type 2 entries using a value in the `architecture` key not matching local system architecture.
 This allows image builders to create images that transparently support multiple different architectures.

