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

func! listical#next()
  call s:go('next')
endf

func! listical#previous()
  call s:go('prev')
endf

func! listical#newer()
  call s:go('newer')
endf

func! listical#older()
  call s:go('older')
endf

func! s:go(cmd)
  let prefix = s:loclist_exists() ? 'l' : 'c'
  try
    exec prefix . a:cmd
  catch /\v^Vim%(\(\a+\))?:E553/ " no more items
    echohl ErrorMsg | echo v:exception | echohl None
  catch /\v^Vim%(\(\a+\))?:E%(380|381)/ " no more lists
    " stay silent to avoid the MORE prompt
  endtry
  call s:recall_search_pattern(prefix)
endf

func! s:recall_search_pattern(prefix)
  let ctx = s:getlist(a:prefix).context
  if !empty(ctx) | let @/ = ctx | endif
endf

func! s:getlist(prefix)
  return a:prefix == 'l' ? getloclist(0, {'context': 0})
  \                      : getqflist({'context': 0})
endf

func! s:loclist_exists()
  return getloclist(0, {'id': 0}).id != 0
endf

func! s:loclist_is_open()
  return getloclist(0, {'winid': 0}).winid != 0
endf

func! s:quickfix_is_open()
  return getqflist({'winid': 0}).winid != 0
endf
