{
  description = "A highly structured configuration database.";

  inputs =
    {
      nixos.url = "nixpkgs/nixos-unstable";
      latest.url = "nixpkgs";
      digga.url = "github:divnix/digga";

      ci-agent = {
        url = "github:hercules-ci/hercules-ci-agent";
        inputs = { nix-darwin.follows = "darwin"; nixos-20_09.follows = "nixos"; nixos-unstable.follows = "latest"; };
      };
      darwin.url = "github:LnL7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "latest";
      home.url = "github:nix-community/home-manager";
      home.inputs.nixpkgs.follows = "nixos";
      naersk.url = "github:nmattia/naersk";
      naersk.inputs.nixpkgs.follows = "latest";
      nixos-hardware.url = "github:nixos/nixos-hardware";

      pkgs.url = "path:./pkgs";
      pkgs.inputs.nixpkgs.follows = "nixos";
    };

  outputs = inputs@{ self, pkgs, digga, nixos, ci-agent, home, nixos-hardware, nur, ... }:
    digga.lib.mkFlake {
      inherit self inputs;

      channelsConfig = { allowUnfree = true; };

      channels = {
        nixos = {
          imports = [ (digga.lib.importers.overlays ./overlays) ];
          overlays = [
            ./pkgs/default.nix
            pkgs.overlay # for `srcs`
            nur.overlay
          ];
        };
        latest = { };
      };

      lib = import ./lib { lib = digga.lib // nixos.lib; };

      sharedOverlays = [
        (final: prev: {
          lib = prev.lib.extend (lfinal: lprev: {
            our = self.lib;
          });
        })
      ];

      nixos = {
        hostDefaults = {
          system = "x86_64-linux";
          channelName = "nixos";
          modules = ./modules/module-list.nix;
          externalModules = [
            { _module.args.ourLib = self.lib; }
            ci-agent.nixosModules.agent-profile
            home.nixosModules.home-manager
            ./modules/customBuilds.nix
          ];
        };

        imports = [ (digga.lib.importers.hosts ./hosts) ];
        hosts = {
          /* set host specific properties here */
          Kronos = { };
        };
        importables = rec {
          profiles = digga.lib.importers.rakeLeaves ./profiles // {
            users = digga.lib.importers.rakeLeaves ./users;
          };
          suites = with profiles; rec {
            base = [ core users.marvin users.root ];
            head = [ audio graphical ];
            dev = [ development virtualisation ];

            kronos = base ++ head ++ dev ++ [ creative entertainment ];
          };
        };
      };

      home = {
        modules = ./users/modules/module-list.nix;
        externalModules = [ ];
        importables = rec {
          profiles = digga.lib.importers.rakeLeaves ./users/profiles;
          suites = with profiles; rec {
            base = [ shell ];
            head = [ alacritty browser ];
            dev = [ development ];
            
            workstation = base ++ head ++ dev ++ [ music ];
          };
        };
      };

      homeConfigurations = digga.lib.mkHomeConfigurations self.nixosConfigurations;

      deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };

      defaultTemplate = self.templates.flk;
      templates.flk.path = ./.;
      templates.flk.description = "flk template";

    }
  ;
}
