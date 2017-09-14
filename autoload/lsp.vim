let s:c = lsp#client#create()
call s:c.send(lsp#api#initialize("file:///c:/dev/go-sandbox", {}))
call s:c.send(lsp#api#textDocument#didOpen("foo.go"))
call s:c.send(lsp#api#textDocument#reference())
