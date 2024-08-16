local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
    {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        keys = {
            { '<leader>l', function() require('lsp_lines').toggle() end, desc = 'Toggle lsp_lines' },
        },
        config = function()
            require('lsp_lines').setup()
            vim.diagnostic.config({ virtual_lines = false })
        end,
    },

    { -- colorscheme
        'sainnhe/sonokai'
    },

    { -- Create Color Code
        'uga-rosa/ccc.nvim',
        cmd = 'CccPick',
    },

    { -- fastest Neovim colorizer
        'norcalli/nvim-colorizer.lua',
        config = function() require 'colorizer'.setup {
                'css';
                'javascript';
            }
        end
    },

    {
        'stevearc/dressing.nvim',
        config = function() require('dressing').setup {
                input = {
                    win_options = {
                        winblend = 0, -- disable transparency
                    },
                },
                select = {
                    telescope = require('telescope.themes').get_cursor(),
                }
            }
        end
    },

    { -- smart and powerful comment plugin
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup {} end,
    },

    { -- alignment plugin
        'junegunn/vim-easy-align',
        init = function()
            vim.g.easy_align_delimiters = { ['\\'] = { pattern = '\\\\' } }
        end,
    },

    { -- motions on speed
        'phaazon/hop.nvim',
        branch = 'v1',
        config = function() require('hop').setup {
                keys = 'etovxqpdygfblzhckisuran'
            }
        end
    },

    -- use({
    --     'folke/noice.nvim',
    --     event = 'VimEnter',
    --     config = function() require('noice').setup {
    --             cmdline = {
    --                 enabled = true,
    --                 view = 'cmdline',
    --                 format = {
    --                     cmdline = { pattern = '^:', icon = '', conceal = false },
    --                 },
    --             },
    --             messages = {
    --                 view_search = 'cmdline',
    --             },
    --             views = {
    --                 mini = {
    --                     timeout = 5000,
    --                     border = {
    --                         style = 'rounded',
    --                     },
    --                     position = {
    --                         row = -1,
    --                         col = '100%',
    --                     },
    --                 },
    --             },
    --         }
    --     end,
    --     requires = {
    --         'MunifTanjim/nui.nvim',
    --     }
    -- })

    { -- Extended Vim syntax highlighting for C and C++ (C++11/14/17/20)
        'bfrg/vim-cpp-modern'
    },

    { -- highlight, edit, and navigate code using a fast incremental parsing library
        'nvim-treesitter/nvim-treesitter',
        -- version = nil,
        dependencies = {
            'p00f/nvim-ts-rainbow',
        },
        -- build = ':TSUpdate',
        config = function() require('nvim-treesitter.configs').setup {
                rainbow = {
                    enable = true,
                    colors = { '#5fd7ff', '#ffffaf', '#afffff', '#ffd7ff' }
                },
                ensure_installed = { 'c', 'cpp', 'lua', 'python', 'bash', 'regex', 'vue', 'javascript', 'typescript',
                    'css', 'html', 'json' },
                highlight = {
                    enable = true,
                    disable = { 'c', 'cpp' }, -- bfrg/vim-cpp-modern is better (#if 0 support, auto type support, ...)
                },
                indent = {
                    enable = true,
                }
            }
        end
    },

    { -- a Git wrapper so awesome, it should be illegal
        'tpope/vim-fugitive'
    },

    { -- git signs in signcolumn
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup {
                attach_to_untracked = false,
            }
        end
    },

    { -- Find, Filter, Preview, Pick. All lua, all the time
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },
        config = function()
            require('telescope').setup {
                defaults = {
                    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                    mappings = {
                        i = {
                            ['<C-k>'] = 'move_selection_previous',
                            ['<C-j>'] = 'move_selection_next',
                            ['<Esc>'] = 'close',
                        }
                    },
                },
            }
            require('telescope').load_extension('fzf')
        end
    },

    -- use {
    --     'fatih/vim-go',
    --     -- run = function() vim.cmd[[<cmd>GoInstallBinaries<cr>]] end,
    --     ft = {'go'},
    -- }

    { -- markdown preview plugin
        'iamcco/markdown-preview.nvim',
        build = function() vim.fn['mkdp#util#install']() end,
        ft = { 'markdown' },
        init = function()
            vim.g.mkdp_open_to_the_world = 1
            vim.g.mkdp_echo_preview_url = 1
        end,
    },

    { -- highlight trailing whitespaces
        'ntpeters/vim-better-whitespace',
        init = function()
            vim.g.better_whitespace_enabled = 1
            vim.g.show_spaces_that_precede_tabs = 1
            vim.g.strip_whitespace_confirm = 0
            vim.g.strip_whitelines_at_eof = 1
            vim.g.strip_whitespace_on_save = 1
            vim.g.better_whitespace_guicolor = '#d78787'
        end,
    },

    { -- A snazzy bufferline for Neovim
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function() require('bufferline').setup {
                options = {
                    -- offsets = { { filetype = 'neo-tree', padding = 1 } },
                    -- offsets = { { filetype = "NvimTree", text = " ", padding = 1 } },
                    numbers = function(opts) return opts.raise(opts.ordinal) end,
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    -- show_buffer_icons = false,
                    modified_icon = '',
                    indicator = {
                        style = 'none',
                    },
                }
            }
        end
    },

    { -- A blazing fast and easy to configure neovim statusline plugin written in pure lua
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function() require('lualine').setup {
                options = {
                    globalstatus = true,
                    component_separators = { left = ' ', right = ' ' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_c = { { 'filename', path = 1 } } -- relative path
                }
            }
        end
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            local highlight = {
                -- "CursorColumn",
                "Whitespace",
            }
            require("ibl").setup {
                enabled = true,
                indent = { highlight = highlight, char = '▏' },
                whitespace = {
                    highlight = highlight,
                    remove_blankline_trail = false,
                },
                scope = { enabled = false },
                exclude = {
                    filetypes = {
                        'help', 'markdown', 'text',
                        'lspinfo', 'gitcommit', 'man',
                        'TelescopePrompt', 'TelescopeResults', 'packer'
                    },
                },
            }
        end
    },

    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        tag = 'nightly', -- optional, updated every week. (see issue #1193)
        config = function()
            require('nvim-tree').setup({
                sort_by = 'case_sensitive',
                -- sync_root_with_cwd = true,
                view = {
                    width = {
                        min = 25,
                        max = 60,
                    },
                    -- signcolumn = 'no',
                    mappings = {
                        list = {
                            { key = 'u', action = 'dir_up' },
                            { key = 'r', action = 'refresh' },
                            { key = 'R', action = 'rename' },
                            { key = '.', action = '. descr', action_cb = function()
                                local api = require('nvim-tree.api')
                                local node = api.tree.get_node_under_cursor()
                                local cnode = node.type == 'directory' and node.parent or
                                    (node.parent.parent or node.parent)
                                api.tree.change_root_to_node(cnode)
                                api.tree.find_file(node.absolute_path)
                                print('root set to ' .. cnode.absolute_path)
                            end },
                            { key = 'cd', action = 'cd descr', action_cb = function()
                                local lib = require('nvim-tree.lib')
                                local node = lib.get_node_at_cursor()
                                local path = node.type == 'directory' and node.absolute_path or node.parent.absolute_path
                                vim.cmd('cd ' .. path)
                                print('directory changed to ' .. path)
                            end },
                        },
                    },
                },
                renderer = {
                    group_empty = true,
                    indent_width = 1,
                    icons = {
                        show = {
                            folder_arrow = false,
                        },
                    },
                },
                filters = {
                    dotfiles = true,
                },
                git = {
                    enable = false,
                },
                live_filter = {
                    always_show_folders = false, -- Turn into false from true by default
                },
            })
            vim.api.nvim_create_autocmd('BufEnter', {
                nested = true,
                callback = function()
                    if #vim.api.nvim_list_wins() == 1 and require('nvim-tree.utils').is_nvim_tree_buf() then
                        vim.cmd 'quit'
                    end
                end
            })
        end
    },

    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            local null_ls = require('null-ls')
            null_ls.setup {
                -- debug = true,
                on_attach = require('lsp_on_attach').lsp_on_attach,
                sources = {
                    null_ls.builtins.diagnostics.eslint_d,
                    null_ls.builtins.code_actions.eslint_d,
                    null_ls.builtins.formatting.eslint_d,

                    null_ls.builtins.formatting.black.with {
                        only_local = '.venv/bin',
                    },
                    null_ls.builtins.diagnostics.mypy.with {
                        only_local = '.venv/bin',
                    },
                    null_ls.builtins.diagnostics.flake8.with {
                        only_local = '.venv/bin',
                    },
                },
            }
        end
    },

    { -- easily install and manage LSP servers, DAP servers, linters, and formatters
        'williamboman/mason.nvim',
        config = function() require('mason').setup {} end
    },
    {
        'williamboman/mason-lspconfig.nvim'
    },
    {
        'neovim/nvim-lspconfig'
    },

    { -- a tree like view for symbols using LSP
        'simrat39/symbols-outline.nvim',
        config = function() require('symbols-outline').setup {
                highlight_hovered_item = false,
            }
        end
    },

    { -- snippets
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        build = 'make install_jsregexp',
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
        end
    },

    { -- autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            local lsp_icons = {
                Text = '', Method = '', Function = '', Constructor = '', Field = 'ﴲ',
                Variable = '', Class = '', Interface = 'ﰮ', Module = '', Property = '襁',
                Unit = '', Value = '', Enum = '練', Keyword = '', Snippet = '',
                Color = '', File = '', Reference = '', Folder = '', EnumMember = '',
                Constant = 'ﲀ', Struct = 'ﳤ', Event = '', Operator = '', TypeParameter = '',
            }
            local sources = {
                buffer = 'Buffer',
                nvim_lsp = 'LSP',
                luasnip = 'Snippet',
                nvim_lsp_signature_help = 'Sign',
                path = 'Path',
            }
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            local border_opts = {
                border = 'rounded',
                winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
            }

            cmp.setup {
                preselect = cmp.PreselectMode.None,
                window = {
                    completion = cmp.config.window.bordered(border_opts),
                    documentation = cmp.config.window.bordered(border_opts),
                },
                -- completion = {
                --     completeopt = "menu,menuone,noinsert,noselect,preview",
                -- },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- explicitly selected items only
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'path' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                },
                formatting = {
                    format = function(entry, item)
                        item.kind = string.format('%s %s', lsp_icons[item.kind] or '?', item.kind)
                        item.menu = sources[entry.source.name] or entry.source.name
                        return item
                    end
                },
            }
        end
    },

    {
        "chentoast/marks.nvim",
        -- event = "BufReadPre",
        config = function()
            require("marks").setup {
                -- whether to map keybinds or not. default true
                default_mappings = true,
                -- which builtin marks to show. default {}
                builtin_marks = { ".", "<", ">", "^" },
                -- whether movements cycle back to the beginning/end of buffer. default true
                cyclic = true,
                -- whether the shada file is updated after modifying uppercase marks. default false
                force_write_shada = false,
                -- how often (in ms) to redraw signs/recompute mark positions.
                -- higher values will have better performance but may cause visual lag,
                -- while lower values may cause performance penalties. default 150.
                refresh_interval = 250,
                -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
                -- marks, and bookmarks.
                -- can be either a table with all/none of the keys, or a single number, in which case
                -- the priority applies to all marks.
                -- default 10.
                sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
                -- disables mark tracking for specific filetypes. default {}
                excluded_filetypes = {},
                -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
                -- sign/virttext. Bookmarks can be used to group together positions and quickly move
                -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
                -- default virt_text is "".
                bookmark_0 = {
                    sign = "♥",
                    virt_text = "hello world",
                    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
                    -- defaults to false.
                    annotate = false,
                },
                mappings = {}
            }
        end,
    },

}, {
    ui = {
        border = 'rounded',
    },
})
