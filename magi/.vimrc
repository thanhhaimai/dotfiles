" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Go runtime support for vim
set rtp+=$GOROOT/misc/vim 
"======================================================================="
" Vundle option:
"======================================================================="
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-easymotion'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "scrooloose/snipmate-snippets"
Bundle 'garbas/vim-snipmate'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'tomtom/tcomment_vim'
Bundle 'sjl/gundo.vim'
Bundle 'briancollins/vim-jst'
Bundle 'wavded/vim-stylus'
Bundle 'gregsexton/MatchTag'
Bundle 'xuhdev/vim-latex-live-preview'
Bundle 'Valloric/YouCompleteMe'
Bundle 'airblade/vim-gitgutter'
Bundle 'kchmck/vim-coffee-script'
" install pydoc
"
filetype plugin indent on     " required!

" NOTE: comments after Bundle command are not allowed..
"======================================================================="

" vim5 and later versions support syntax highlighting. uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Set colors
set t_Co=256
colorscheme Mai-Tomorrow-Night-Bright

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
" if has("autocmd")
"   au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" Make VIM faster!
"set synmaxcol=128
set ttyfast

" The default updatetime of 4 seconds is too slow
set updatetime=1000

" Set tab options
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Disable X server
set cb="exclude:.*"

" Set UI
set rnu " Set relative number
set ruler
set list " Show special characters (I specified below)
set listchars=tab:→\ ,trail:·
" set visualbell
set showbreak=↪\  " Show at the start of line of a wrapped line
set showcmd " Show (partial) command in status line.
set showmode
set showmatch " Show matching brackets.
set scrolloff=7
set cursorline

" Set wordwrap

" Set search options
set incsearch " Incremental search
set hlsearch
set smartcase " Do smart case matching
"set gdefault " Subtitute all matches in a line by default

" Set behaviors
" set autowrite " Automatically save before commands like :next and :make
" set hidden " Hide buffers when they are abandoned
" set mouse=a " Enable mouse usage (all modes)
set autoindent
set autoread " Update open files when changed externally
set splitbelow " put the new window below of the current one
set splitright " put the new window right of the current one
set backspace=2 " allow deleting charaters backward

" Set tab completion
set wildmode=list:longest,list:full  " Tab completion
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*.swp,*~,._*

" Automatically reload vimrc when it's saved
augroup AutoReloadVimRC
  au!
  au BufWritePost .vimrc so ~/.vimrc
augroup END

" Set cursor to ibeam in insert mode and block in normal mode
" if has("autocmd")
"   au InsertEnter * silent execute "!mateconftool-2 --type string --set /apps/mate-terminal/profiles/Default/cursor_shape ibeam"
"   au InsertLeave * silent execute "!mateconftool-2 --type string --set /apps/mate-terminal/profiles/Default/cursor_shape block"
"   au VimLeave * silent execute "!mateconftool-2 --type string --set /apps/mate-terminal/profiles/Default/cursor_shape block"
" endif
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal g'\"" |
      \ endif

" autocmd BufReadPost COMMIT_EDITMSG gg

autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino
autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino
autocmd! BufNewFile,BufRead *.hn setlocal ft=c
autocmd! BufNewFile,BufRead *.vrapperrc setlocal ft=vim
autocmd! BufRead,BufNewFile *.go set filetype=go
" Start Tagbar when open vim
" autocmd VimEnter * TagbarOpen
" Start NERDTree when open vim without arg
" autocmd VimEnter * if !argc() | NERDTree | endif
" Close vim when NERDTree is the only window left
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Set relative number in normal mode, and line number in insert mode
autocmd InsertEnter * :set nu
autocmd InsertLeave * :set rnu

" Only have cursorline in current window
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

autocmd BufWritePre *.{cpp,hpp,h,c,cc,hn,java,py} :call StripTrailingWhitespace()

"======================================================================="
" Key maps
"======================================================================="

