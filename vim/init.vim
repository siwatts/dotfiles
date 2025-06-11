" Transitioning from Vim                                           *nvim-from-vim*

"1. To start the transition, create your |init.vim| (user config) file:

"    :call mkdir(stdpath('config'), 'p')
"    :exe 'edit '.stdpath('config').'/init.vim'

"2. Add these contents to the file:

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Neovim setup:
" -------------
" 1) Install Plug (https://github.com/junegunn/vim-plug)
"       - Command retrieved 14/03/2025
"       - sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" 2) Re-open nvim
" 3) :PlugInstall
" 4) Remove or rename any old legacy vim themes from `~/.vim/colors` that clash with new nvim Plug sourced themes
" 5) Install required language servers:
"       - C#: csharp_ls - https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#csharp_ls
"           - Retrieved 14/03/2025
"           - Need .NET SDK for dotnet development and csharp-ls
"               - `sudo dnf install dotnet-sdk-9.0`
"               - `dotnet tool install --global csharp-ls`
"               - currently also need .NET 8.0 for csharp_ls as they are a version behind, this should change in future
"                   - Try the above first, if .NET 8 is missing reported by neovim then
"                   - `sudo dnf install dotnet-sdk-8.0`
"       - C/C++: clangd - https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#clangd
"           - Retrieved 14/03/2025
"               - `sudo dnf provides clangd` -> `sudo dnf install clang-devel`

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Better syntax highlighting
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Language server stuff
Plug 'neovim/nvim-lspconfig'

" Colours
Plug 'sainnhe/everforest'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/gruvbox-material'
Plug 'projekt0n/github-nvim-theme'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'navarasu/onedark.nvim'
Plug 'tanvirtin/monokai.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'shaunsingh/nord.nvim'
Plug 'Mofiqul/dracula.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'ramojus/mellifluous.nvim'
Plug 'rose-pine/neovim', { 'as': 'rose-pine' }
" For jellybeans
Plug 'rktjmp/lush.nvim'
Plug 'metalelf0/jellybeans-nvim'

"" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'
"
"" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
"" Multiple Plug commands can be written in a single line using | separators
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
"" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
"" Using a non-default branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
"" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }
"
"" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
"" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
"" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" Tree Sitter
"lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}

" Language servers
lua require'lspconfig'.csharp_ls.setup{}
lua require'lspconfig'.clangd.setup{}
" Set sign column permanent size, otherwise it pops in and out during LSP
" stuff and is very distracting
set signcolumn=yes
"" Enable update in insert mode, to show warnings and errors.
"" Stops them popping in and out, but they are updated live as you type which
"" can be distracting
""lua vim.diagnostic.config({ update_in_insert = true, })
" Better solution to hide warnings entirely until we reveal them with keyboard
" shortcuts:
lua << EOF
vim.diagnostic.config({
    virtual_text = false,       -- Disable virtual text (the inline text warnings/errors)
    signs = true,               -- Keep signs in the sign column
    underline = true,           -- Keep underline for errors
    update_in_insert = false,   -- Don't update diagnostics while in insert mode
})

-- Show the floating window for the diagnostic under the cursor
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic in floating window" })

-- Go to the next diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })

-- Go to the previous diagnostic
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

-- Toggle diagnostics visibility (virtual text, signs, underline)
vim.keymap.set('n', '<Leader>td', function()
    local config = vim.diagnostic.config()
    if config.virtual_text then
        vim.diagnostic.config({ virtual_text = false, underline = false })
    else
        vim.diagnostic.config({ virtual_text = true, underline = true })
    end
end, { desc = "Toggle diagnostics" })

-- Bonus:

-- Jump to the definition
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })

-- Show hover information
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show hover information" })

-- Show signature help
vim.keymap.set('n', '<Leader>k', vim.lsp.buf.signature_help, { desc = "Show signature help" })

-- Jump to the declaration
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })

-- Jump to references
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Go to references" })

-- Rename a symbol
vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })

