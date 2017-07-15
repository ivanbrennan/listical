if exists("g:loaded_listical") || &cp
  finish
endif
let g:loaded_listical = 1

func! s:ActiveBuffers()
  return split(execute('silent! buffers a'), '\n')
endf

func! s:BuffersOfType(type)
  return filter(s:ActiveBuffers(), 'v:val =~ "'.a:type.'"')
endf

func! s:BufnrsFor(buffers)
  return map(a:buffers, 'str2nr(matchstr(v:val, "\\d\\+"))')
endf

func! s:IsOpen(bufnr)
  return bufwinnr(a:bufnr) != -1
endf

func! s:QfxListical()
  for bufnr in s:BufnrsFor(s:BuffersOfType("Quickfix List"))
    if s:IsOpen(bufnr)
      cclose
      return
    endif
  endfor
  botright copen
endf

func! s:LocListical()
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
endf

nnoremap <silent> <Plug>QfxListical :call <SID>QfxListical()<CR>
nnoremap <silent> <Plug>LocListical :call <SID>LocListical()<CR>


