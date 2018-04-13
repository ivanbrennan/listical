if exists("g:loaded_listical") || &cp
  finish
endif
let g:loaded_listical = 1

nnoremap <silent> <Plug>(listical_toggle)   :call listical#toggle()<CR>
nnoremap <silent> <Plug>(listical_quickfix) :call listical#toggle_quickfix()<CR>
nnoremap <silent> <Plug>(listical_loclist)  :call listical#toggle_loclist()<CR>
nnoremap <silent> <Plug>(listical_next)     :call listical#next()<CR>
nnoremap <silent> <Plug>(listical_previous) :call listical#previous()<CR>
nnoremap <silent> <Plug>(listical_newer)    :call listical#newer()<CR>
nnoremap <silent> <Plug>(listical_older)    :call listical#older()<CR>
nnoremap <silent> <Plug>(listical_offset)   :call listical#offset()<CR>

func! IsList() abort
  return &filetype == 'qf'
endf

func! JustList() abort
  return IsList() && winnr('$') == 1
endf

augroup Listical
  autocmd QuitPre  * if !IsList() | silent! lclose | endif
  autocmd WinEnter * if JustList() | quit | endif
augroup END