set timeout
set timeoutlen=300
set ttimeout
set ttimeoutlen=10

" Set Alt mapping for most keys
let c='A'
while c <= '~'
  " these keys can't be mapped properly without side effects
  if c != '>' && c != '|' && c != '[' && c != 'O'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
  endif
  let c = nr2char(1+char2nr(c))
endw

" Remap leader to comma
let mapleader = ","

"Write changes to protected read-only files.
cmap w!! %!sudo tee > /dev/null %

" Make Y copy from cursor to EOL
map Y y$

" Movement maps
" nnoremap ; :
" nnoremap : ;
noremap j gj
noremap k gk
" nnoremap $ g$
" nnoremap ^ g^

" Reselect visual block after indentation
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" Manage tabs
" map tt :tabedit<Space>
" map tm :tabmove<Space>
" map tf :tabfind<Space>
" map tn :tabnew<CR>
" map th :tabprev<CR>
" map tl :tabnext<CR>
" map tj :tabfirst<CR>
" map tk :tablast<CR>
" map tc :tabclose<CR>
" Map t<i> to tab ith
" for i in range(1,9)
"   exec 'map t'.i.' '.i.'gt'
" endfor

" Better command line editing
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Keep search term at the center of the screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" Toggle Highlight Search
nnoremap <silent> <Space> :set hlsearch! hlsearch?<CR>
nnoremap <silent> <C-e> :call ToggleList("Quickfix List", 'copen', 'cclose')<CR>
" nnoremap <silent> <C-S-L> :call ToggleList("Location List", 'l')<CR>
map <silent> <C-c> q:

" Manage buffers
nnoremap <C-j> :bn<CR>
nnoremap <C-k> :bp<CR>

" Manage Tabs
map <C-l> :tabnext<CR>
map <C-h> :tabprev<CR>

" Circle quick fix
map <A-h> :cp<CR>
map <A-l> :cn<CR>

" Manage windows
map <C-\> :vs<CR>
" nmap <silent> <Up> :wincmd k<CR>
" nmap <silent> <Down> :wincmd j<CR>
" nmap <silent> <Left> :wincmd h<CR>
" nmap <silent> <Right> :wincmd l<CR>
nmap <silent> <A-Up> :wincmd -<CR>
nmap <silent> <A-Down> :wincmd +<CR>
nmap <silent> <A-Left> :wincmd <<CR>
nmap <silent> <A-Right> :wincmd ><CR>

" Replace the current word with the most recent yank
vnoremap <A-p> d"0P
nnoremap <A-p> diw"0P

" Drag current lines
noremap <A-j> :m+<CR>
noremap <A-k> :m-2<CR>
inoremap <A-j> <Esc>:m+<CR>
inoremap <A-k> <Esc>:m-2<CR>
vnoremap <A-j> :m'>+<CR>gv
vnoremap <A-k> :m-2<CR>gv

" Easymotion shortcuts
nmap <A-w> <leader><leader>w
nmap <A-b> <leader><leader>b
nmap <A-a> <leader><leader>f
nmap <A-e> <leader><leader>e

" TComment keys
nmap <A-q> :TComment<CR>
nmap <A-c> :TCommentBlock<CR>

nnoremap <silent> <A-o> o<Esc><Esc>

" Grep
map <A-f> :call GlobalGrep(expand("<cword>"))<CR>
map <A-F> :call GlobalGrepPrompt()<CR>

" Find the current word in the same file
map <A-n> *
map <A-N> #

" CTags
map <A-]> :vs <CR>:exec("tag ".expand("<cword>"))<CR>

" Nerdtree toogle
nmap <F2> :NERDTreeToggle<CR>

" TagBar toggle
nmap <F4> :TagbarToggle<CR>

" Run current line
nmap <F5> :.!sh<CR>

" Gundo toggle
nmap <F6> :GundoToggle<CR>

