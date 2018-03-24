if exists("g:loaded_listical") || &cp
  finish
endif
let g:loaded_listical = 1

nnoremap <silent> <Plug>(listical_toggle)   :call listical#toggle()<CR>
nnoremap <silent> <Plug>(listical_quickfix) :call listical#toggle_quickfix()<CR>
nnoremap <silent> <Plug>(listical_loclist)  :call listical#toggle_loclist()<CR>
