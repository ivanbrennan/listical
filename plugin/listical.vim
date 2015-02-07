if exists("g:loaded_listical") || &cp
  finish
endif
let g:loaded_listical = 1

function! s:BnumsFor(str)
  redir   =>listings
  silent! ls
  redir   END

  let buffers = filter(split(listings, '\n'), 'v:val =~ "'.a:str.'"')

  return map(buffers, 'str2nr(matchstr(v:val, "\\d\\+"))')
endfunction

function! s:QfxListical()
  for bnum in s:BnumsFor("Quickfix List")
    if bufwinnr(bnum) != -1
      cclose
      return
    endif
  endfor
  copen
endfunction

function! s:LocListical()
  let curbnum = winbufnr(0)
  for bnum in s:BnumsFor("Location List")
    if curbnum == bnum
      lclose
      return
    endif
  endfor

  if getloclist(0) != []
    lopen
  endif
endfunction

nnoremap <silent> <Plug>QfxListical :call <SID>QfxListical()<CR>
nnoremap <silent> <Plug>LocListical :call <SID>LocListical()<CR>


