function! s:out_cb(ch, msg)
  echomsg a:msg
endfunction

function! s:err_cb(ch, msg)
  "echomsg a:msg
endfunction

let s:client = {
\ 'id': 0,
\ 'job': v:none,
\ 'ch': v:none,
\}

function! lsp#client#create()
  let job = job_start('go-langserver')
  let ch = job_getchannel(job)
  call ch_setoptions(ch, {
  \ 'out_cb': function('s:out_cb'),
  \ 'err_cb': function('s:err_cb'),
  \ 'mode': 'raw',
  \})
  let client = deepcopy(s:client)
  let client.job = job
  let client.ch = ch
  return client
endfunction

function! s:client.send(req)
  let self.id += 1
  let req = deepcopy(a:req)
  let req.id = self.id
  let req.jsonrpc = 2.0
  let json = json_encode(req)
  let payload = printf("content-type: %d\r\n\r\n%s", len(json), json)
  let g:hoge = payload
  call ch_sendraw(self.ch, payload)
endfunction
