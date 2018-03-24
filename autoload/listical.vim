if exists("g:autoloaded_listical") || &cp
  finish
endif
let g:autoloaded_listical = 1

func! listical#toggle()
  if s:loclist_exists()
    call listical#toggle_loclist()
  else
    call listical#toggle_quickfix()
  endif
endf

func! listical#toggle_loclist()
  if s:loclist_is_open()
    lclose
  else
    silent! lopen
  endif
endf

func! listical#toggle_quickfix()
  if s:quickfix_is_open()
    cclose
  else
    botright copen
  endif
endf

func! s:loclist_exists()
  return getloclist(0, {'id': 0}).id != 0
endf

func! s:quickfix_is_open()
  return getqflist({'winid': 0}).winid != 0
endf

func! s:loclist_is_open()
  return getloclist(0, {'winid': 0}).winid != 0
endf
