let s:c = lsp#client#create()
call s:c.send(lsp#api#initialize("c:/dev/go-sandbox", {}))
sleep 1
call s:c.send(lsp#api#textDocument#didOpen("/dev/go-sandbox/foo.go"))
sleep 1
call s:c.send(lsp#api#textDocument#hover("/dev/go-sandbox/foo.go"))
