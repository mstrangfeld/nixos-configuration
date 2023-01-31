{
  description = "My personal host configurations";

  inputs = {
    nixpkgs.url =
      "github:nixos/nixpkgs/nixos-22.11"; # Nix Packages collection
    unstable.url = "github:nixos/nixpkgs";
    nur.url =
      "github:nix-community/NUR"; # Nix User Repository: User contributed nix packages
    utils.url =
      "github:gytis-ivaskevicius/flake-utils-plus"; # Use Nix flakes without any fluff
    home-manager = {
      # Manage a user environment using Nix
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url =
      "github:NixOS/nixos-hardware"; # A collection of NixOS modules covering hardware quirks.
    emacs-overlay.url =
      "github:nix-community/emacs-overlay"; # Bleeding edge emacs overlay
    agenix = {
      # age-encrypted secrets for NixOS
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs.url =
      "github:serokell/deploy-rs"; # A simple multi-profile Nix-flake deploy tool.
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    devshell.url =
      "github:numtide/devshell?ref=fff3dc6e4538f6df85ee3027f13cc7730b23f61d"; # Per project developer environments
  };

  outputs =
    inputs@{ self
    , nur
    , utils
    , home-manager
    , nixos-hardware
    , emacs-overlay
    , agenix
    , deploy-rs
    , disko
    , ...
    }:
    let userModules = utils.lib.exportModules [ ./modules ];
    in utils.lib.mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];
      channelsConfig.allowUnfree = true;

      channels.nixpkgs.overlaysBuilder = channels:
        [
          # Use packages from the unstable channel
          (final: prev: {
            inherit (channels.unstable)
              cachix discord starship;
            disko = disko.packages.${channels.unstable.system};
          })
        ];

      sharedOverlays = [
        self.overlay
        nur.overlay
        emacs-overlay.overlay
        deploy-rs.overlay
        agenix.overlays.default
        inputs.devshell.overlay
      ];

      overlay = import ./overlays;

      hostDefaults = {
        modules = [
          ./modules
          ./secrets/keys
          home-manager.nixosModules.home-manager
          agenix.nixosModules.age
          disko.nixosModules.disko
          {
            home-manager = {
              extraSpecialArgs = { inherit inputs self; };
              useUserPackages = true;
              useGlobalPkgs = true;
            };
          }
        ];
      };

      hosts = {
        Kronos = { modules = [ ./hosts/Kronos ]; };
        Eos = { modules = [ ./hosts/Eos ]; };
        Nyx = { modules = [ ./hosts/Nyx ]; };
        Apollo = { modules = [ ./hosts/Apollo ]; };
        Hermes = { modules = [ ./hosts/Hermes ]; };
        Theia = {
          modules = [
            ./hosts/Theia
            nixos-hardware.nixosModules.lenovo-thinkpad-t14
          ];
        };
      };

      deploy.nodes = {
        Eos = {
          sshUser = "root";
          hostname = "89.58.11.175";
          profiles = {
            system = {
              path = deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.Eos;
              user = "root";
            };
          };
        };
      };

      outputsBuilder = channels: {
        packages = { };
        devShells = {
          default = import ./devshell.nix { pkgs = channels.nixpkgs; };
          xmonad =
            let pkgs = channels.nixpkgs;
            in pkgs.haskellPackages.shellFor { packages = p: [ p.xmonad ]; };
        };
      };
    };
}
