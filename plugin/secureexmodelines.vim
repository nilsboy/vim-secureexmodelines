" A secure alternative to modelines that executes any predefined ex command
" Author: Ciaran McCreesh <ciaranm@ciaranm.org> and nilsboy

if &compatible || v:version < 700
    finish
endif

if (! exists("g:secure_exmodelines_allowed_items"))
    let g:secure_exmodelines_allowed_items = []
endif

if (! exists("g:secure_exmodelines_verbose"))
    let g:secure_exmodelines_verbose = 0
endif

fun! <SID>IsInList(i) abort
    for l:item in g:secure_exmodelines_allowed_items
        if a:i == l:item
            return 1
        endif
    endfor
    return 0
endfun

fun! <SID>DoModeline(line) abort
    let l:matches = matchlist(a:line, '\v\svimex:\s([a-zA-Z0-9_=-]+)\s([a-zA-Z0-9_=-]+)')
    if len(l:matches) == 0
        return
    endif

    let l:command = l:matches[1]
    let l:argument = l:matches[2]

    if <SID>IsInList(l:command)
        if g:secure_exmodelines_verbose
            echo "SecureExModeLines - running: " . l:command . " " . l:argument
        endif
        exec l:command . " " . l:argument
    elseif g:secure_exmodelines_verbose
        echohl WarningMsg
        echomsg "Ignoring '" . l:command . "' in exmodeline"
        echohl None
    endif

endfun

fun! <SID>DoModelines() abort
    call <SID>DoModeline(getline(1))
endfun

aug SecureExModeLines
    au!
    au BufRead * :call <SID>DoModelines()
aug END

