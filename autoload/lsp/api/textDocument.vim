function! lsp#api#textDocument#didOpen(uri)
  return {"method": "textDocument/didOpen", "params": {"uri": a:uri}}
endfunction

function! lsp#api#textDocument#reference()
  return {"method": "textDocument/reference", "params": {}}
endfunction
