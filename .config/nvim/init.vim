source $HOME/.config/nvim/vim-plug/plugins.vim

" vim-airline settings
let g:airline_theme = 'molokai'

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
