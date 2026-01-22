{self, pkgs, ...}: {
  imports = [];

  globals.mapleader = " ";
    keymaps = [
    {
      mode = ["i"];
      key = "jk";
      action = "<esc>";
    }
    {
      mode = ["n" "v"];
      key = "<leader>fe";
      action = ":Telescope file_browser path=%:p:h select_buffer=true<cr>";
    }
    {
      mode = ["n" "v"];
      key = "<leader>ff";
      action = ":Telescope find_files<cr>";
    }
    {
      mode = ["n" "v"];
      key = "<leader>fg";
      action = ":Telescope live_grep<cr>";
    }
    {
      mode = ["n" "v"];
      key = "<leader>fb";
      action = ":Telescope buffers<cr>";
    }
    {
      mode = [
	"i"
	  "s"
      ];
      key = "<C-k>";
      action.__raw = ''
	function()
	local ls = require "luasnip" 
	if ls.expand_or_jumpable() then
	  ls.expand_or_jump()
	    end
	    end
	    '';
    }
    {
      mode = [
	"i"
	  "s"
      ];
      key = "<C-j>";
      action.__raw = ''
	function()
	local ls = require "luasnip" 
	if ls.jumpable(-1) then
	  ls.jump(-1)
	    end
	    end
	    '';
    }
    ];


    colorschemes.catppuccin.enable = true;

    plugins.lualine.enable = true;
    plugins.web-devicons.enable = true;

    plugins.lsp = {
      enable = true;
      servers = {
        elixirls = {
          enable = true;
        };
        nixd = { enable = true; };
        tinymist = {
          enable = true;
          settings = { formatterMode = "typstfmt"; };
        };
      };

      keymaps = {
      silent = true;
      lspBuf = {
        gd = {
          action = "definition";
          desc = "Goto Definition";
        };
        gr = {
          action = "references";
          desc = "Goto References";
        };
        gD = {
          action = "declaration";
          desc = "Goto Declaration";
        };
        gI = {
          action = "implementation";
          desc = "Goto Implementation";
        };
        gT = {
          action = "type_definition";
          desc = "Type Definition";
        };
        "<leader>h" = {
          action = "hover";
          desc = "Hover";
        };
        "<leader>cw" = {
          action = "workspace_symbol";
          desc = "Workspace Symbol";
        };
        "<leader>cr" = {
          action = "rename";
          desc = "Rename";
        };
        "<leader>F" = {
          action = "format";
          desc = "Format";
        };
      };

      diagnostic = {
        "<leader>e" = {
          action = "open_float";
          desc = "Line Diagnostics";
        };
        "gl" = {
          action = "goto_next";
          desc = "Next Diagnostic";
        };
        "gh" = {
          action = "goto_prev";
          desc = "Previous Diagnostic";
        };
      };
      };
    };

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          {
            name = "nvim_lsp";
            priority = 1000;
          }
          {
            name = "nvim_lsp_signature_help";
            priority = 1000;
          }
          {
            name = "treesitter";
            priority = 850;
          }
          {
            name = "luasnip";
            priority = 750;
          }
          {
            name = "buffer";
            priority = 500;
          }
          { name = "path"; priority = 300;}
          { name = "git"; priority = 250;}
          { name = "calc"; priority = 250;}
          { name = "emoji"; priority = 100;}       
        ];

        mapping = {
          "<Tab>" = "cmp.mapping.confirm({ select = true })";
          "<Down>" = "cmp.mapping.select_next_item()";
          "<Up>" = "cmp.mapping.select_prev_item()";
          "<C-e>" = "cmp.mapping.abort()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
        };
      };
    };

    plugins.telescope = {
      enable = true;
      extensions.fzy-native.enable = true;
      extensions.file-browser.enable = true;
			settings = {
        defaults = {
          vimgrep_arguments = [
            "rg"
            "--color=never"
            "--no-heading"
            "--with-filename"
            "--line-number"
            "--column"
            "--smart-case"
            "--hidden"
            "--glob"
            "!.git/"
            "--glob"
            "!node_modules/"
            "--glob"
            "!vendor/"
          ];
        };
			};
    };

    plugins.oil.enable = true;

    plugins.treesitter = {
      enable = true;
      folding.enable = true;
      autoLoad = true;
      highlight.enable = true;
      indent.enable = true;
      grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
    };

    # Auto-enable treesitter highlighting and folding for supported filetypes                   
    autoCmd = [                                                                                 
      {                                                                                         
        event = ["FileType"];                                                                   
        pattern = ["*"];                                                                        
        callback.__raw = ''                                                                     
          function()                                                                            
            local ft = vim.bo.filetype                                                          
            if ft and ft ~= "" then                                                             
              local ok = pcall(vim.treesitter.start)                                            
              if ok then                                                                        
                vim.opt_local.foldmethod = "expr"                                               
                vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"                      
              end                                                                               
            end                                                                                 
          end                                                                                   
        '';                                                                                     
      }                                                                                         
    ];                                                                                          

    plugins.treesitter-textobjects.enable = true;

    # Orgmode configuration
    plugins.orgmode = {
      enable = true;
      settings = {
        org_agenda_files = ["~/org/**/*"];
        org_default_notes_file = "~/org/notes.org";
      };
    };

    plugins.typst-vim.enable = true;
    plugins.which-key.enable = true;
    plugins.nvim-autopairs.enable = true;
    plugins.fidget.enable = true;
    plugins.fugitive.enable = true;
    plugins.auto-save.enable = true;
    plugins.barbecue.enable=true;
    plugins.git-conflict.enable=true;
    plugins.gitsigns.enable=true;
    plugins.headlines.enable=true;
    plugins.hex.enable=true;
    plugins.leap.enable=true;
    plugins.luasnip.enable = true;
    plugins.lightline.enable = true;
    plugins.nix.enable = true;
    plugins.nui.enable = true;
    plugins.noice.enable = true;
    plugins.notify.enable = true;
    plugins.vim-surround.enable = true;

    opts = {
# numbering
      number = true;
      relativenumber = true;

# clipboard
      clipboard = [ "unnamedplus" ];

# indentation
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;

# swap, backup, undo
      swapfile = false;
      backup = false;
      undofile = false;

# search
      incsearch = true;
      hlsearch = true;
      ignorecase = true;
      smartcase = true;

# code folding
      foldcolumn = "0";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;
      foldtext = "";

# misc
      wrap = false;
      scrolloff = 8;
      cursorline = true;
      completeopt = "menu,menuone,noselect";
    };
}
