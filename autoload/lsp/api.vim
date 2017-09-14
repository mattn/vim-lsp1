function! lsp#api#initialize(root, capabilities)
  let uri = 'file:///' . tr(a:root, '\', '/')
  return {"method": "initialize", "params": {"rootUri": uri, "capabilities": a:capabilities}}
endfunction


