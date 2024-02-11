{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.shell;
  tmux-status = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "status";
    rtpFilePath = "status.tmux";
    version = "dev";
    src = ./tmux-status;
  };
in
{
  options.modules.shell = {
    enable = mkEnableOption "Shell";
    tmux = {
      enable = mkOption { default = true; };
      tmux-status = mkOption { default = true; };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bat # A cat(1) clone with wings
      cht-sh # CLI for cheat.sh
      eza # Replacement for ls written in Rust
      fd # Simple, fast alternative to find
      fselect # Find files with SQL-like queries
      gh # GitHub CLI tool
      gotop # A terminal based graphical activity monitor
      # python39Packages.howdoi # Instant coding answers via the command line
      htop # An interactive process viewer for Linux
      httpie # A command line HTTP client
      jq # A lightweight and flexible command-line JSON processor
      lazygit # Simple terminal UI for git commands
      ranger # File manager with minimalistic curses interface
      rclone # Command line program to sync files and directories to and from major cloud storage
      ripgrep # A utility that combines the usability of The Silver Searcher with the raw speed of grep
      tldr # Simplified and community-driven man pages
      # tmux # Terminal multiplexer
      ueberzug # An alternative for w3mimgdisplay
      watson # A wonderful CLI to track your time!
    ];
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    home-manager.users.marvin = { pkgs, ... }: {

      imports = [ ./dotfiles ./scripts ];

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        # defaultKeymap = "vicmd";
        plugins = [{
          name = "zsh-sudo";
          file = "sudo.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "hcgraf";
            repo = "zsh-sudo";
            rev = "d8084def6bb1bde2482e7aa636743f40c69d9b32";
            sha256 = "sha256-I17u8qmYttsodD58PqtTxtVZauyYcNw1orFLPngo9bY=";
          };
        }];
        autocd = true;
        initExtra = ''
          zstyle ':completion:*' menu select
        '';
        shellAliases = {
          lg = "lazygit";
          tmp = "cd $(mktemp -d)";

          ls = "eza --color=auto --group-directories-first --icons";
          la = "eza -aF --color=auto --group-directories-first --icons";
          ll = "eza -alF --color=auto --group-directories-first --icons";

          zz = "z -I -t .";
          zb = "z -I -b .";
        };
      };

      # A minimal, blazing fast, and extremely customizable prompt for any shell
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          character = {
            success_symbol = "[λ](bold green)";
            error_symbol = "[✗](bold red)";
          };
          directory = {
            truncation_length = 8;
            truncate_to_repo = false;
          };
          git_branch = { style = "bold green"; };
        };
      };

      # A shell extension that manages your environment
      programs.direnv = {
        enable = true;
        nix-direnv = { enable = true; };
      };

      # Command-line fuzzy finder written in Go
      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.tmux = {
        enable = true;
        sensibleOnTop = true;
        clock24 = true;
        keyMode = "vi";
        baseIndex = 1;
        extraConfig = builtins.readFile ./tmux.conf;
        plugins = with pkgs; [
          tmuxPlugins.yank # Tmux plugin for copying to system clipboard
          tmuxPlugins.open # Tmux key bindings for quick opening of a highlighted file or url
          tmuxPlugins.fingers # copy pasting in terminal with vimium/vimperator like hints
          (mkIf cfg.tmux.tmux-status {
            plugin = tmux-status;
            extraConfig = with config.modules.theme.colors;
              (mkIf config.modules.theme.enable ''
                set -g @colorscheme_base00 "${hex base00}";
                set -g @colorscheme_base01 "${hex base01}";
                set -g @colorscheme_base02 "${hex base02}";
                set -g @colorscheme_base03 "${hex base03}";
                set -g @colorscheme_base04 "${hex base04}";
                set -g @colorscheme_base05 "${hex base05}";
                set -g @colorscheme_base06 "${hex base06}";
                set -g @colorscheme_base07 "${hex base07}";
                set -g @colorscheme_base08 "${hex base08}";
                set -g @colorscheme_base09 "${hex base09}";
                set -g @colorscheme_base0A "${hex base0A}";
                set -g @colorscheme_base0B "${hex base0B}";
                set -g @colorscheme_base0C "${hex base0C}";
                set -g @colorscheme_base0D "${hex base0D}";
                set -g @colorscheme_base0E "${hex base0E}";
                set -g @colorscheme_base0F "${hex base0F}";
                set -g @onedark_date_format "%D | CW%V"
                set -g @onedark_widgets '#(fancywatsonstatus)'
              '');
          })
        ];
      };

      # A new cd command that helps you navigate faster by learning your habits
      programs.z-lua = {
        enable = true;
        enableAliases = false;
        enableZshIntegration = true;
      };

      # Distributed version control system
      programs.git = {
        enable = true;
        userName = "Marvin Strangfeld";
        userEmail = "marvin@strangfeld.io";
        extraConfig = { pull.rebase = false; };
      };
    };
  };
}
