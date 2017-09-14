let s:c = lsp#client#create()
call s:c.send(lsp#api#initialize("c:/dev/go-sandbox", {}))
call s:c.send(lsp#api#textDocument#didOpen("/dev/go-sandbox/foo.go"))
call s:c.send(lsp#api#textDocument#hover("/dev/go-sandbox/foo.go", {"line": 24, "character": 38}))
