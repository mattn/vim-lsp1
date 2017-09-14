function! lsp#api#initialize(rootUri, capabilities)
  return {"method": "initialize", "params": {"rootUri": a:rootUri, "capabilities": a:capabilities}}
endfunction


