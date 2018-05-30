"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File:         ftplugin/python/pythonsense.vim
" Author:       Jeet Sukumaran
"
" Copyright:    (C) 2018 Jeet Sukumaran
"
" License:      Permission is hereby granted, free of charge, to any person obtaining
"               a copy of this software and associated documentation files (the
"               "Software"), to deal in the Software without restriction, including
"               without limitation the rights to use, copy, modify, merge, publish,
"               distribute, sublicense, and/or sell copies of the Software, and to
"               permit persons to whom the Software is furnished to do so, subject to
"               the following conditions:
"
"               The above copyright notice and this permission notice shall be included
"               in all copies or substantial portions of the Software.
"
"               THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"               OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"               MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"               IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"               CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"               TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"
"               SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"
" Credits:      - pythontextobj.vim by Nat Williams (https://github.com/natw/vim-pythontextobj)
"               - chapa.vim by Alfredo Deza (https://github.com/alfredodeza/chapa.vim)
"               - indentobj by Austin Taylor's (https://github.com/austintaylor/vim-indentobject)
"               - Python Docstring Text Objects by gfixler (https://pastebin.com/u/gfixler)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Book-Keeping Variables {{{1
let b:pythonsense_is_tab_indented = 0
" 1}}}

" Commands {{{1
command! Pywhere :call pythonsense#echo_python_location()
" }}}1
"
" Key Mappings {{{1
onoremap <buffer> <silent> <Plug>(PythonsenseOuterFunctionTextObject) :<C-u>call pythonsense#python_function_text_object(0, [line("."), line("."), col("."), col(".")])<CR>
onoremap <buffer> <silent> <Plug>(PythonsenseInnerFunctionTextObject) :<C-u>call pythonsense#python_function_text_object(1, [line("."), line("."), col("."), col(".")])<CR>
onoremap <buffer> <silent> <Plug>(PythonsenseOuterClassTextObject) :<C-u>call pythonsense#python_class_text_object(0, [line("."), line("."), col("."), col(".")])<CR>
onoremap <buffer> <silent> <Plug>(PythonsenseInnerClassTextObject) :<C-u>call pythonsense#python_class_text_object(1, [line("."), line("."), col("."), col(".")])<CR>
onoremap <buffer> <silent> <Plug>(PythonsenseOuterDocStringTextObject) :<C-u>call pythonsense#python_docstring_text_object(0)<CR>
onoremap <buffer> <silent> <Plug>(PythonsenseInnerDocStringTextObject) :<C-u>call pythonsense#python_docstring_text_object(1)<CR>
vnoremap <buffer> <silent> <Plug>(PythonsenseOuterFunctionTextObject) :<C-u>call pythonsense#python_function_text_object(0, [line("'<"), line("'>"), col("'<"), col("'>")])<CR><Esc>gv
vnoremap <buffer> <silent> <Plug>(PythonsenseInnerFunctionTextObject) :<C-u>call pythonsense#python_function_text_object(1, [line("'<"), line("'>"), col("'<"), col("'>")])<CR><Esc>gv
vnoremap <buffer> <silent> <Plug>(PythonsenseOuterClassTextObject) :<C-u>call pythonsense#python_class_text_object(0, [line("'<"), line("'>"), col("'<"), col("'>")])<CR><Esc>gv
vnoremap <buffer> <silent> <Plug>(PythonsenseInnerClassTextObject) :<C-u>call pythonsense#python_class_text_object(1, [line("'<"), line("'>"), col("'<"), col("'>")])<CR><Esc>gv
vnoremap <buffer> <silent> <Plug>(PythonsenseOuterDocStringTextObject) :<C-u>cal pythonsense#python_docstring_text_object(0)<CR>
vnoremap <buffer> <silent> <Plug>(PythonsenseInnerDocStringTextObject) :<C-u>cal pythonsense#python_docstring_text_object(1)<CR>

nnoremap <buffer> <silent> <Plug>(PythonsenseStartOfPreviousPythonClass) :<C-u>call pythonsense#move_to_python_object("class", 0, 0, "n")<CR>
vnoremap <buffer> <silent> <Plug>(PythonsenseStartOfPreviousPythonClass) :call pythonsense#move_to_python_object("class", 0, 0, "v")<CR>
onoremap <buffer> <silent> <Plug>(PythonsenseStartOfPreviousPythonClass) V:<C-u>call pythonsense#move_to_python_object("class", 0, 0, "o")<CR>

nnoremap <buffer> <silent> <Plug>(PythonsenseStartOfNextPythonClass) :<C-u>call pythonsense#move_to_python_object("class", 0, 1, "n")<CR>
vnoremap <buffer> <silent> <Plug>(PythonsenseStartOfNextPythonClass) :call pythonsense#move_to_python_object("class", 0, 1, "v")<CR>
onoremap <buffer> <silent> <Plug>(PythonsenseStartOfNextPythonClass) V:<C-u>call pythonsense#move_to_python_object("class", 0, 1, "o")<CR>

