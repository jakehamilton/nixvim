{
  pkgs,
  config,
  lib,
  helpers,
  ...
}:
with lib; let
  cfg = config.plugins.neoscroll;
in {
  options.plugins.neoscroll =
    helpers.neovim-plugin.extraOptionsOptions
    // {
      enable = mkEnableOption "neoscroll";

      package = helpers.mkPackageOption "neoscroll" pkgs.vimPlugins.neoscroll-nvim;
    };

  config = mkIf cfg.enable {
    extraPlugins = [cfg.package];
    extraConfigLua = ''
      require('neoscroll').setup(${helpers.toLuaObject cfg.extraOptions})
    '';
  };
}
