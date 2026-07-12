{inputs, self, ... }: 
{
  flake.modules.neovim.main = { config, wlib, lib, pkgs, ... }: { 
      config = {
            settings.config_directory = ./neovim;

            extraPackages = with pkgs; [
                  ripgrep
            ]
            ++ lib.optionals pkgs.stdenv.isLinux [ 
                  wl-clipboard
            ];

            specs.init = {
                  data = null;
                  before = ["MAIN_INIT"];
                  config = "require('init')";
            };

            specs.plugins = {
                  data = with pkgs; [
                        vimPlugins.lz-n
                        vimPlugins.plenary-nvim
                        vimPlugins.nvim-lspconfig
                        vimPlugins.nvim-treesitter.withAllGrammars

                        # completion
                        vimPlugins.nvim-web-devicons
                        vimPlugins.lspkind-nvim
                        vimPlugins.colorful-menu-nvim
                        vimPlugins.blink-cmp
                        
                        # misc
                        vimPlugins.oil-nvim
                        vimPlugins.luasnip
                        vimPlugins.vim-fugitive
                        vimPlugins.gruvbox 
                        vimPlugins.telescope-nvim
                  ];
            };

            specs.lazyPlugins = {
                  lazy = true;
                  data = with pkgs; [
                        vimPlugins.lazydev-nvim
                        vimPlugins.gitsigns-nvim
                        vimPlugins.nvim-autopairs
                        vimPlugins.mini-files
                        vimPlugins.codecompanion-nvim
                  ];
            };
      };
  };

      perSystem = { pkgs, self', ... }:
      {
            packages.neovimFull = inputs.wrapper-modules.wrappers.neovim.wrap {
                  inherit pkgs;
                  imports = [
                        self.modules.neovim.main
                        self.modules.neovim.allServers
                  ];
            };

            packages.neovimSudo = inputs.wrapper-modules.wrappers.neovim.wrap {
                  inherit pkgs;
                  imports = [
                        self.modules.neovim.main
                        self.modules.neovim.sudoServers
                  ];
            };           
      };
}
