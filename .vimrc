" --- Plugins ---
call plug#begin('~/.vim/plugged')

" Ayu Theme
Plug 'ayu-theme/ayu-vim'
" Polyglot
Plug 'sheerun/vim-polyglot'
" Goyo writing
Plug 'junegunn/goyo.vim'
" Easy motion
Plug 'easymotion/vim-easymotion'
" Ack
Plug 'mileszs/ack.vim'
" Comment
Plug 'tpope/vim-commentary'
" MultiCursor
Plug 'terryma/vim-multiple-cursors'
" Basically only used to rename 
Plug 'tpope/vim-eunuch'

call plug#end() " required

" --- Options ---
"
set encoding=utf8 
set ffs=unix " Use Unix as the standard file type

set cmdheight=2 " Height of the command bar
set ruler "Always show current position
set so=7 "Lines to the cursor - when moving vertically using j/k
set number "Line number
set noshowmode "Don't show --INSERT--

set autoread " Auto read when a file is changed from the outside
set history=500 " How many lines of history VIM has to remember
set hidden " A buffer becomes hidden when it is abandoned

set backspace=eol,start,indent " Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l

set wildmenu " Turn on the Wild menu
set wildignorecase "Ignore case when searching file

set ignorecase " Ignore case when searching
set smartcase " When searching try to be smart about cases 
set incsearch " Makes search act like search in modern browsers
set hlsearch " Highlight search results

set noerrorbells " No annoying sound on errors
set novisualbell
set t_vb=

set lazyredraw " Don't redraw while executing macros (good performance config)

set magic " For regular expressions turn magic on

set showmatch " Show matching brackets when text indicator is over them
set mat=2 " How many tenths of a second to blink when matching brackets

set tm=500 "Tiemout length for remaps"

set nobackup "Do not use backup file
set nowb
set noswapfile

set completeopt-=preview "Don't show complete preview
set completeopt+=menuone "Show complete menu even if there is one

set expandtab " Use spaces instead of tabs 
set smarttab " Be smart when using tabs
set shiftwidth=4 " 1 tab == 4 spaces
set tabstop=4

set linebreak
set textwidth=80 " Linebreak on 80 characters

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set clipboard=unnamedplus "Use system clipboard

" Set <Leader> to comma
let mapleader = ","

" Enable filetype plugins
filetype plugin on
filetype indent on

" :WW sudo saves the file 
command WW w !sudo tee % > /dev/null

" --- VIM user interface ---

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Add a bit extra margin to the left
set foldcolumn=1
hi foldcolumn ctermbg=Black ctermfg=Black
" Set fold to use indent
set foldmethod=indent
" Auto expand all indentation on open
au BufRead * normal zR


" --- Terminal stuff ---

" Cursor in terminal
" https://vim.fandom.com/wiki/Configuring_the_cursor
" 1 or 0 -> blinking block
" 2 solid block
" 3 -> blinking underscore
" 4 solid underscore
" Recent versions of xterm (282 or above) also support
" 5 -> blinking vertical bar
" 6 -> solid vertical bar

if &term =~ '^xterm'
	" normal mode
	let &t_EI .= "\<Esc>[0 q"
	" insert mode
	let &t_SI .= "\<Esc>[6 q"
endif

" Enable syntax highlighting
syntax enable 

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif


" enable true colors support
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

set background=dark
let ayucolor="dark"   " for dark version of theme
colorscheme ayu


" --- Status line ---
" Always show the status line
set laststatus=2

" Format the status line
set statusline=
set statusline+=%#Visual#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#DiffAdd#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=%#Cursor#\ %n\           " buffer number
set statusline+=%#Visual#       " colour
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=%#CursorIM#     " colour
set statusline+=%R                        " readonly flag
set statusline+=%m                        " modified [+] flag
set statusline+=%#Cursor#               " colour
set statusline+=%#CursorLine#     " colour
set statusline+=\ %F\                   " file name
set statusline+=%=                          " right align
set statusline+=%#CursorLine#   " colour
set statusline+=\ %Y\                   " file type
set statusline+=%#Visual#     " colour
set statusline+=\ %3l:%-2c\         " line + column
set statusline+=%#Visual#       " colour
set statusline+=\ %3p%%\                " percentage

hi statusline ctermbg=Grey ctermfg=Black


" --- Visual mode ---
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


" --- Moving around, tabs, windows and buffers ---
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" --- Editing mappings
" Remap 0 to first non-blank character
map 0 ^

" Ctrl backspace delete word
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

noremap <leader>p li<space><esc>p 
noremap <leader>P i<space><esc>p 


let g:ycm_key_list_stop_completion = [ '<C-y>', '<Enter>' ]


" --- Misc ---
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif


" --- Helper functions ---
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?''.l:branchname.'  ':''
endfunction
