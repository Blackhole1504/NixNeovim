{ pkgs, lib, config, ... }:

with lib;

let

  name = "scrap";
  pluginUrl = "https://github.com/Mateiadrielrafael/scrap.nvim";

  helpers = import ../helpers.nix { inherit lib config; };

  moduleOptions = with helpers; {
    # add module options here
  };

in
with helpers;
mkLuaPlugin {
  inherit name moduleOptions pluginUrl;
  extraPlugins = with pkgs.vimExtraPlugins; [
    # add neovim plugin here
    scrap
  ];
  extraPackages = with pkgs; [
    # add dependencies here
    # tree-sitter
  ];
}
