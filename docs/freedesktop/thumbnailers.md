# Thumbnailers

Programs used to generate small `.png` preview icons for various file types.
These `.png` preview images get loaded by file managers (& more?)

## Creating a Thumbnailer

Thumbnailers are simply programs or commands that generate a `.png` preview image
for a file's contents.

If you can find a program that does it for you, use that.
Otherwise, you can write your own to generate your thumbnail images.

All your program has to do is accept the following arguments:

- the file path to use as input
- the size of the preview to be generated
- the file path to write the output image

## Creating a Thumbnailer Manifest

Process:

1. First you need to figure out how to create a `.png` image from a file in the desired format. (as described above)
2. Create a `.thumbnailer` file.
3. Place this `.thumbnailer` file in the `thumbnailers` subfolder of one of the directories in `$XDG_DATA_DIRS`

   > [!NOTE] The proper directory to use in the `$XDG_DATA_DIRS` path list will depend on how it is packaged.
   > Flatpak will merge the exported `/share` directories of all the applications it manages into a unified folder located at: `$XDG_DATA_HOME/flatpak/exports/share`
   > Within `nixpkgs`, you will want to make sure your package definition exports this under the `/share/thumbnailers` dir.
   > Home-Manager (when managed by NixOS) will output the `/share` folder here: `/etc/profiles/per-user/$USER/share`

4. Restart your thumbnailer service (This is specific to each file manager) & test if it's working.

  Run: `$ nautilus -q`

## Potentially Useful Programs

- [Markdown & HTML renderer](https://github.com/Inlyne-Project/inlyne)
- https://github.com/charmbracelet/glow
- https://github.com/gnukleo/dxf-thumbnailer
- https://linux.die.net/man/1/gsf-office-thumbnailer
- https://github.com/difference-engine/thumbnail-generator-ubuntu
- https://github.com/exe-thumbnailer/exe-thumbnailer
- https://github.com/jlu5/icoextract

- https://github.com/linuxmint/xapp-thumbnailers

  - `.AppImage` applications
  - `.epub` ebooks
  - `.mp3` audio
  - `.raw` images
  - PR: `.aiff`
  - Issue: `.heic`
  - Issue: `.apk`

- https://gitlab.gnome.org/GNOME/gnome-kra-ora-thumbnailer
  - Krita: `.kra`

- Draft PR: https://gitlab.gnome.org/GNOME/nautilus/-/merge_requests/1328
- https://gitlab.gnome.org/GNOME/totem-video-thumbnailer

## To-Do

- [ ] [Contacts]() - Show the profile picture of the contact if it exists
- [ ] [SSH Keys]() - Show the fingerprint or a QR code of it or the public key?

### Executables

- [ ] [AppImages]() - Show the app icon
- [ ] [Flatpak Refs]() - Show the app icon

### Documents

- [ ] [Code]() - Give some context of the contents of files.
- [ ] [Markdown Documents]() - Preview the contents
- [ ] [Office Documents]() - Preview the contents
- [ ] [PDF Documents]() - Preview the contents
- [ ] [Text Documents]() - Preview the contents

### Multimedia

- [ ] [Album Artwork](https://github.com/flozz/cover-thumbnailer) - Show the album artwork for tracks and album folders. Show the artist picture for artist folders. Same for genres, etc.
- [ ] [3D Models]() - Render the 3D object
- [ ] [Nintendo Game Assets]() - Render the 3D object
- [ ] [Videos]() - Render an animated PNG?

### Windows Assets

- [ ] [Windows Executables]() - Show the app icon
- [ ] For .lnk thumbnailing: lnkinfo (liblnk-utils) and Wine
- [ ] For .msi thumbnailing: msitools



### Custom Folder Icons

**Idea!**: Create thumbnails for folders using the default libadwaita styling, but...

1. Tint the folder color with the user's current primary color theme.

2. Overlay the contents of the folder inside its icon, so you can have a better idea of how many children
  a directory has, and possible something about their contents.

#### Process for Generating

1. Recursively query the contents of a directory until there are either no more children
   OR the icon size of the children would be too small to display.
2. Fetch the thumbnail icons for the most deeply nested files. (These will already have been generated by other programs)
3. Generate preview icons for the most deeply nested children first.
4. Move up to the parent directory.
5. Overlay to preview of the child on some section of the parent directory's preview.
6. Work upwards until the entire hierarchy has icons generated for them.

Base Cases:

1. Empty folder. Use existing folder icons (possibly with tint)
2. Folder only contains files. Files get icons from other programs that we will need to start generating our icons.


~~3. Folder only contains empty folders.~~
