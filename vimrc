call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set rtp+=~/.vim/bundle/powerline_new/powerline/bindings/vim

" File types, wikipedia, & json
autocmd BufRead,BufNewFile *.wiki setfiletype Wikipedia
autocmd BufRead,BufNewFile *.wikipedia.org* setfiletype Wikipedia
autocmd BufRead,BufNewFile *.json setfiletype json
autocmd BufRead,BufNewFile *.md setfiletype markdown
autocmd BufRead,BufNewFile *.rb,*.yml,*.html setlocal shiftwidth=2 tabstop=2

let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabClosePreviewOnPopupClose = 1

" Airline 
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline_detect_whitespace = 0

let g:Gitv_DoNotMapCtrlKey=1
let g:slime_python_ipython=1
let g:slime_target = "tmux"

let g:godef_split = 0

let g:vim_markdown_folding_disabled=1

let g:fugitive_github_domains=["https://git.corp.yahoo.com"]
" Always cd using the active buffers directory
"autocmd BufEnter * lcd %:p:h

" Open Nerd tree on start and set focus to the empty buffer
autocmd vimenter * if !argc() | NERDTree | endif
autocmd VimEnter * wincmd p

" Enables omnicomplete and indent settings for the detected fileype
filetype plugin indent on

" Command T
let g:CommandTMaxHeight = 5
let g:CommandTMinHeight = 5

" Searching *******************************************************************
set hlsearch	" highlight search term
set incsearch	" Incremental search, search as you type
set ignorecase	" Ignore case when searching
set smartcase	" Ignore case when searching lowercase

" Colors **********************************************************************
syntax on	"sytnax highlighting
colorscheme  ingelmo

" Code folding ****************************************************************
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Vim UI **********************************************************************
set number 	        " Enable Line numbers
set showtabline=2   " Show the tab bar
set laststatus=2    " Show the status
set hidden          " Hide buffers by defaut which perserves their undo history

" Jedi ************************************************************************
let g:jedi#show_function_definition = "0"   " hide window after selecting method

" Other  **********************************************************************
set smartindent
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set clipboard=unnamed   " requires reattach-to-user-namespace to work inside tmux
set expandtab           " Use spaces not tabs
set nowrap
let g:NERDTreeShowPressForHelp = 0
let g:NERDTreeWinSize = 35
let NERDTreeIgnore = ['\.pyc$']
set noswapfile          " Disable the swap file
set mouse=a             " Let's you use the mouse in a terminal session
set tags=tags;/         " look for tags file in any folder (ctags)
let g:tagbar_left = 1   " Tagbar will open a window on the left
let mapleader=","       " Changed leader to comma
set backspace=indent,eol,start   " fix for homebrew vim backspace not working
set pastetoggle=<F2>
set history=1000        " save 1000 of the last commands
set scrolloff=3         " leaves 3 lines before top & bottom when scrolling
set completeopt=menuone,preview,longest
set completeopt-=preview
set wildignore+=node_modules

" ConqueTerm  ****************************************************************
"let g:ConqueTerm_ReadUnfocused = 1
"let g:ConqueTerm_InsertOnEnter = 1
"set updatetime=400  "uptime (ms) is how often vim runs its internal timer (don't set this any lower)
"let g:ConqueTerm_TERM='xterm'
" More sytnax highlighting for python, see ~/vim/syntax/python3.0.vim
"let python_highlight_all = 1

" Change the cursor from Block to Ibeam when switching betwen select/insert mode.
" iTerm provides a special escape sequence which makes this possible.
if exists('$ITERM_PROFILE')
    if exists('$TMUX')
        " tmux eates escape codes unless they too are escaped...
        " https://raw.github.com/sjl/vitality.vim/master/doc/vitality.txt
        let &t_SI = "\ePtmux;\e\e]50;CursorShape=1\x7\e\\" " change cursor to ibeam on entering insert mode
        let &t_EI = "\ePtmux;\e\e]50;CursorShape=0\x7\e\\" " change cursor to ibeam on entering normal mode
        let &t_te = "\ePtmux;\e\e]50;CursorShape=1\x7\e\\" " change cursor to ibeam on exiting to terminal
        let &t_ti = "\ePtmux;\e\e]50;CursorShape=0\x7\e\\" " change cursor to block on entering vim
    else
        let &t_SI = "\e]50;CursorShape=1\x7"
        let &t_EI = "\e]50;CursorShape=0\x7"
        let &t_te = "\e]50;CursorShape=1\x7" " change cursor to ibeam on exiting to terminal
        let &t_ti = "\e]50;CursorShape=0\x7" " change cursor to block on entering vim
    endif
endif

" Mappings  *****************************************************************
:inoremap jk <esc>
" window movement
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nmap <C-c><C-c> mzvip:SlimeSend<CR>`z
" Clear search results w/ ,/ instead of typing /asdfljasdkf
nmap <silent> ,/ :nohlsearch<CR>
" Forgot to use sudo? w!! to the rescue
cmap w!! w !sudo tee % >/dev/null
" Scroll up & down 2 lines at a time
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
" Map custom iTerm escape codes for ctrl-back and ctrl-del to delete-forward-word and delete-back-word
imap <ESC>z <c-w>
imap <ESC>d <c-c>ldwi
map <c-f> :NERDTreeFind<CR><c-w><c-p>
nmap <ESC>s :call Gorunner()<CR>:w<CR>
imap <ESC>s <ESC>:call Gorunner()<CR>:w<CR>l
map <c-g> <c-a>:w<CR>:colorscheme ingelmo<CR>
" Leader q will quit the active buffer without closing the window
nmap <silent> <leader>q :bp\|bd #<CR>

function! Gorunner()
  if &ft == "go"
    call system('touch ' . '.gorunner.tmp')
  endif
endfunction

" Allow shift key selection of text in insert mode
if has("gui_macvim")
    let macvim_hig_shift_movement = 1
endif

if has('gui_running')
    " set guifont=Inconsolata-dz:h11
    set guifont=Inconsolata-dz\ for\ Powerline:h11
    let g:Powerline_symbols = 'fancy'
endif

" Show syntax highlighting groups for word under cursor CTRL+P
" See http://vimcasts.org/episodes/creating-colorschemes-for-vim/
nmap <C-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
