nnoremap <silent> <Plug>QuickfixToggle :call <SID>QuickfixToggle()<CR>

function! s:QuickfixToggle()
  let max_win = winnr('$')

  for i in range(1, max_win)
    let buf = winbufnr(i)
    let typ = getbufvar(buf, '&buftype')

    if typ == 'quickfix'
      cclose
      return
    endif
  endfor

  copen
endfunction

