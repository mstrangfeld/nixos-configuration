{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [
      vterm
      pdf-tools
    ];
  };

  home.packages = with pkgs; [
    sqlite
    (aspellWithDicts (ds: with ds; [
      en
      en-computers
      en-science
    ]))
  ];

  services.emacs = {
    enable = true;
    client.enable = true;
  };
}
