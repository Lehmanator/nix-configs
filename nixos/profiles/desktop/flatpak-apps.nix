{ self, inputs
, config, lib, pkgs
, ...
}:
let
  equivalentApps = {
    "ca.andyholmes.Valent" = pkgs.valent;
    "com.belmoussaoui.Decoder" = pkgs.gnome-decoder;
    "com.belmoussaoui.Authenticator" = pkgs.authenticator;
    "com.github.belmoussaoui.Authenticator" = pkgs.authenticator;
    "com.chatterino.chatterino" = pkgs.chatterino2;
    "com.belmoussaoui.Obfuscate" = pkgs.gnome-obfuscate;
    "app.drey.Dialect" = pkgs.dialect;
    "app.drey.EarTag" = pkgs.eartag;
    "app.drey.Elastic" = pkgs.elastic;
    "app.drey.Warp" = pkgs.warp;
    "net.sapples.LiveCaptions" = pkgs.livecaptions;
  };
in
{
  services.flatpak.packages = lib.lists.unique [
    "app.drey.Blurble"
    #"app.drey.EarTag"
    #"app.drey.Elastic"
    #"net.sapples.LiveCaptions"
    #"app.drey.Warp"
    "chat.schildi.desktop"
    "codes.loers.Karlender"
    "codes.loers.Punchclock"
    "com.belmoussaoui.ReadItLater"
    "com.belmoussaoui.ashpd.demo"
    "com.borgbase.Vorta"
    "com.github.Darazaki.Spedread"
    "com.github.Eloston.UngoogledChromium"
    "com.github.Eloston.UngoogledChromium.Codecs"
    "com.github.GradienceTeam.Gradience"
    "com.github.IsmaelMartinez.teams_for_linux"
    "com.github.LongSoft.UEFITool"
    "com.github.alainm23.planner"
    "com.github.alexhuntley.Plots"
    "com.github.alexkdeveloper.desktop-files-creator"
    "com.github.alexkdeveloper.dwxmlcreator"
    "com.github.cassidyjames.clairvoyant"
    "com.github.cassidyjames.dippi"
    "com.github.finefindus.eyedropper"
    "com.github.flxzt.rnote"
    "com.github.geigi.cozy"
    "com.github.hugolabe.Wike"
    "com.github.huluti.Curtail"
    "com.github.jeromerobert.pdfarranger"
    "com.github.kalibari.audok"
    "com.github.liferooter.textpieces"
    "com.github.maoschanz.DynamicWallpaperEditor"
    "com.github.maoschanz.drawing"
    "com.github.marhkb.Pods"
    "com.github.mdh34.hackup"
    "com.github.neithern.g4music"
    "com.github.philip_scott.notes-up"
    "com.github.rafostar.Clapper"
    "com.github.tchx84.Flatseal"
    "com.github.unrud.VideoDownloader"
    "com.github.wwmm.easyeffects"
    "com.gitlab.adnan338.Invoicer"
    "com.google.AndroidStudio"
    "com.hunterwittenborn.Celeste"
    "com.neatdecisions.Detwinner"
    "com.obsproject.Studio"
    "com.rafaelmardojai.Blanket"
    "com.rafaelmardojai.SharePreview"
    "com.ranfdev.Geopard"
    "com.ranfdev.Lobjur"
    "com.vixalien.sticky"
    "com.yktoo.ymuse"
    "de.haeckerfelix.AudioSharing"
    "de.haeckerfelix.Fragments"
    "de.schmidhuberj.tubefeeder"
    "dev.Cogitri.Health"
    "dev.edfloreshz.Done"
    "dev.geopjr.Collision"
    #"dev.geopjr.Tuba"
    "dev.jamiethalacker.window_painter"
    "fr.free.Homebank"
    "fr.romainvigier.MetadataCleaner"
    "fyi.zoey.Boop-GTK"
    "hu.irl.cameractrls"
    "hu.kramo.Cartridges"
    "im.bernard.Funkcio"
    "im.bernard.Nostalgia"
    "io.bassi.Amberol"
    "io.github.Bavarder.Bavarder"
    "io.github.antimicrox.antimicrox"
    "io.github.cleomenezesjr.Escambo"
    "io.github.davidoc26.wallpaper_selector"
    "io.github.dgsasha.Remembrance"
    "io.github.diegoivan.pdf_metadata_editor"
    "io.github.dubstar_04.design"
    "io.github.fabrialberio.pinapp"
    "io.github.fkinoshita.Telegraph"
    "io.github.fsobolev.TimeSwitch"
    "io.github.lainsce.Colorway"
    "io.github.lainsce.Countdown"
    "io.github.lainsce.DotMatrix"
    "io.github.lainsce.Emulsion"
    "io.github.lainsce.Khronos"
    "io.github.lainsce.Notejot"
    "io.github.limads.Queries"
    "io.github.mpobaschnig.Vaults"
    "io.github.mrvladus.List"
    "io.github.nate_xyz.Conjure"
    "io.github.nate_xyz.Paleta"
    "io.github.nate_xyz.Resonance"
    "io.github.prateekmedia.appimagepool"
    "io.github.realmazharhussain.GdmSettings"
    "io.github.seadve.Kooha"
    "io.github.seadve.Mousai"
    "io.github.swanux.hbud"
    "io.github.unicornyrainbow.secrets"
    "io.github.vegad.vnotes"
    "io.github.vikdevelop.SaveDesktop"
    "io.github.xaos_project.XaoS"
    "io.github.yairm210.unciv"
    "io.github.zhrexl.thisweekinmylife"
    "io.gitlab.adhami3310.Converter"
    "io.gitlab.gregorni.ASCIIImages"
    "io.gitlab.librewolf-community"
    "io.gitlab.theevilskeleton.Upscaler"
    "io.gitlab.zehkira.Monophony"
    "io.posidon.Paper"
    "it.mijorus.smile"
    "ml.mdwalters.EightBall"
    "net.cozic.joplin_desktop"
    "net.danigm.timetrack"
    "net.natesales.Aviator"
    "net.scribus.Scribus"
    "nl.v0yd.Capsule"
    "org.blackfennec.app"
    "org.blackfennec.app.extensions.base"
    "org.blackfennec.app.extensions.core"
    "org.cryptomator.Cryptomator"
    "org.cvfosammmm.Setzer"
    "org.emilien.Password"
    "org.fdroid.Repomaker"
    "org.freedesktop.Bustle"
    "org.gabmus.whatip"
    "org.gaphor.Gaphor"
    "org.gimp.GIMP"
    "org.gnome.Adwaita1.Demo"
    "org.gnome.Boxes"
    "org.gnome.Boxes.Extension.OsinfoDb"
    "org.gnome.Builder"
    "org.gnome.Calls"
    "org.gnome.Crosswords"
    "org.gnome.Crosswords.PuzzleSets.gnome"
    "org.gnome.Crosswords.PuzzleSets.keesing"
    "org.gnome.Crosswords.PuzzleSets.nienteperniente"
    "org.gnome.Crosswords.PuzzleSets.oedipus"
    "org.gnome.Crosswords.PuzzleSets.puzzlepull"
    "org.gnome.Crosswords.PuzzleSets.pzzl"
    "org.gnome.Crosswords.PuzzleSets.xword-dl"
    "org.gnome.DejaDup"
    "org.gnome.Games"
    "org.gnome.Keysign"
    "org.gnome.Lollypop"
    "org.gnome.Loupe"
    "org.gnome.Loupe.HEIC"
    "org.gnome.Notes"
    "org.gnome.Polari"
    "org.gnome.Snapshot"
    "org.gnome.Solanum"
    "org.gnome.World.PikaBackup"
    "org.gnome.design.AppIconPreview"
    "org.gnome.design.BannerViewer"
    "org.gnome.design.Contrast"
    "org.gnome.design.Emblem"
    "org.gnome.design.IconLibrary"
    "org.gnome.design.Palette"
    "org.gnome.design.SymbolicPreview"
    "org.gnome.design.Typography"
    "org.gnome.gitlab.Cowsay"
    "org.gnome.gitlab.YaLTeR.Identity"
    "org.gnome.gitlab.YaLTeR.VideoTrimmer"
    "org.gnome.gitlab.cheywood.Iotas"
    "org.gnucash.GnuCash"
    "org.inkscape.Inkscape"
    "org.kde.PlatformTheme.QtSNI"
    "org.kde.okular"
    "org.kde.skrooge"
    #"org.libreoffice.LibreOffice"
    "org.mozilla.firefox"
    "org.nickvision.money"
    "org.nickvision.tagger"
    "org.nickvision.tubeconverter"
    "org.onionshare.OnionShare"
    "org.onlyoffice.desktopeditors"
    "org.openshot.OpenShot"
    "org.pitivi.Pitivi"
    "org.pitivi.Pitivi.Codecs"
    "org.remmina.Remmina"
    "org.ryujinx.Ryujinx"
    "org.shotcut.Shotcut"
    #"org.signal.Signal"
    "org.upscayl.Upscayl"
    "org.wireshark.Wireshark"
    "re.sonny.Commit"
    "re.sonny.Junction"
    "re.sonny.OhMySVG"
    "re.sonny.Playhouse"
    "re.sonny.Retro"
    #"re.sonny.Tangram"
    "re.sonny.Workbench"
    "se.manyver.Manyverse"
    "se.sjoerd.Graphs"
    #"xyz.diamondb.gtkcord4"
  ];
}
