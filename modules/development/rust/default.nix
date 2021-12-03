{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      cargo # Downloads your Rust project's dependencies and builds your project
      cargo-rr # Cargo subcommand "rr": a light wrapper around rr, the time-travelling debugger
      rls # Rust Language Server - provides information about Rust programs to IDEs and other tools
      rustc # A safe, concurrent, practical language
      rustfmt # A tool for formatting Rust code according to style guidelines
    ];
  };
}
