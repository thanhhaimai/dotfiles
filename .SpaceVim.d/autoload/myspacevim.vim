function! myspacevim#before() abort
  set mouse=""
endfunction

function! myspacevim#after() abort
  set foldenable!

  let g:C_Ctrl_j = 'off'
  let g:BASH_Ctrl_j = 'off'
  map ; <Plug>(clever-f-repeat-forward)

  " Switch buffers
  nnoremap <C-l> :bn<CR>
  nnoremap <C-h> :bp<CR>
  
  " Drag current lines
  noremap <C-j> :m+<CR>
  noremap <C-k> :m-2<CR>
  inoremap <C-j> <Esc>:m+<CR>
  inoremap <C-k> <Esc>:m-2<CR>
  vnoremap <C-j> :m'>+<CR>gv
  vnoremap <C-k> :m-2<CR>gv
endfunction
