if exists("g:loaded_listical") || &cp
  finish
endif
let g:loaded_listical = 1

func! s:QfxListical()
  if s:QfWindowIsOpen()
    cclose
  else
    botright copen
  endif
endf

func! s:QfWindowIsOpen()
  for n in range(1, winnr('$'))
    if s:IsQfWindow(n)
      return 1
    endif
  endfor
  return 0
endf

func! s:IsQfWindow(num)
  return s:IsQfFiletype(a:num) && empty(getloclist(a:num))
endf

func! s:IsQfFiletype(num)
  return getwinvar(a:num, '&filetype') == 'qf'
endf

func! s:LocListical()
  let loclist = getloclist(0)

  for n in range(1, winnr('$'))
    if s:IsLocWindow(n) && getloclist(n) ==# loclist
      lclose
      return
    endif
  endfor

  if !empty(loclist)
    lopen
  endif
endf

func! s:IsLocWindow(num)
  return s:IsQfFiletype(a:num) && !empty(getloclist(a:num))
endf

nnoremap <silent> <Plug>QfxListical :call <SID>QfxListical()<CR>
nnoremap <silent> <Plug>LocListical :call <SID>LocListical()<CR>