nnoremap <buffer> <silent> <Plug>(PythonsenseEndOfCurrentPythonClass) :<C-u>call pythonsense#move_to_python_object("class", 1, 1, "n")<CR>
vnoremap <buffer> <silent> <Plug>(PythonsenseEndOfCurrentPythonClass) :call pythonsense#move_to_python_object("class", 1, 1, "v")<CR>
onoremap <buffer> <silent> <Plug>(PythonsenseEndOfCurrentPythonClass) V:<C-u>call pythonsense#move_to_python_object("class", 1, 1, "o")<CR>

nnoremap <buffer> <silent> <Plug>(PythonsenseStartOfPreviousPythonFunction) :<C-u>call pythonsense#move_to_python_object("def", 0, 0, "n")<CR>
vnoremap <buffer> <silent> <Plug>(PythonsenseStartOfPreviousPythonFunction) :call pythonsense#move_to_python_object("def", 0, 0, "v")<CR>
onoremap <buffer> <silent> <Plug>(PythonsenseStartOfPreviousPythonFunction) V:<C-u>call pythonsense#move_to_python_object("def", 0, 0, "o")<CR>

nnoremap <buffer> <silent> <Plug>(PythonsenseStartOfNextPythonFunction) :<C-u>call pythonsense#move_to_python_object("def", 0, 1, "n")<CR>
vnoremap <buffer> <silent> <Plug>(PythonsenseStartOfNextPythonFunction) :call pythonsense#move_to_python_object("def", 0, 1, "v")<CR>
onoremap <buffer> <silent> <Plug>(PythonsenseStartOfNextPythonFunction) V:<C-u>call pythonsense#move_to_python_object("def", 0, 1, "o")<CR>

nnoremap <buffer> <silent> <Plug>(PythonsenseEndOfCurrentPythonFunction) :<C-u>call pythonsense#move_to_python_object("def", 1, 1, "n")<CR>
vnoremap <buffer> <silent> <Plug>(PythonsenseEndOfCurrentPythonFunction) :call pythonsense#move_to_python_object("def", 1, 1, "v")<CR>
onoremap <buffer> <silent> <Plug>(PythonsenseEndOfCurrentPythonFunction) V:<C-u>call pythonsense#move_to_python_object("def", 1, 1, "o")<CR>

nnoremap <buffer> <silent> <Plug>(PythonsensePyWhere) :Pywhere<CR>

if ! get(g:, "pythonsense_suppress_keymaps", 0)

    if !hasmapto('<Plug>PythonsenseOuterClassTextObject')
        vmap ac <Plug>(PythonsenseOuterClassTextObject)
        omap ac <Plug>(PythonsenseOuterClassTextObject)
        sunmap ac
    endif
    if !hasmapto('<Plug>PythonsenseInnerClassTextObject')
        vmap ic <Plug>(PythonsenseInnerClassTextObject)
        omap ic <Plug>(PythonsenseInnerClassTextObject)
        sunmap ic
    endif

    if !hasmapto('<Plug>PythonsenseOuterFunctionTextObject')
        vmap af <Plug>(PythonsenseOuterFunctionTextObject)
        omap af <Plug>(PythonsenseOuterFunctionTextObject)
        sunmap af
    endif
    if !hasmapto('<Plug>PythonsenseInnerFunctionTextObject')
        vmap if <Plug>(PythonsenseInnerFunctionTextObject)
        omap if <Plug>(PythonsenseInnerFunctionTextObject)
        sunmap if
    endif

    if !hasmapto('<Plug>PythonsenseOuterDocStringTextObject')
        omap ad <Plug>(PythonsenseOuterDocStringTextObject)
        vmap ad <Plug>(PythonsenseOuterDocStringTextObject)
        sunmap ad
    endif
    if !hasmapto('<Plug>PythonsenseInnerDocStringTextObject')
        omap id <Plug>(PythonsenseInnerDocStringTextObject)
        vmap id <Plug>(PythonsenseInnerDocStringTextObject)
        sunmap id
    endif

    if !hasmapto('<Plug>PythonsenseStartOfPreviousPythonClass')
        map [c <Plug>(PythonsenseStartOfPreviousPythonClass)
        sunmap [c
    endif
    if !hasmapto('<Plug>PythonsenseStartOfNextPythonClass')
        map ]c <Plug>(PythonsenseStartOfNextPythonClass)
        sunmap ]c
    endif
    if !hasmapto('<Plug>PythonsenseEndOfCurrentPythonClass')
        map ]C <Plug>(PythonsenseEndOfCurrentPythonClass)
        sunmap ]C
    endif

    if !hasmapto('<Plug>PythonsenseStartOfPreviousPythonFunction')
        map [f <Plug>(PythonsenseStartOfPreviousPythonFunction)
        sunmap [f
    endif
    if !hasmapto('<Plug>PythonsenseStartOfNextPythonFunction')
        map ]f <Plug>(PythonsenseStartOfNextPythonFunction)
        sunmap ]f
    endif
    if !hasmapto('<Plug>PythonsenseEndOfCurrentPythonFunction')
        map ]F <Plug>(PythonsenseEndOfCurrentPythonFunction)
        sunmap ]F
    endif

    if !hasmapto('<Plug>(PythonsensePyWhere)')
        map g: <Plug>(PythonsensePyWhere)
        sunmap g:
    endif

endif

" }}}1
