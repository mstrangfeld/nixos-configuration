{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.development.rust;
in {
  options.modules.development.rust.enable = mkEnableOption "Rust";

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        cargo # Downloads your Rust project's dependencies and builds your project
        cargo-rr # Cargo subcommand "rr": a light wrapper around rr, the time-travelling debugger
        rust-analyzer # A modular compiler frontend for the Rust language
        rustc # A safe, concurrent, practical language
        rustfmt # A tool for formatting Rust code according to style guidelines
      ];
    }

    (mkIf config.modules.desktop.enable {
      home-manager.users.marvin = { pkgs, ... }: {
        programs.vscode.extensions = with pkgs.vscode-extensions; [
          ms-vscode.cpptools
          vadimcn.vscode-lldb
          matklad.rust-analyzer
        ];
      };
    })
  ]);
}
