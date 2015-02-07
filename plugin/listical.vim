if exists("g:loaded_listical") || &cp
  finish
endif
let g:loaded_listical = 1

function! s:Buffers()
  redir   =>output
  silent! buffers
  redir   END

  return split(output, '\n')
endfunction

function! s:BuffersOfType(type)
  return filter(s:Buffers(), 'v:val =~ "'.a:type.'"')
endfunction

function! s:BufnrsFor(buffers)
  return map(a:buffers, 'str2nr(matchstr(v:val, "\\d\\+"))')
endfunction

function! s:IsOpen(bufnr)
  return bufwinnr(a:bufnr) != -1
endfunction

function! s:QfxListical()
  for bufnr in s:BufnrsFor(s:BuffersOfType("Quickfix List"))
    if s:IsOpen(bufnr)
      cclose
      return
    endif
  endfor
  botright copen
endfunction

function! s:LocListical()
  let cur_bufnr = winbufnr(0)

  for bufnr in s:BufnrsFor(s:BuffersOfType("Location List"))
    if bufnr == cur_bufnr
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


