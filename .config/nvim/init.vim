source $HOME/.config/nvim/vim-plug/plugins.vim

" vim-airline settings
let g:airline_theme = 'molokai'

" Basic settings
syntax on
set encoding=utf-8 " NeoVim default encoding
set shiftwidth=2 " Number of spaces to use for auto-indent
set tabstop=2 " Number of spaces that a <Tab> in the file counts for
set expandtab " Use spaces instead of tabs
set smartindent " Automatically inserts indentation in some cases
set number " Show line numbers
set termguicolors " Enable 24-bit RGB color in the terminal

" GitHub Copilot settings
lua << EOF
require("CopilotChat").setup {
  debug = false,
  -- See https://github.com/CopilotC-Nvim/CopilotChat.nvim for rest
}
EOF
nmap <C-i> :CopilotChatToggle<CR>

" NERDTree settings
nmap <C-f> :NERDTreeToggle<CR>

autocmd VimEnter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Shortcutting split navigation
" Move between splits with Ctrl + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
