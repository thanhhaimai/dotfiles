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

" Vim5 and later versions support syntax highlighting. Uncommenting the
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

set expandtab
set shiftwidth=2
set softtabstop=2

" Disable X server
set cb="exclude:.*"

" Vim for Curmudgeons
" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set ruler
set showmode
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set incsearch		" Incremental search
set hlsearch
set visualbell
set number
"set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
set autoindent

autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino
autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino

nnoremap ; :
nnoremap j gj
nnoremap k gk

"Manage your tabs with ease.
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
map <C-j> :tabfirst<CR>
map <C-k> :tablast<CR>

"Write changes to protected read-only files.
cmap w!! %!sudo tee > /dev/null %
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsplit <CR>:exec("tag ".expand("<cword>"))<CR>
