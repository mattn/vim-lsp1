function! lsp#api#initialize(root, capabilities)
  "let root = has('win32') ? ('/' . a:root) : a:root
  let root = a:root
  let uri = '/' . tr(root, '\', '/')
  return {"method": "initialize", "params": {"rootPath": uri, "capabilities": a:capabilities}}
endfunction
