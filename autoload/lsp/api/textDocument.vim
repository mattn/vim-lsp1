function! lsp#api#textDocument#didOpen(uri)
  return {"method": "textDocument/didOpen", "params": {"uri": a:uri}}
endfunction

function! lsp#api#textDocument#reference()
  return {"method": "textDocument/reference", "params": {}}
endfunction

function! lsp#api#textDocument#hover(textDocument, position)
  return {"method": "textDocument/hover", "params": {"textDocument": a:textDocument, "position": a:position}}
endfunction