" Make 0 move back and forth between BOL and first word in line
function! SmartHome()
  let first_nonblank = match(getline('.'), '\S') + 1
  if first_nonblank == 0
    return col('.') + 1 >= col('$') ? '0' : '^'
  endif
  if col('.') == first_nonblank
    return '0'  " if at first nonblank, go to start line
  endif
  return &wrap && wincol() > 1 ? 'g^' : '^'
endfunction
noremap <expr> <silent> <Char-48> SmartHome()

" Make F7 remove trailing white space
function! StripTrailingWhitespace()
  normal mZ
  %s/\s\+$//e
  if line("'Z") != line(".")
    echo "Stripped whitespace\n"
  endif
  normal `Z
endfunction
nmap <F7> :call StripTrailingWhitespace()<CR>

function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! ToggleList(bufname, cmdopen, cmdclose)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:cmdclose)
      return
    endif
  endfor
  if a:cmdopen == 'lopen' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:cmdopen)
  if winnr() != winnr
    wincmd p
  endif
endfunction

function! GlobalGrepPrompt()
  " prompt for string
  echohl Question
  call inputsave()
  let inp = input('Enter string to grep:')
  call inputrestore()
  echohl None

  call GlobalGrep(inp)
endfunction

function! GlobalGrep(inp)
  " Check that we have an input
  if empty(a:inp)
    redraw!
    return
  endif

  silent! execute "grep -srnw --binary-files=without-match --exclude=*tags --exclude-dir=.git . -e " . a:inp . " " | cwindow
  redraw!
  echo a:inp
endfunction

"======================================================================="
" Other settings
"======================================================================="

" Mark the 101 columns
if exists('+colorcolumn')
  set colorcolumn=101
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
endif

" TagBar settings
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_indent = 1
let g:tagbar_sort = 0
let g:tagbar_iconchars = ['▷', '◢']
let g:tagbar_autoshowtag = 1

" Enable persistent undo
if exists("+undofile")
  set udf
  set undodir=~/.vimundo
endif
" CtrlP settings
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.git$\|\.hg$\|\.svn$',
      \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\|\.DS_Store'
      \ }

" Syntastic settings
let g:syntastic_check_on_open=0 " check on first load
"let g:syntastic_error_symbol='✗'
let g:syntastic_error_symbol='»'
let g:syntastic_stl_format = ' %E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w} '
"let g:syntastic_warning_symbol='⚠'
let g:syntastic_warning_symbol='»'

" EasyMotion settings
let g:EasyMotion_keys = 'jkl;asdfiowerutyqpzxcvm,./bn238901'
" let g:EasyMotion_leader_key = '<Leader>'
"hi link EasyMotionTarget User1

" YouCompleteMe settings
let g:ycm_allow_changing_updatetime = 0
let g:ycm_min_num_of_chars_for_completion = 1

" Highlight Selection
hi Visual cterm=bold

" Define 4 custom highlight groups for statusline
" flags
hi User1 ctermbg=red ctermfg=white cterm=bold
" path
hi User2 ctermbg=blue ctermfg=white
" type
hi User3 ctermbg=blue ctermfg=white
" line and column
hi User4 ctermbg=darkblue ctermfg=white cterm=bold

" Set statusline
set laststatus=2                             " always show the status line
set statusline=                              " reset statusline
set statusline+=%<\                          " cut at start
set statusline+=[%n%1*%H%M%R%W%*]\           " flags and buf no
set statusline+=%2*\ %-.50f\ %*              " path
set statusline+=%1*%{SyntasticStatuslineFlag()}%*
set statusline+=\ [%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]\             " file format
set statusline+=%4*\ %((%l,%c)%)\            " line and column
set statusline+=%P\ %*\                      " percentage of file
set statusline+=%k\ %*\                      " keymap
set statusline+=%=                           " right align
set statusline+=%3*\ %{synIDattr(synID(line('.'),col('.'),1),'name')}\ %*\  " highlight
set statusline+=%b,0x%B\                   " current char
set statusline+=%{fugitive#statusline()}\    " git status line
