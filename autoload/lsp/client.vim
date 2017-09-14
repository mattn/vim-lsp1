function! s:out_cb(client, ch, msg) abort
  let text = a:client.rest . a:msg
  while !empty(text)
    let token = matchlist(text, '^\_.\{-}\r\?\n\r\?\n')
    if len(token) == 0
      let s:client = text
	  return
    endif
    let cl = -1
    for l in split(token[0], '\r?\n')
      let header = matchlist(l, '^Content-Length:\s\([0-9]\+\)')
      if len(header)
        let cl = header[1]
        break
      endif
    endfor
    let pos = len(token[0])
    let body = text[pos: pos+cl-1]
    echomsg string(json_decode(body))
    let text = text[pos+cl:]
  endwhile
endfunction

function! s:err_cb(client, ch, msg) abort
  echomsg a:msg
endfunction

let s:client = {
\ 'id': 0,
\ 'job': v:none,
\ 'ch': v:none,
\ 'rest': '',
\}

function! lsp#client#create() abort
  let job = job_start(['go-langserver', '-trace', '-logfile', 'foo.log'])
  let ch = job_getchannel(job)

  let client = deepcopy(s:client)
  let client.job = job

  call ch_setoptions(ch, {
  \ 'out_cb': function('s:out_cb', [client]),
  \ 'err_cb': function('s:err_cb', [client]),
  \ 'mode': 'raw',
  \})
  let client.ch = ch
  return client
endfunction

function! s:client.send(req) abort
  let self.id += 1
  let req = deepcopy(a:req)
  let req.id = self.id
  let req.jsonrpc = 2.0
  let json = json_encode(req)
  let payload = printf("Content-Length: %d\r\n\r\n%s", len(json), json)
  call ch_sendraw(self.ch, payload)
endfunction
