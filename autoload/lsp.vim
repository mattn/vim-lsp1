function! lsp#complete(findstart, base) abort
  if !has_key(s:, 'client')
    return []
  endif
  if a:findstart
    let l = getline('.')
    let c = col('.')
    if l[c-2] =~ '\k'
      return matchend(l[:c-1], '\v.*<')
    endif
    return c
  endif
  call lsp#api#textDocument#complete({'completeFromColumn': col('.')})
  call s:client.send(lsp#api#textDocument#completion(s:fspath(expand('%:p')), getcurpos()))
endfunction

function! s:fspath(p) abort
  return a:p[len(s:client.root):]
endfunction

function! lsp#hover() abort
  call s:client.send(lsp#api#textDocument#hover(s:fspath(expand('%:p')), getcurpos()), {client, response->{execute('echomsg string(response)', 1)}})
endfunction

let s:lsp_server = {
\  'go': {
\    'cmd': ['go-langserver', '-trace', '-logfile', 'lsp.log'],
\  },
\  'rust': {
\    'cmd': ['rustup', 'run', 'nightly', 'rls'],
\  },
\}

function! lsp#open(ft, file) abort
  if !has_key(s:, 'client')
    if !has_key(s:lsp_server, a:ft)
      return
    endif
    let opts = s:lsp_server[a:ft]
    let s:client = lsp#client#create(opts)
	let s:client.root = getcwd()
    call s:client.send(lsp#api#initialize(s:client.root, {}))
  endif
  call s:client.send(lsp#api#textDocument#didOpen(s:fspath(a:file)))
  command! -buffer LspHover call lsp#hover()
endfunction
