" Leader
let mapleader = "\\"

set softtabstop=2
set backspace=2
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Set highlight at column 100, dark gray
set cc=100
highlight ColorColumn ctermbg=7

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.prawn set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Retab mapping
map <F2> :retab <CR> :wq! <CR>

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --ignore .git --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Numbers
set number
set numberwidth=5

inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

augroup autowindowopen
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
augroup END

" Get off my lawn
"nnoremap <Left> :echoe "Use h"<CR>
"nnoremap <Right> :echoe "Use l"<CR>
"nnoremap <Up> :echoe "Use k"<CR>
"nnoremap <Down> :echoe "Use j"<CR>

" vim-test mappings
" nnoremap <silent> <Leader>t :TestFile<CR>
" nnoremap <silent> <Leader>s :TestNearest<CR>
" nnoremap <silent> <Leader>l :TestLast<CR>
" nnoremap <silent> <Leader>a :TestSuite<CR>
" nnoremap <silent> <leader>gt :TestVisit<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" Color Podfile like ruby
au BufNewFile,BufRead,BufReadPost Podfile set syntax=ruby

" Map Ctrl+N to next search result in incremental search mode.
:cnoremap <c-n> <CR>n/<c-p>

" vim-test mappings and config
map <Leader>f :TestFile<CR>
map <Leader>s :TestNearest<CR>
" make test commands execute in split term
let test#strategy = "neovim"

" Insert newline by pressing Enter without going into insert
" mode
nmap <CR> o<Esc>

" Yank selection to system clipboard
vmap _ "+y

" Python provider config
let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog  = '/usr/local/bin/python3'

" NERDCommenter config

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" splitjoin config

let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_hanging_args = 0

" ruby-vim

let ruby_no_expensive = 0

" Remove trailing whitespace before saving in .rb files
autocmd BufWritePre *.rb %s/\s\+$//e

" Disable all bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Use truecolor
" if (has("termguicolors"))
"  set termguicolors
" endif

" <Esc> will remove current search highlight
nnoremap <esc> :noh<return><esc>:<del>

nmap <Leader>J :SplitjoinJoin<cr>
nmap <Leader>S :SplitjoinSplit<cr>

" Toggle quickfix list via vim-toggle-quickfix
nmap <Leader>q <Plug>window:quickfix:toggle

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" copy current file name (relative/absolute) to system clipboard
if has("mac") || has("gui_macvim") || has("gui_mac")
  " relative path  (src/foo.txt)
  nnoremap <leader>cf :let @*=expand("%")<CR>

  " absolute path  (/something/src/foo.txt)
  nnoremap <leader>cF :let @*=expand("%:p")<CR>
endif

" text objects to select inside&around '/' (e.g. regex)
" inside / (edit)
onoremap <silent> i/ :<C-U>normal! T/vt/<CR>
" around / (edit)
onoremap <silent> a/ :<C-U>normal! F/vf/<CR>
" inside / (visual)
xnoremap <silent> i/ :<C-U>normal! T/vt/<CR>
" around / (visual)
xnoremap <silent> a/ :<C-U>normal! F/vf/<CR>


call plug#begin('~/.nvim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'dracula/vim'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rhubarb' " vim-vinegar GitHub integration
" Plug 'lifepillar/vim-wwdc17-theme'
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf.vim'
Plug 'dag/vim-fish'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-unimpaired'
Plug 'drmingdrmer/vim-toggle-quickfix'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'jacoborus/tender.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'arcticicestudio/nord-vim'

call plug#end()

" Lightline
" let g:lightline = { 'colorscheme': 'tender' }
" let g:lightline = { 'colorscheme': 'material_vim' }
let g:lightline = { 'colorscheme': 'nord' }

" color dracula
" color tender
" color wwdc17
" set background=dark
" let g:material_theme_style = 'palenight' " 'default' | 'palenight' | 'dark'
" color material
" color quantum

" set termguicolors
let g:nord_comment_brightness = 20
color nord
