if exists("g:autoloaded_listical") || &cp
  finish
endif
let g:autoloaded_listical = 1

func! listical#toggle_quickfix()
  if s:quickfix_is_open()
    cclose
  else
    botright copen
  endif
endf

func! listical#toggle_loclist()
  let loclist = getloclist(0)

  for n in range(1, winnr('$'))
    if s:is_loclist_window(n) && getloclist(n) ==# loclist
      lclose
      return
    endif
  endfor

  if !empty(loclist)
    lopen
  endif
endf

func! s:quickfix_is_open()
  for n in range(1, winnr('$'))
    if s:is_quickfix_window(n)
      return 1
    endif
  endfor
  return 0
endf

func! s:is_quickfix_window(num)
  return s:is_qf_filetype(a:num) && empty(getloclist(a:num))
endf

func! s:is_loclist_window(num)
  return s:is_qf_filetype(a:num) && !empty(getloclist(a:num))
endf

func! s:is_qf_filetype(num)
  return getwinvar(a:num, '&filetype') == 'qf'
endf
