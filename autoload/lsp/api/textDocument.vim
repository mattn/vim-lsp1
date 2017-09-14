function! lsp#api#textDocument#didOpen(file)
  let uri = 'file://' . tr(a:file, '\', '/')
  let content = join(readfile(a:file), "\n")
  return {"method": "textDocument/didOpen", "params": {"textDocument":{"uri": uri, "text": content}}}
endfunction

function! lsp#api#textDocument#references()
  return {"method": "textDocument/references", "params": {}}
endfunction

function! lsp#api#textDocument#hover(file)
  let uri = 'file://' . tr(a:file, '\', '/')
  return {"method": "textDocument/hover", "params": {"textDocument": {"uri": uri}, "position": {"line": 1, "characters": 1}}}
endfunction
