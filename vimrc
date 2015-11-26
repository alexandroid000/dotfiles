" General

"" not vi-compatible mode
set nocompatible

"" persistant undos
set undodir=$HOME/dotfiles/vim/undo
set undofile
set undolevels=1000
set undoreload=10000

"" viminfo location
set viminfo+=n$HOME/dotfiles/vim/viminfo

"" zsh
set shell=/bin/zsh


" Plugins

" vundle
""filetype must be turned off before vundle commands
filetype off
""" where vundle will be stored, call a command
set rtp+=$HOME/dotfiles/vim/bundle/Vundle.vim/
call vundle#begin()
""" vundle modules to load
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-markdown'
Plugin 'yuratomo/w3m.vim'
"Plugin 'tpope/vim-fugitive'
"Plugin 'ervandew/supertab'
"Plugin 'godlygeek/tabular'
call vundle#end()
""" helpful vundle hints (to be run inside vim)
":PluginList - list plugins
":PluginInstall - install plugins
":PluginInstall! - update plugins
":PluginSearch foo - search for plugin foo
":PluginClean - remove unused plugins

"" turn filetype recognition back on
filetype plugin indent on


" Editing environment

"" tab behavior (all smart/auto, tab = 4 spaces)
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=0
set tabstop=4
set expandtab
":retab applys these rules to the current buffer

"" show trailing spaces as '_', tabs as '>   '
set list listchars=tab:\ \ ,trail:_,extends:»,precedes:«
map <leader>lc :set list!<cr>

"" syntax highlighting
syntax on

"" markdown fenced syntax highlighting
let g:markdown_fenced_languages = ['c', 'sh', 'bash=sh', 'python', 'ruby',
    \ 'haskell', 'javascript', 'tex', 'ada', 'java', 'jack=java', 'vim',
    \ 'asm', 'ld', 'maude']

"" numbers in margin
set number

"" keep 12 lines above and below the current line when scrolling
set scrolloff=12

"" dark solarized colorscheme (Vundle installs it)
set t_Co=8
set background=dark
colorscheme solarized

"" Only have 8 colors, so ctermbg=8 has no effect
"" Need to somehow free up a color to make this work
"" highlight over 80 characters, break on space over 80 chars
"highlight overlength ctermbg=8
"match overlength /\%81v.\+/
set textwidth=80

"" highlight the current line lightly
highlight cursorline cterm=NONE ctermbg=8
noremap <leader>cl :set cursorline!<cr>
set cursorline

"" highlight cursor column lightly (starts turned off)
highlight cursorcolumn cterm=NONE ctermbg=8
noremap <leader>cc :set cursorcolumn!<cr>

"" highlight folds lightly, fold on syntax, only nest 2 folds deep
highlight folded ctermbg=8
set foldmethod=manual
set foldnestmax=2


" Command behavior

"" display completions as a list (instead of tabbing through them)
set wildmode=list:longest
set wildmenu

"" incrementally search, and highlight searched terms
set incsearch
set hlsearch

"Set to autoread outside changes to files
set autoread


" Keybindings

"" move between windows with less keystrokes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"" '>' and '<' in normal mode to change tabs
nnoremap > gt
nnoremap < gT

"" toggle paste on and off
map <leader>pp :setlocal paste!<cr>

"" toggle spellcheck on and off
map <leader>ss :setlocal spell!<cr>

"" reformat to end of para
map <leader>g gq}kA

"" make various markdown boilerplate
map <leader>h1 VypVr=
map <leader>h2 VypVr-
map <leader>h3 I### 
map <leader>cb I```VypkA

"" run ctags
let @t=':wa:!ctags -R --exclude=.git'

"" print file
let @p=':wa:!ssh_print m_mh247 % -o page-left=56 -o page-right=56
            \ -o page-bottom=56 -o page-top=56 -o cpi=12 -o lpi=8'


" Filetype specific commands

"" makefiles need tabs, not spaces, disable expanding the tabs
autocmd filetype make setlocal noexpandtab

"" latex files, @w compiles, @o opens in pdf reader, @p prints the pdf
autocmd BufRead,BufNewFile *.md,*.tex
    \ let @w=':wa:!build_pdf %:r %:e'
    \ | let @o=':!/home/ehildenb/src/JFBView/jfbview %:r.pdf'
    \ | let @e=':w:!md_exec % %:r'
    \ | syn match markdownIgnore "_"
    \ | syn match markdownIgnore "\*"

"" c/c++ files, @w calls make all, @o calls make run
autocmd BufRead,BufNewFile *.c,*.cpp,*.h,*.hpp let @w=':wa:!make all 2>&1 | less'

"" maude files
autocmd BufRead,BufNewFile *.maude set filetype=maude

" Call md_website browser
command -nargs=* MDW read !md_website <args> 2> /dev/null
