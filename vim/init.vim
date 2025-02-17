" Transitioning from Vim                                           *nvim-from-vim*

"1. To start the transition, create your |init.vim| (user config) file:

"    :call mkdir(stdpath('config'), 'p')
"    :exe 'edit '.stdpath('config').'/init.vim'

"2. Add these contents to the file:

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
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
lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}

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

EOF

" -- Neovim colorscheme fixes as of v0.10.2 --
" A neovim update breaks some old vim themes due to neovim specific highlight groups being left
" undefined. This may be fixed (or worsened) by a future neovim update?
autocmd ColorScheme jellybeans,wombat256mod,twilight,solarized8,lucius,hybrid,vilight,twilight256 hi @variable guifg=NONE
autocmd ColorScheme molokai,one,zenburn,cobalt2,iceberg hi @variable guifg=NONE
autocmd ColorScheme Tomorrow-Night,Tomorrow-Night-Eighties,Tomorrow-Night-Blue hi @variable guifg=NONE

autocmd ColorScheme vilight hi! link Function Identifier
autocmd ColorScheme lucius hi! link String Constant | hi! link Function Identifier

" Override colourscheme for neovim now all the plugins have loaded
" Pure vim themes don't support neovim any more since they introduced breaking
" changes
"colorscheme dracula
"colorscheme catppuccin-macchiato
"colorscheme sonokai
colorscheme jellybeans-nvim

