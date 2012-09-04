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
Bundle 'tpope/vim-rails'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-easymotion'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
Bundle 'garbas/vim-snipmate'
Bundle 'kien/ctrlp.vim'

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
"======================================================================="

" vim5 and later versions support syntax highlighting. uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" Set tab options
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Disable X server
set cb="exclude:.*"

" Set UI
set ruler
set number
set list " Show special characters (I specified below)
set listchars=tab:→\ ,trail:·
"set visualbell
set showbreak=↪\  " Show at the start of line of a wrapped line
set showmode
set showcmd " Show (partial) command in status line.
set showmatch " Show matching brackets.

" Set search options
set incsearch " Incremental search
set hlsearch
set smartcase " Do smart case matching

" Set behaviors
set autowrite " Automatically save before commands like :next and :make
"set hidden " Hide buffers when they are abandoned
"set mouse=a " Enable mouse usage (all modes)
set autoindent
set splitbelow " put the new window below of the current one
set splitright " put the new window right of the current one

" Set tab completion
set wildmode=list:longest,list:full  " Tab completion
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*.swp,*~,._*

autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino
autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino
" Start NERDTree when open vim without arg
autocmd vimenter * if !argc() | NERDTree | endif
" Close vim when NERDTree is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

nnoremap ; :
nnoremap j gj
nnoremap k gk

" Manage tabs
map tt :tabedit<Space>
map tm :tabmove<Space>
map tf :tabfind<Space>
map tn :tabnew<CR>
map th :tabprev<CR>
map tl :tabnext<CR>
map tj :tabfirst<CR>
map tk :tablast<CR>
map tc :tabclose<CR>
map <C-h> :tabprev<CR>
map <C-l> :tabnext<CR>
" Manage buffers
map <C-j> :bn<CR>
map <C-k> :bp<CR>
" Manage windows
map <C-\> :vs<CR>
map <C-/> :sp<CR>
nmap <silent> <Up> :wincmd k<CR>
nmap <silent> <Down> :wincmd j<CR>
nmap <silent> <Left> :wincmd h<CR>
nmap <silent> <Right> :wincmd l<CR>
nmap <silent> <A-Up> :wincmd -<CR>
nmap <silent> <A-Down> :wincmd +<CR>
nmap <silent> <A-Left> :wincmd <<CR>
nmap <silent> <A-Right> :wincmd ><CR>
" Nerdtree toogle
nmap <F2> :NERDTreeToggle<CR>

" CtrlP settings
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\|\.DS_Store'
  \ }

"Write changes to protected read-only files.
cmap w!! %!sudo tee > /dev/null %

" Define 4 custom highlight groups
" flags
hi User1 ctermbg=red ctermfg=white
" path
hi User2 ctermbg=blue ctermfg=white
" type
hi User3 ctermbg=green ctermfg=white
" line and column
hi User4 ctermbg=cyan ctermfg=white

" Set statusline
set laststatus=2                             " always show the status line
set statusline=                              " reset statusline
set statusline+=%<\                          " cut at start
set statusline+=[%n%1*%H%M%R%W%*]\           " flags and buf no
set statusline+=%2*\ %-.40f\ %*\              " path
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]\             " file format
set statusline+=%4*\ %((%l,%c)%)\            " line and column
set statusline+=%P\ %*\                      " percentage of file
set statusline+=%k\ %*\                      " keymap
set statusline+=%=                           " right align
set statusline+=%3*\ %{synIDattr(synID(line('.'),col('.'),1),'name')}\ %*\  " highlight
set statusline+=%b,0x%B\                   " current char
set statusline+=%{fugitive#statusline()}\    " git status line
