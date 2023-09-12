{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.plugins.neoscroll;
  helpers = import ../helpers.nix {inherit lib;};
in {
  options.plugins.neoscroll =
    helpers.extraOptionsOptions
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
