let s:plugin = maktaba#plugin#Get('codefmt')

""
" @private
" Formatter: cmake_format
function! codefmt#cmake_format#GetFormatter() abort
  let l:formatter = {
      \ 'name': 'cmake-format',
      \ 'setup_instructions': 'Install cmake-format ' .
          \ '(https://pypi.python.org/pypi/cmake-format/).'}

  function l:formatter.IsAvailable() abort
    return executable(s:plugin.Flag('cmake_format_executable'))
  endfunction

  function l:formatter.AppliesToBuffer() abort
    return codefmt#formatterhelpers#FiletypeMatches(&filetype, 'cmake')
  endfunction

  ""
  " Reformat the current buffer with cmake-format or the binary named in
  " @flag(cmake_format_executable)
  "
  " We implement Format(), and not FormatRange{,s}(), because cmake-format doesn't
  " provide a hook for formatting a range
  function l:formatter.Format() abort
    let l:executable = s:plugin.Flag('cmake_format_executable')

    call codefmt#formatterhelpers#Format([
        \ l:executable,
        \ '-'])
  endfunction

  return l:formatter
endfunction
