function! lsp#api#textDocument#didOpen(file) abort
  let uri = 'file://' . tr(a:file, '\', '/')
  return {'method': 'textDocument/didOpen', 'params': {'textDocument':{'uri': uri}}}
endfunction

function! lsp#api#textDocument#references() abort
  return {'method': 'textDocument/references', 'params': {}}
endfunction

function! lsp#api#textDocument#hover(file, pos) abort
  let uri = 'file://' . tr(a:file, '\', '/')
  let pos = {'line': a:pos[1]-1, 'character': a:pos[2]-1}
  return {'method': 'textDocument/hover', 'params': {'textDocument': {'uri': uri}, 'position': pos}}
endfunction

function! lsp#api#textDocument#completion(file, pos) abort
  let uri = 'file://' . tr(a:file, '\', '/')
  let pos = {'line': a:pos[1]-1, 'character': a:pos[2]-1}
  return {'method': 'textDocument/hover', 'params': {'textDocument': {'uri': uri}, 'position': pos}}
endfunction
