{ lib, pkgs, ... }: 
let
  # TODO: Set MIME types for RSS feeds, podcasts
  # TODO: Also handle sharing config file with flatpak.

  prefer-flatpak = false;
  prog = if prefer-flatpak then "flatpak run io.gitlab.news_flash.NewsFlash" else lib.getExe pkgs.newsflash;
in
{
  # RSS feed reader
  home.packages = lib.mkIf (! prefer-flatpak) [ pkgs.newsflash ];
  services.flatpak.packages = lib.mkIf prefer-flatpak ["io.gitlab.news_flash.NewsFlash"];


  home.shellAliases = {
    newsflash = "${prog}";                         # Bin is usually: io.gitlab.news_flash.NewsFlash
    rss       = "${prog} --headless --subscribe";  # Quickly add feed URL w/o opening app.
  };

  # xdg.configFile = {
  #   "news-flash/newsflash_gtk.json".text = builtins.toJSON {
  #     general = {
  #       keep_running_in_background = true;
  #       autostart = true;
  #       sync_on_startup = false;
  #       sync_on_metered = false;
  #       sync_every.Custom = 14400;
  #     };
  #     advanced = {
  #       proxy = {};
  #       accept_invalid_certs = false;
  #       accept_invalid_hostnames = false;
  #       inspect_article_view = false;
  #       article_view_load_images = true;
  #       ping_url = "https://resume.samlehman.dev";
  #     };
  #     feed_list = { order = "Manual"; only_show_relevant = true; };
  #     article_list = { order = "NewestFirst"; show_thumbnails = true; hide_future_articles = true; };
  #     article_view = { theme="Default"; content_width = 50; line_height = 1.5; };
  #     keybindings = {
  #       general = {refresh=""; search=""; all_articles="";  only_unread=""; only_starred=""; quit="";};
  #       article_view = {scroll_up="I"; scroll_down="U"; scrap_content="<Shift>C"; tag="<ctl>T"; fullscreen="<Shift><alt>X"; };
  #       article_list = { next = "J"; prev="K"; read="R"; mark="M"; open="O"; copy_url="<ctl><Shift>C"; };
  #       feed_list = { next = "<ctl>J"; prev="<ctl>K"; toggle_expanded="C"; read="<Shift>A"; };
  #     };
  #     share = {
  #       clipboard_enabled = true;
  #       mastodon_enabled = true;
  #       custom_enabled = true;
  #       # Note: ${url} & ${title} will be replaced w/ link data. Need to escape.
  #       # custom_name = "Lemmy"; custom_url="lemmy.${config.networking.hostName}";
  #       # custom_name = "Nextcloud"; custom_url="nextcloud.${config.networking.hostName}";
  #       # custom_name = "Pastebin"; custom_url="pastebin.${config.networking.hostName}";
  #       # custom_name = "kdeconnect"; custom_url="kdeconnect.${config.networking.hostName}";
  #       # custom_name = "matrix"; custom_url="matrix://matrix.${config.networking.hostName}";

  #       pocket_enabled = false;
  #       instapaper_enabled = false;
  #       twitter_enabled = false;
  #       reddit_enabled = false;
  #       telegram_enabled = false;
  #     };
  #     feeds = {};
  #   };

  #   # "news-flash/newsflash.json".text = builtins.toJSON {
  #   #   backend = "local_rss";
  #   #   sync_amount = 300;
  #   #   keep_articles_days = 365;
  #   #   last_sync = "2024-07-12T19:38:26.638383641+00:00"; # TODO: How to keep declarative with this key?
  #   # };

  #   # # Site content grabber rules.
  #   # #   See: [config format](https://github.com/fivefilters/ftr-site-config)
  #   # "news-flash/ftr-site-config/<domain>.txt".text = ''
  #   # '';

  #   # Feed data stored in sqlite database in ~/.local/share/news-flash/
  # };

  # dconf.settings = {
  #   "org/gnome/" = {};
  # };

}
