{ pkgs, ... }:
let
  colorscheme = import ../color { format = "#"; };
  tmux-status = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "status";
    rtpFilePath = "status.tmux";
    version = "dev";
    src = ./tmux-status;
  };
in
{

  imports = [
    ./dotfiles
    ./scripts
  ];

  home.packages = with pkgs; [
    cht-sh # CLI for cheat.sh
    fd # Simple, fast alternative to find
    fselect # Find files with SQL-like queries
    gh # GitHub CLI tool
    gopass # The slightly more awesome Standard Unix Password Manager for Teams
    gotop # A terminal based graphical activity monitor
    python39Packages.howdoi # Instant coding answers via the command line
    httpie # A command line HTTP client
    navi # An interactive cheatsheet tool for the command-line and application launchers
    ranger # File manager with minimalistic curses interface
    rclone # Command line program to sync files and directories to and from major cloud storage
    ripgrep # A utility that combines the usability of The Silver Searcher with the raw speed of grep
    thefuck # Magnificent app which corrects your previous console command
    tldr # Simplified and community-driven man pages
    # tmux # Terminal multiplexer
    ueberzug # An alternative for w3mimgdisplay
    watson # A wonderful CLI to track your time!
  ];

  # The Z shell
  programs.zsh = {
    enable = true;
    # defaultKeymap = "vicmd";
    zplug = {
      enable = true;
      plugins = [
        { name = "hcgraf/zsh-sudo"; }
        { name = "bcho/Watson.zsh"; }
      ];
    };
    autocd = true;
    initExtra = ''
      zstyle ':completion:*' menu select
    '';
    shellAliases = {
      lg = "lazygit";
      tmp = "cd $(mktemp -d)";

      ls = "exa --color=auto --group-directories-first --icons";
      la = "exa -aF --color=auto --group-directories-first --icons";
      ll = "exa -alF --color=auto --group-directories-first --icons";

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
      git_branch = {
        style = "bold green";
      };
    };
  };

  # A cat(1) clone with wings
  programs.bat = {
    enable = true;
  };

  # A shell extension that manages your environment
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
    };
  };

  # Replacement for ls written in Rust
  programs.exa = {
    enable = true;
    enableAliases = false;
  };

  # Command-line fuzzy finder written in Go
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # An interactive process viewer for Linux
  programs.htop = {
    enable = true;
  };

  # A lightweight and flexible command-line JSON processor
  programs.jq = {
    enable = true;
  };

  # Simple terminal UI for git commands
  programs.lazygit = {
    enable = true;
  };

  # Vim text editor fork focused on extensibility and agility
  programs.neovim = {
    enable = true;
  };

  # Terminal multiplexer
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
      {
        plugin = tmux-status;
        extraConfig = ''
          set -g @colorscheme_base00 "${colorscheme.base00}";
          set -g @colorscheme_base01 "${colorscheme.base01}";
          set -g @colorscheme_base02 "${colorscheme.base02}";
          set -g @colorscheme_base03 "${colorscheme.base03}";
          set -g @colorscheme_base04 "${colorscheme.base04}";
          set -g @colorscheme_base05 "${colorscheme.base05}";
          set -g @colorscheme_base06 "${colorscheme.base06}";
          set -g @colorscheme_base07 "${colorscheme.base07}";
          set -g @colorscheme_base08 "${colorscheme.base08}";
          set -g @colorscheme_base09 "${colorscheme.base09}";
          set -g @colorscheme_base0A "${colorscheme.base0A}";
          set -g @colorscheme_base0B "${colorscheme.base0B}";
          set -g @colorscheme_base0C "${colorscheme.base0C}";
          set -g @colorscheme_base0D "${colorscheme.base0D}";
          set -g @colorscheme_base0E "${colorscheme.base0E}";
          set -g @colorscheme_base0F "${colorscheme.base0F}";
          set -g @onedark_date_format "%D | CW%V"
          set -g @onedark_widgets '#(fancywatsonstatus)'
        '';
      }
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
    extraConfig = {
      pull.rebase = false;
    };
  };
}
