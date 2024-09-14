call plug#begin('~/.config/nvim/autoload/plugged')

" Better Syntax Support
Plug 'sheerun/vim-polyglot'
" File Explorer
Plug 'scrooloose/NERDTree'
Plug 'ryanoasis/vim-devicons'
"Plug 'tsony-tsonev/nerdtree-git-plugin'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Fuzzy Finder
Plug 'ctrlpvim/ctrlp.vim'
" Auto pairs for ([{
Plug 'jiangmiao/auto-pairs'
" GitHub Copilot 🤖
Plug 'github/copilot.vim'
" Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
