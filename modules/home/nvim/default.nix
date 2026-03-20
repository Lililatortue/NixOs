{pkgs, inputs, ...}:
{
      	programs.nixvim = {
        	enable = true;
		colorschemes.everforest.enable = true;
            opts = {
                  number            = true;
                  relativenumber    = true;
                  scrolloff         = 8;

                  shiftwidth        = 6;
                  tabstop           = 6;
                  expandtab         = true;
                  ignorecase        = true;
                  smartcase         = true;
                  termguicolors     =true;
            };

            globals.mapleader = " ";      
            extraConfigLua = ''
                  _G.filetree =  ${builtins.readFile ./filetree-setting.lua} 
            '';

            keymaps = [
                  {
                        mode  = "i";
                        key   = "jk";
                        action= "<ESC>";
                  }
	 	      # toggle filetree 
                  {
                        mode    = "n";
                        key     = "<leader>f";
                        action.__raw  = "function() _G.filetree.smart_jump() end";
                        options = {
                              desc  = "toggle focus on file tree.";
                              silent= true;
                        };
                  }
                  # close file tree
                  { 
                        mode    = "n";
                        key     = "<leader>c";
                        action  = "function() vim.cmd('NvimTreeClose') end";                             
                        options = {
                              desc = "close file tree";
                              silent = true;
                        };
                  }

            ];
           
            plugins = {
                  #                      #
                  #     file tree        #
                  #                      # 
                  nvim-tree = {
                        enable = true;
                        highlight_opened_files = "none";
                        root_folder_label = false;
                        icons = {
                              show = {
                                    file        = true;
                                    folder      = true;
                                    folder_arrow= true;
                                    git         = true;
                              };
                        };
                        git = {
                               enable      = true;
                               ignore      = false;
                               show_on_dirs= true;
                        };
            	}; 
                  #                       #
                  #     telescope         #
                  #                       #
                  #to be added later
                  










                  #                      #
                  #     neovim core      #
                  #                      #
                  lsp = {
                        enable = true;
                        servers= {                              
                              nil_ls.enable = true;
                              lua_ls.enable = true;

                              rust_analyzer = {
                                    enable = true;
                                    installCargo   = true;
                                    installRustc   = true;
                                    installRustfmt = true;
                                    installClippy  = true;
                                    
                                    autostart      = true;
                              };
                        }; 
                  };

                  cmp = {
			enable = false;
                        autoEnableSources = true;
			settings = {
                        mapping = {
                              # force the options to open
                              "<Space-c>" = "cmp.mapping.complete()";
                              # choose a select
                              "<CR>"      = "cmp.mapping.confirm({select = true})";
                              # go to next
                              "<Tab>"     = "cmp.mapping.select_next_item()";
                              # go to previous
                              "<S-Tab>"   = "cmp.mapping.select_previous_item()";
                        };
                        
                        sources = [
                              { name = "nvim_lsp"; }
                              { name = "path";     }
                              { name = "buffer";   }
                        ];
			};
                  };
                  tree-sitter = {
                        enable    = true;
                        highlight.enable = true;
                        indent.enable    = true;
                        folding.enable   = true;     
                        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
                              bash
                              json
                              lua
                              rust
                              markdown
                              nix
                              regex
                              toml
                              yaml
                              vim
                              vimdoc
                        ];
                  };
            };
      };
      #xdg.configFile."nvim/lua".source = ./lua;
}
