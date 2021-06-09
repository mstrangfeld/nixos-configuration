{ pkgs, ... }:
{

  imports = [
    ./scripts
  ];

  home.packages = with pkgs; [
    cht-sh # CLI for cheat.sh
    fd # Simple, fast alternative to find
    fselect # Find files with SQL-like queries
    glances # System monitoring
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
    watson # A wonderful CLI to track your time!
  ];

  # The Z shell
  programs.zsh = {
    enable = true;
    defaultKeymap = "vicmd";
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
    };
  };

  # A minimal, blazing fast, and extremely customizable prompt for any shell
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
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
    enableNixDirenvIntegration = true;
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

  # GitHub CLI tool
  programs.gh = {
    enable = true;
    editor = "nvim";
    gitProtocol = "ssh";
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
    clock24 = true;
    keyMode = "vi";
  };

  # A new cd command that helps you navigate faster by learning your habits
  programs.z-lua = {
    enable = true;
    enableAliases = true;
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
