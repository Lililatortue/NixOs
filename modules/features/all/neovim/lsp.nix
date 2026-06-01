{ self, ...}:
{
      flake.modules.neovim.lua = {pkgs, ...}: 
      {
            extraPackages = [
                  pkgs.lua-language-server
            ];
            specs.lua-language-server = {
                  data = [
                        pkgs.vimPlugins.nvim-lspconfig
                        pkgs.vimPlugins.blink-cmp
                  ];
                  config = ''vim.lsp.enable("lua_ls")'';
            };
     };


      flake.modules.neovim.ts = {pkgs, ...}: 
      {
            extraPackages = [
                  pkgs.typescript-language-server
            ];
            specs.ts = {
                  data = [
                        pkgs.vimPlugins.nvim-lspconfig
                  ];
                  config = ''vim.lsp.enable("ts_ls")'';
            };
      };
      
      flake.modules.neovim.go = {pkgs, ...}:
      {
            extraPackages = [
                  pkgs.gopls
            ]; 
            specs.go = {
                  data = [
                        pkgs.vimPlugins.nvim-lspconfig
                  ];
                  config = ''vim.lsp.enable("gopls")'';
            };
      };

      flake.modules.neovim.rust = {pkgs, ...}:
      {
            extraPackages = [
                  pkgs.rust-analyzer
            ]; 
            specs.rust = {
                  data = [
                        pkgs.vimPlugins.nvim-lspconfig
                  ];
                  config = ''vim.lsp.enable("rust_analyzer")'';
            };
      };

      flake.modules.neovim.python = {pkgs, ...}:
      {
            extraPackages = [
                  pkgs.python3
                  pkgs.pyright
            ]; 
            specs.python = {
                  data = [
                        pkgs.vimPlugins.nvim-lspconfig
                  ];
                  config = ''vim.lsp.enable("pyright")'';
            };
      };

      flake.modules.neovim.arduino = {pkgs, ...}:
      {
            extraPackages = [
                  pkgs.arduino-language-server # The LSP wrapper
                  pkgs.arduino-cli             # Needed to parse sketch metadata
                  pkgs.llvmPackages.clang-unwrapped # Needed by the language server to index C++
                  pkgs.gcc                     # Toolchain compiler
            ]; 
            specs.arduino = {
                  data = [
                        pkgs.vimPlugins.nvim-lspconfig
                  ];
                  config = ''
                        vim.lsp.config("arduino_language_server", {
                              cmd = {
                                    "arduino-language-server",
                                    "-cli-config", vim.fn.expand("$HOME/.local/share/arduino15/arduino-cli.yaml"),
                                    "-cli", "arduino-cli",
                                    "-clangd", "clangd"
                              }
                        })
                        vim.lsp.enable("arduino_language_server")
                        
                  '';
            };
      };
      # server stack
      flake.modules.neovim.nix = {pkgs, ...}:
      {
            extraPackages = [
                  pkgs.nixd
                  pkgs.alejandra
            ]; 
            specs.nixd = {
                  data = [
                        pkgs.vimPlugins.nvim-lspconfig
                  ];
                  config = ''
                  vim.lsp.config("nixd", {
                        cmd = { "nixd" },
                        settings = {
                              nixd = {
                                    nixpkgs = {
                                          expr = "import <nixpkgs> { }",
                                    },
                                    formatting = {
                                          command = { "alejandra" },
                                    },
                                    options = {
                                          expr = '(attributes of (import <nixpkgs/nixos>{})).options'
                                    }
                              },
                        },
                  })
                  vim.lsp.enable("nixd")
                  '';
            };
      };

      flake.modules.neovim.bash = {pkgs, ...}:
      {
            extraPackages = [
                  pkgs.bash
            ];
            specs.bash = {
                  data = [
                        pkgs.vimPlugins.nvim-lspconfig
                  ];
                  config = ''vim.lsp.enable("bashls")'';
            };
      };

      flake.modules.neovim.allServers = {
            imports = [
                  self.modules.neovim.lua
                  self.modules.neovim.ts
                  self.modules.neovim.go
                  self.modules.neovim.rust
                  self.modules.neovim.arduino
                  self.modules.neovim.python
                  self.modules.neovim.nix
                  #self.modules.neovim.bash
            ];
      };

     flake.modules.neovim.sudoServers = {
            imports = [
                  self.modules.neovim.lua
                  self.modules.neovim.nix
                  #self.modules.neovim.bash
            ];
      };
}

