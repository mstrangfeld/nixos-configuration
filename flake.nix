{
  description = "My personal host configurations";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable; # Nix Packages collection
    unstable.url = github:nixos/nixpkgs;
    nur.url = github:nix-community/NUR; # Nix User Repository: User contributed nix packages
    utils.url = github:gytis-ivaskevicius/flake-utils-plus; # Use Nix flakes without any fluff
    home-manager = {
      # Manage a user environment using Nix
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = github:NixOS/nixos-hardware; # A collection of NixOS modules covering hardware quirks.
    emacs-overlay.url = "github:nix-community/emacs-overlay"; # Bleeding edge emacs overlay
    agenix = {
      # age-encrypted secrets for NixOS
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs.url = "github:serokell/deploy-rs"; # A simple multi-profile Nix-flake deploy tool.
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    devshell.url = github:numtide/devshell?ref=fff3dc6e4538f6df85ee3027f13cc7730b23f61d; # Per project developer environments
  };

  outputs = inputs@{ self, nur, utils, home-manager, nixos-hardware, emacs-overlay, agenix, deploy-rs, ... }:
    let
      suites = import ./suites.nix { inherit utils; };
    in
    utils.lib.mkFlake {
      inherit self inputs;
      inherit (suites) nixosModules homeManagerModules;

      supportedSystems = [ "x86_64-linux" ];
      channelsConfig.allowUnfree = true;

      channels.nixpkgs.overlaysBuilder = channels: [
        # Use packages from the unstable channel
        (final: prev: {
          inherit (channels.unstable) cachix discord starship;
        })
      ];

      sharedOverlays = [
        self.overlay
        nur.overlay
        emacs-overlay.overlay
        deploy-rs.overlay
        inputs.devshell.overlay
      ];

      overlay = import ./overlays;

      hostDefaults = {
        modules = [
          home-manager.nixosModules.home-manager
          agenix.nixosModules.age
          {
            home-manager = {
              extraSpecialArgs = {
                inherit inputs self;
              };
              useUserPackages = true;
              useGlobalPkgs = true;
            };
          }
        ];
      };

      hosts.Kronos = {
        modules = with suites.nixosModules; suites.desktopModules ++ [
          ./hosts/Kronos
          creative
          development
          entertainment
          virtualisation
          users
          yubikey
          v4l2loopback
          { home-manager.users.marvin.imports = suites.hmKronos; }
        ];
      };

      homeConfigurations =
        let
          configuration = { };
          extraSpecialArgs = { inherit inputs self; };
          generateHome = inputs.hm.lib.homeManagerConfiguration;
          homeDirectory = "/home/${username}";
          pkgs = self.pkgs.${system}.nixpkgs;
          system = "x86_64-linux";
          username = "marvin";
        in
        {
          "marvin@Kronos" = home-manager.lib.homeManagerConfiguration {
            inherit system username homeDirectory extraSpecialArgs pkgs configuration;
            extraModules = with suites.homeManagerModules; [ alacritty browser development music shell users x ];
          };
        };

      deploy.nodes = {
        Kronos = {
          hostname = "localhost";
          fastConnection = true;
          profiles = {
            system = {
              path =
                deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.Kronos;
              user = "root";
            };
            marvin = {
              path =
                deploy-rs.lib.x86_64-linux.activate.home-manager self.homeConfigurations."marvin@Kronos";
              user = "marvin";
            };
          };
        };
      };

      outputsBuilder = channels: {
        devShell = import ./devshell.nix { pkgs = channels.nixpkgs; };
      };
    };
}
