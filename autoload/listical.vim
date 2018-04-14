if exists("g:autoloaded_listical") || &cp
  finish
endif
let g:autoloaded_listical = 1

func! listical#toggle() abort
  if s:loclist_exists()
    call listical#toggle_loclist()
  else
    call listical#toggle_quickfix()
  endif
endf

func! listical#toggle_loclist() abort
  if s:loclist_is_open()
    lclose
  else
    silent! lopen
  endif
endf

func! listical#toggle_quickfix() abort
  if s:quickfix_is_open()
    cclose
  else
    botright copen
  endif
endf

func! listical#next() abort
  call s:go('next')
endf

func! listical#previous() abort
  call s:go('prev')
endf

func! listical#newer() abort
  call s:go('newer')
endf

func! listical#older() abort
  call s:go('older')
endf

func! s:go(cmd) abort
  let prefix = s:loclist_exists() ? 'l' : 'c'
  try
    exec prefix . a:cmd
    call s:doautocmd(a:cmd)
    call s:recall_search_pattern(prefix)
  catch /\v^Vim%(\(\a+\))?:E%(42|553)/ " no more items
    echohl ErrorMsg | echo v:exception | echohl None
  catch /\v^Vim%(\(\a+\))?:E%(380|381)/ " no more lists
    " stay silent to avoid the MORE prompt
  endtry
endf

func! s:doautocmd(name)
  if exists('#User#listical_'.a:name)
    exec 'doautocmd <nomodeline> User listical_'.a:name
  endif
endf

func! s:recall_search_pattern(prefix) abort
  let ctx = s:getlist(a:prefix).context
  if !empty(ctx) | let @/ = ctx | endif
endf

func! s:getlist(prefix) abort
  return a:prefix == 'l' ? getloclist(0, {'context': 0})
  \                      : getqflist({'context': 0})
endf

func! s:loclist_exists() abort
  return getloclist(0, {'id': 0}).id != 0
endf

func! s:loclist_is_open() abort
  return getloclist(0, {'winid': 0}).winid != 0
endf

func! s:quickfix_is_open() abort
  return getqflist({'winid': 0}).winid != 0
endf
