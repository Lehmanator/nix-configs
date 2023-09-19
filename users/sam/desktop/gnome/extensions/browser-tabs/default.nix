{ inputs, self
, config, lib, pkgs
, ...
}:
# Extension to search for open browser tabs in GNOME Shell search & anything utilizing the search provider
{
  imports = [
  ];

  home.packages = [
    # Shell Extension / Search Provider
    # https://github.com/harshadgavali/searchprovider-for-browser-tabs/
    # https://extensions.gnome.org/extension/4733/browser-tabs/
    pkgs.gnomeExtensions.browser-tabs

    # --- Host Connector ---
    # TODO: Package for nixpkgs
    # See: https://ryantm.github.io/nixpkgs/languages-frameworks/gnome/#sec-language-gnome
    # https://github.com/harshadgavali/searchprovider-for-browser-tabs/releases/
    # https://github.com/harshadgavali/searchprovider-for-browser-tabs/releases/download/connector-v0.1.1/gnome-tabsearchprovider-connector.connector-v0.1.1.zip

    # --- Browser Extension ---
    # TODO: Package for nixpkgs
    # See: https://ryantm.github.io/nixpkgs/builders/packages/firefox/
    # https://addons.mozilla.org/en-US/firefox/addon/tab-search-provider-for-gnome

  ];
}
