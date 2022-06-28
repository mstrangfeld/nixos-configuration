{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.desktop;
  spotify-4k = pkgs.spotify.override { deviceScaleFactor = 1.5; };
  myAspell = (pkgs.aspellWithDicts (ds: with ds; [ de en en-computers en-science ]));
in {
  imports = [
    ./audio
    ./browser
    ./creative
    ./games
    ./gnome
    ./v4l2loopback
    ./wm
    ./yubikey
  ];

  options.modules.desktop = {
    enable = mkEnableOption "Desktop";
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        # Communication
        discord # All-in-one cross-platform voice and text chat for gamers
        gopro-webcam
        # TODO: Rocket.Chat
        signal-desktop # Private, simple, and secure messenger
        zoom-us # zoom.us video conferencing application

        # Media Applications
        anki # Spaced repetition flashcard program
        vlc # Cross-platform media player and streaming server
        spotify-4k # Play music from the Spotify music service

        # Files
        borgbackup # Deduplicating archiver / backup tool
        pcloud # Secure and simple to use cloud storage for your files; pCloud Drive, Electron Edition

        # Video
        vulkan-tools

        # Emacs
        sqlite
        myAspell
      ];
    };

    programs.adb.enable = true;

    home-manager.users.marvin = { pkgs, ... }: {

      home.file.".aspell.conf".text = "data-dir ${myAspell}/lib/aspell";

      home.keyboard = {
        layout = "de";
        options = [
          "eurosign:e"
        ];
      };

      programs.alacritty = {
        enable = true;
        settings = {
          window.startup_mode = "Maximized";
        };
      };

      services.kdeconnect = {
        enable = true;
        indicator = true;
      };

      xdg = {
        enable = true;
        userDirs = {
          enable = true;
          createDirectories = true;
        };
        mime.enable = true;
        mimeApps = {
          enable = true;
          defaultApplications = {
            "text/html" = [ "brave-browser.desktop" ];
            "text/xml" = [ "brave-browser.desktop" ];
            "application/xhtml_xml" = [ "brave-browser.desktop" ];
            "image/webp" = [ "brave-browser.desktop" ];
            "x-scheme-handler/http" = [ "brave-browser.desktop" ];
            "x-scheme-handler/https" = [ "brave-browser.desktop" ];
            "x-scheme-handler/ftp" = [ "brave-browser.desktop" ];
          };
          associations.added = {
            "text/html" = [ "brave-browser.desktop" ];
            "text/xml" = [ "brave-browser.desktop" ];
            "application/xhtml_xml" = [ "brave-browser.desktop" ];
            "image/webp" = [ "brave-browser.desktop" ];
            "x-scheme-handler/https" = [ "brave-browser.desktop" ];
            "x-scheme-handler/ftp" = [ "brave-browser.desktop" ];
          };
        };
      };

      programs.gpg = {
        enable = true;
      };

      services.gpg-agent = {
        enable = true;
        defaultCacheTtl = 1800;
        defaultCacheTtlSsh = 1800;
        enableSshSupport = true;
      };

      programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
          # asciidoctor.asciidoctor-vscode # Not yet implemented
          formulahendry.auto-close-tag
          formulahendry.auto-rename-tag
          ms-vscode.cpptools
          ms-azuretools.vscode-docker
          editorconfig.editorconfig
          pkief.material-icon-theme
          bbenoist.nix
          # jprestidge.theme-material-theme # Not yet implemented
          vscodevim.vim
          dotjoshjohnson.xml
          redhat.vscode-yaml
        ];
      };

      programs.emacs = {
        enable = true;
        extraPackages = epkgs: with epkgs; [
          vterm
          pdf-tools
        ];
      };

      services.emacs = {
        enable = true;
        client.enable = true;
      };
    };
  };
}
