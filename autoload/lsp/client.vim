function! s:out_cb(client, ch, msg) abort
  let a:client.text = a:client.rest . a:msg
  while !empty(a:client.text)
    let token = matchlist(a:client.text, '^\_.\{-}\r\?\n\r\?\n')
    if len(token) == 0
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
    let json = a:client.text[pos: pos+cl-1]
    let obj = json_decode(json)
    echo obj
    if has_key(obj, 'id') && has_key(a:client.cb, obj.id)
      try
        call call(a:client.cb[obj.id], [a:client, obj])
      catch
      finally
        call remove(a:client.cb, obj.id)
      endtry
    endif
    let a:client.text = a:client.text[pos+cl:]
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
\ 'root': '',
\ 'cb': {},
\}

function! lsp#client#create(opts) abort
  let job = job_start(a:opts.cmd)
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

function! s:client.send(req, ...) abort
  let X = get(a:000, 0, v:none)
  let self.id += 1
  if type(X) != type(v:none)
    let self.cb[self.id] = X
  endif
  let req = deepcopy(a:req)
  let req.id = self.id
  let req.jsonrpc = 2.0
  let json = json_encode(req)
  let payload = printf("Content-Length: %d\r\n\r\n%s", len(json), json)
  call ch_sendraw(self.ch, payload)
endfunction
