{ pkgs, lib, config, ... }:

with lib;

let

  name = "scrap";
  pluginUrl = "https://github.com/Mateiadrielrafael/scrap.nvim";

  helpers = import ../helpers.nix { inherit lib config; };
  cfg = config.programs.nixneovim.plugins.${name};

  moduleOptions = with helpers; {
    patterns = mkOption {
      type = types.str;
      default = " ";
    };
    autoStart = boolOption true "Enable this pugin at start";
  };

  # pluginOptions = {
  #   # manually add plugin mapping of module options here
  #   #
  #   # auto_start = cfg.autoStart
  # };

  # you can autogenerate the plugin options from the moduleOptions.
  # This essentially converts the camalCase moduleOptions to snake_case plugin options
  pluginOptions = helpers.toLuaOptions cfg moduleOptions;

in
with helpers;
mkLuaPlugin {
  inherit name moduleOptions pluginUrl;
  extraPlugins = with pkgs.vimExtraPlugins; [
    # add neovim plugin here
    scrap-nvim
  ];
  extraPackages = with pkgs; [
    # add dependencies here
    plenary-nvim
  ];
  extraConfigLua = "require('${name}').setup ${toLuaObject pluginOptions}";
  defaultRequire = true;
}
