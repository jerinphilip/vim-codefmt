let s:plugin = maktaba#plugin#Get('codefmt')

""
" @private
" Formatter: ruff
function! codefmt#ruff#GetFormatter() abort
  let l:formatter = {
      \ 'name': 'ruff',
      \ 'setup_instructions': 'Install ruff' .
          \ '(https://docs.astral.sh/ruff/).'}

  function l:formatter.IsAvailable() abort
    return executable(s:plugin.Flag('ruff_executable'))
  endfunction

  function l:formatter.AppliesToBuffer() abort
    return codefmt#formatterhelpers#FiletypeMatches(&filetype, 'cmake')
  endfunction

  ""
  " Reformat the current buffer with ruff or the binary named in
  " @flag(ruff_executable)
  "
  " We implement Format(), and not FormatRange{,s}(), because ruff doesn't
  " provide a hook for formatting a range
  function l:formatter.Format() abort
    let l:executable = s:plugin.Flag('ruff_executable')

    call codefmt#formatterhelpers#Format([
        \ l:executable,
        \ 'format',
        \ '-'])
  endfunction

  return l:formatter
endfunction
