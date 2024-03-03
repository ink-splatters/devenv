{ pkgs, config, lib, ... }:

let
  cfg = config.languages.c;
in
{
  options.languages.c = {
    enable = lib.mkEnableOption "tools for C development";

    lsp.package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.ccls;
      defaultText = lib.literalExpression "pkgs.ccls";
      description = "The LSP package to use";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = with pkgs; [
      stdenv
      gnumake
      ccls
      pkg-config
      cfg.lsp.package
    ];
  };
}
