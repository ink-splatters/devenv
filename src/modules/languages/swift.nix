{ pkgs, config, lib, ... }:

let
  cfg = config.languages.swift;
in
{
  options.languages.swift = {
    enable = lib.mkEnableOption "tools for Swift development";

    package = lib.mkPackageOption pkgs "swift" {
      extraDescription = ''
        The Swift package to use.
      '';
    };

    swiftpm = {
      enable = lib.mkEnableOption "Swift Package Manager support";

      package =  lib.mkPackageOption pkgs.swiftPackages [ "swiftpm" "swiftpm2nix" ] {
        internal = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    packages =  [
      cfg.package
      pkgs.clang
    ] ++ lib.mkIf cfg.swiftpm.enable cfg.swiftpm.package;

    env.CC = "${pkgs.clang}/bin/clang";
  };
}
