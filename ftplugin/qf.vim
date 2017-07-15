set nobuflisted

if mapcheck('q', 'n') ==# ''
  if empty(getloclist(0))
    " quickfix list
    nnoremap <buffer><silent> q :cclose<CR>
  else
    " location list
    nnoremap <buffer><silent> q :lclose<CR>
  endif
endif