---- Show the workspace diagnostics
--vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
--vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
--vim.keymap.set('n', '<Leader>wl', function()
--    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--end, { desc = "List workspace folders" })

---- Format the current buffer
--vim.keymap.set('n', '<Leader>f', function()
--    vim.lsp.buf.format { async = true }
--end, { desc = "Format buffer" })

-- Insert mode, hints
vim.keymap.set('i', '<C-k>', vim.lsp.buf.hover, { desc = "Show hover information" })

--vim.g.mapleader = ' '  -- Set <Leader> to space

-- Intellisense
-- NOTE: <C-x><C-o> by default, this should work also, but add some extras here
-- Map Ctrl-Space in insert mode to trigger omnifunc (intellisense)
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { noremap = true })

-- -- Intellisense example nvim-cmp config snippet in Lua, ChatGPT. Requires cmp
-- local cmp = require'cmp'
-- 
-- cmp.setup({
--   mapping = {
--     ['<C-Space>'] = cmp.mapping.complete(),  -- Trigger completion manually
--     ['<CR>'] = cmp.mapping.confirm({ select = true }),
--     ['<Tab>'] = cmp.mapping.select_next_item(),
--     ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--   },
-- })

EOF

" -- Neovim colorscheme fixes as of v0.10.2 --
" A neovim update breaks some old vim themes due to neovim specific highlight groups being left
" undefined. This may be fixed (or worsened) by a future neovim update?
autocmd ColorScheme jellybeans,wombat256mod,twilight,solarized8,solarized8_high,lucius,hybrid,vilight,twilight256 hi @variable guifg=NONE
autocmd ColorScheme molokai,one,zenburn,cobalt2,iceberg,selenized,selenized_bw hi @variable guifg=NONE
autocmd ColorScheme Tomorrow-Night,Tomorrow-Night-Eighties,Tomorrow-Night-Blue hi @variable guifg=NONE
autocmd ColorScheme simple-green,simple-orange hi @variable guifg=NONE
" Other broken syntax
autocmd ColorScheme vilight hi! link Function Identifier
autocmd ColorScheme lucius hi! link String Constant | hi! link Function Identifier
autocmd ColorScheme vilight,twilight256,wombat256mod hi! link Operator Statement
" Remove italics
autocmd ColorScheme jellybeans-nvim hi Type gui=NONE
autocmd ColorScheme twilight,vilight hi Comment gui=NONE
autocmd ColorScheme sonokai,monokai hi Comment gui=NONE
autocmd ColorScheme wombat256mod hi String gui=NONE
autocmd ColorScheme gruvbox hi Comment gui=NONE | hi String gui=NONE
autocmd ColorScheme gruvbox-material hi Comment gui=NONE

" Add italics back (Wombat256mod when used in neovim has Identifier and
" Function look the same, could also bold Functions instead)
"autocmd ColorScheme wombat256mod hi Identifier gui=italic

" Optional complete italic removal
autocmd ColorScheme twilight hi Type gui=NONE
autocmd ColorScheme molokai,molokayo hi Storageclass gui=NONE | hi Special gui=NONE | hi Tag gui=NONE
autocmd ColorScheme monokai hi @keyword gui=NONE | hi @function gui=NONE
autocmd ColorScheme kanagawa hi Comment gui=NONE
autocmd ColorScheme zenburn hi Comment gui=NONE
autocmd ColorScheme solarized8,selenized,selenized_bw hi Comment gui=NONE
autocmd ColorScheme cobalt2 hi Comment gui=NONE
autocmd ColorScheme onedark,everforest hi Comment gui=NONE
autocmd ColorScheme tokyonight-moon,tokyonight-storm,tokyonight-night hi Comment gui=NONE

" Override colourscheme for neovim now all the plugins have loaded
" Pure vim themes don't support neovim any more since they introduced breaking
" changes, so setting them in .vimrc doesn't work even if we fix them later
"colorscheme dracula
"colorscheme catppuccin-macchiato
"colorscheme sonokai
colorscheme jellybeans-nvim

" Light theme override
"colorscheme vim
"colorscheme gruvbox

