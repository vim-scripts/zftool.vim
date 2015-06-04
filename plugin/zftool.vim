" The "Vim ZFTool" plugin provides you with ZFTool commands
"
" Author:  dsaenztagarro
" URL:     https://github.com/dsaenztagarro/ZFTool.vim
" Version: 0.1
" ----------------------------------------------------------------------------

if exists('g:loaded_zftool') || &cp
  " finish
endif
let g:loaded_zftool = 1

" Initializations {{{
let g:zftool_last_module = ''
let g:zftool_last_controller = ''
let g:zftool_last_command = ''
" }}}
" Utility Functions {{{
function RunWithVimux(cmd)
  if exists('$TMUX')
    if exists(':VimuxRunCommand')
      call VimuxRunCommand(a:cmd)
    else
      echo 'ERROR: Missing vim plugin Vimux'
    endif
  else
    echo 'ERROR: Required running inside TMUX session'
  endif
endfunction!
" }}}
" Private functions {{{
function s:input_module_name(last)
  if !a:last
    let name = input('Module name: ', g:zftool_last_module)
    let g:zftool_last_module = name
  endif
  return g:zftool_last_module
endfunction!

function s:input_controller_name(last)
  if !a:last
    let name = input('Controller name: ')
    let g:zftool_last_controller = name
  endif
  return g:zftool_last_controller
endfunction!

function s:input_path(last)
  if !a:last
    if !exists('g:zftool_last_path')
      let g:zftool_last_path = getcwd()
    endif
    return input('Path: ', g:zftool_last_path)
  endif
  return g:zftool_last_path
endfunction!
" }}}
" Interface {{{
function! ZFcreateProject(last)
  let g:zftool_last_command = "ZFcreateModule"
  let name = input("Project name: ")
  let path = s:input_path(a:last)
  let cmd = "zf.php create project " . name . " " . path
  call RunWithVimux(cmd)
endfunction

function! ZFcreateModule(last)
  let g:zftool_last_command = "ZFcreateModule"
  let name = s:input_module_name(0)
  let path = s:input_path(a:last)
  let cmd = "zf.php create module " . name . " " . path
  call RunWithVimux(cmd)
endfunction

function ZFcreateController(last)
  let g:zftool_last_command = "ZFcreateController"
  let name = s:input_controller_name(0)
  let module = s:input_module_name(a:last)
  let path = s:input_path(a:last)
  let cmd = "zf.php create controller " . name . " " . module . " " . path
  call RunWithVimux(cmd)
endfunction!

function ZFcreateAction(last)
  let g:zftool_last_command = "ZFcreateAction"
  let name = input("Action name: ")
  let controller = s:input_controller_name(a:last)
  let module = s:input_module_name(a:last)
  let path = s:input_path(a:last)
  let cmd = "zf.php create action " . name . " " . module . " " . path
  call RunWithVimux(cmd)
endfunction!

function ZFrepeat()
  exec(g:zftool_last_command + "(1)")
endfunction!
" }}}
" Commands {{{
command! ZFnewModule call ZFcreateModule(0)
command! ZFnewController call ZFcreateController(0)
command! ZFnewAction call ZFcreateAction(0)
command! ZFrepeat call ZFrepeat(1)
" }}}
