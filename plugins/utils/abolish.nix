#{ lib, pkgs, config, ... }@attrs:
#let
#  helpers = import ../helpers.nix { inherit lib config; };
#in
#with helpers; with lib;
#mkPlugin attrs {
#  name = "abolish";
#  description = "Enable abolish.vim";
#  extraPlugins = [ pkgs.vimExtraPlugins.vim-abolish ];
#
#  options = { };
#}

{ pkgs, lib, config, ... }:

with lib;

let

  name = "abolish";
  pluginUrl = "https://github.com/tpope/vim-abolish";

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
    abolish-vim
  ];
  extraPackages = with pkgs; [
    # add dependencies here
    # tree-sitter
  ];
}
