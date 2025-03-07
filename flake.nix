{
  description = "Personal nixvim configuration with this first-time-use of nix flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixvim, ... } @ inputs:
  let
    nixvim' = nixvim.legacyPackages.x86_64-linux;
    pkgs = nixpkgs.legacyPackages.x86_64-linux;


    config = {pkgs, ...}: {
      colorschemes.catppuccin.enable = true;
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

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

      # misc
      wrap = false;
      scrolloff = 8;
      cursorline = true;
      completeopt = "menu,menuone,noselect";
    };

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

  plugins = {
    telescope = {
      enable = true;
      extensions.fzy-native.enable = true;
      extensions.file-browser.enable = true;
    };

	treesitter = {
		enable = true;
    settings = {
      highlight.enable = true;
    };
	};

	typst-vim = { enable = true; };
	which-key = { enable = true; 
          icons = {
      breadcrumb 	= "»";
      separator 	= "➜";
      group 		= "+";
          };
          layout = {
      height 		= { min = 4; max = 150; };
      width 		= { min = 20; max = 950; };
      spacing 		= 3;
      align 		= "left";
	     };
  };
	airline = { enable = true; };
	nvim-autopairs = { enable = true; };
	fidget = { enable = true; };
	fugitive = { enable = true; };
  cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      performance = {
        async_budget = 5;
        fetchingTimeout = 200;
        maxViewEntries = 30;
        debounce = 30;
      };
      experimental.ghost_text = true;
        window = {
        completion = {
          border = "solid";
        };
        documentation = {
            border = "solid";
        };
      };
      mapping = {
        "<Down>" = "cmp.mapping.select_next_item()";
        "<Up>" = "cmp.mapping.select_prev_item()";
        "<C-e>" = "cmp.mapping.abort()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<Tab>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
      };
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
      snippet.expand = 
          "function(args) require('luasnip').lsp_expand(args.body) end";
    };
  };
	cmp-vim-lsp = { enable = true; };
  cmp-path.enable = true;
  cmp-buffer.enable = true;
  cmp-vsnip.enable = true;
  autoclose.enable = true;
  luasnip = {
    enable = true;
  };
	lsp = {
    enable = true;
      servers = {
      html = {
        enable = true;
      };
      lua_ls = {
        enable = true;
      };
      nil_ls = {
        enable = true;
      };
      elixirls = {
        enable = true;
      };
      marksman = {
        enable = true;
      };
      pyright = {
        enable = true;
      };
      gopls = {
        enable = true;
      };
      terraformls = {
        enable = true;
      };
      ansiblels = {
        enable = true;
      };
      jsonls = {
        enable = true;
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
	 };

extraConfigLua 		= ''
	 local status, wk = pcall(require, "which-key")

	 if not (status) then
	     vim.notify("couldn't load whichkey, skipping mappings")
	     return
	 end

	 -- normal mode
	 local which_key_map = {}

	 -- general
	 which_key_map['s'] = { '<Cmd>w<CR>', 'Save file' }
	 which_key_map['S'] = { '<Cmd>wa<CR>', 'Save all' }

	 -- Tree
	 which_key_map['e'] = { vim.cmd.NvimTreeToggle, 'Tree' }

	 -- Undotree
	 which_key_map["u"] = { vim.cmd.UndotreeToggle, 'Undo tree' }

	 -- Git
	 -- which_key_map['g'] = { vim.cmd.Git, 'Git' }

	 -- LSP
	 which_key_map['l'] = { vim.cmd.LspInstall, 'LSP installer' }

	 -- Format buffer
	 which_key_map['f'] = { vim.lsp.buf.format, 'Format buffer' }

	 -- Replace the word I'm on
	 which_key_map['r'] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], 'Replace' }

	 -- Sourse from current file
	 which_key_map[' '] = { function() vim.cmd('so') end, 'Sourse from file' }

	 -- Barbar
	 which_key_map.b = {
	     name = '+Buffer',
	     b = { '<Cmd>BufferNext<CR>', 'Next buffer' },
	     m = {
		 name = '+Move buffer',
		 a = { '<Cmd>BufferMovePrevious<CR>', 'Move back' },
		 e = { '<Cmd>BufferMoveNext<CR>', 'Move forvard' },
	     },
	     f = { '<Cmd>BufferGoto 1<CR>', 'Go to first' },
	     l = { '<Cmd>BufferLast<CR>', 'Go to last' },
	     q = { '<Cmd>BufferClose<CR>', 'Close current' },
	     o = { '<Cmd>BufferCloseAllButCurrent<CR>', 'Close all but current' },
	     u = { '<Cmd>BufferCloseBuffersLeft<CR>', 'Close left' },
	     d = { '<Cmd>BufferCloseBuffersRight<CR>', 'Close right' },
	     s = {
		 name = '+Sort',
		 n = { '<Cmd>BufferOrderByBufferNumber<CR>', 'By buffer number' },
		 l = { '<Cmd>BufferOrderByLanguage<CR>', 'By language' },
		 d = { '<Cmd>BufferOrderByDirectory<CR>', 'By directory' },
		 w = { '<Cmd>BufferOrderByWindowNumber<CR>', 'By window number' },
	     }
	 }

	 -- Telescope
	 local builtin = require('telescope.builtin')
	 which_key_map.t = {
	     name = 'Telescope',
	     ff = { builtin.find_files, 'Search file' },
	     -- Treesitter playground
	     p = { vim.cmd.TSPlaygroundToggle, 'Treesitter playground' },
	     s = { function()
		 builtin.grep_string({ search = vim.fn.input("Grep > ") })
	     end, 'Grep' },
	     g = { builtin.git_files, 'Git files' },
	 }

	 which_key_map['x'] = { '<Cmd>q<CR>', 'Quit file' }
	 which_key_map['X'] = { '<Cmd>qa<CR>', 'Quit all' }
	 which_key_map['q'] = { '<Cmd>wa<CR><Cmd>qa<CR>', 'Save quit all' }
	 which_key_map['Q'] = {
	     string.format('<Cmd>wa<CR><Cmd>mksession! %s/Session.vim<CR><Cmd>qa<CR>', vim.fn.getcwd()),
	     'Save session quit all',
	 }

	 wk.register(which_key_map, { prefix = '<leader>' })
    '';


    };

    nvim = nixvim'.makeNixvimWithModule {
        inherit pkgs;
        module = config;
        extraSpecialArgs = { };
    };
  in
  {
    devShells.x86_64-linux.default = pkgs.mkShell {
        packages = [
          pkgs.fzy
        ];

        buildInputs = [ 
          nvim
        ];
    };
  };

}
