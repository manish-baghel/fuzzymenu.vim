
""
" @section Introduction, intro
" {fuzzymenu}{1} is a fuzzy-finder menu for vim, built on top of {fzf}{2}. Discover vim features easily, just invoke fuzzymenu and start typing. See the fuzzymenu.vim README for more background.
"
" {1} https://github.com/laher/fuzzymenu.vim
" {2} https://github.com/junegunn/fzf
"
" See also, |fzf|

""
" Open fuzzymenu in normal mode.
nnoremap <silent> <Plug>Fzm :call fuzzymenu#Run({})<cr>
""
" Open fuzzymenu in normal mode.
xnoremap <silent> <Plug>FzmVisual :call fuzzymenu#Run({'visual':1})<cr>

""
" @setting g:fuzzymenu_auto_add
" Automatically add menu items. Note: I'll break these up in future into
" several categories
let g:fuzzymenu_auto_add = get(g:, 'fuzzymenu_auto_add', 1)

if g:fuzzymenu_auto_add

" vim-lsp mappings
if &rtp =~ 'vim-lsp'
  call fuzzymenu#AddAll({
        \ 'Go to definition': {'exec': 'LspDefinition'},
        \ 'Find references': {'exec': 'LspReferences'},
        \ 'Rename': {'exec': 'LspRename'},
        \ 'Organize imports': {'exec': 'LspCodeActionSync source.organizeImports'},
        \ 'Go to implementation': {'exec': 'LspImplementation'},
        \ 'Next error': {'exec': 'LspNextError'},
      \ },
      \ {'tags': ['lsp', 'vim-lsp']})
endif

" fuzzymenu
" git mappings
if &rtp =~ 'vim-fugitive'
  call fuzzymenu#AddAll({
        \ 'Find commit': {'exec': 'Commits'},
        \ 'Find commit in current buffer': {'exec': 'BCommits'},
        \ 'Open file': {'exec': 'GFiles'},
        \ 'Find in files': {'exec': 'GGrep'},
        \ 'Find word under cursor as filename': {'exec': 'call fuzzymenu#GitFileUnderCursor()'},
        \ 'Find word under cursor in files': {'exec': 'call fuzzymenu#GitGrepUnderCursor()'},
      \ },
      \ {'after': 'call fuzzymenu#InsertMode()', 'tags': ['git', 'fzf']})
  " this one is also tagged github
  call fuzzymenu#Add('Browse to file/selection', {'exec': 'GBrowse', 'after': 'call fuzzymenu#InsertMode()', 'tags': ['git', 'github', 'fzf']})

endif

" basic options
call fuzzymenu#Add('Set case-sensitive searches', {'exec': 'set noignorecase'})
call fuzzymenu#Add('Set case-insensitive searches', {'exec': 'set ignorecase'})
call fuzzymenu#Add('Hide line numbers', {'exec': 'set nonumber'})
call fuzzymenu#Add('Show line numbers', {'exec': 'set number'})
call fuzzymenu#Add('Hide whitespace characters', {'exec': 'set nolist'})
call fuzzymenu#Add('Show whitespace characters', {'exec': 'set list'})
call fuzzymenu#Add('Undo', {'normal': 'u'})
call fuzzymenu#Add('Redo', {'normal': "\<c-r>"})
call fuzzymenu#Add('Quit (exit) all', {'exec': 'qa'})
call fuzzymenu#Add('Quit (exit) all without saving', {'exec': 'qa!'})
call fuzzymenu#Add('Write (save) and quit (exit) all', {'exec': 'wqa'})
call fuzzymenu#Add('Write (save) current buffer', {'exec': 'w'})
call fuzzymenu#Add('Write (save) all', {'exec': 'wa'})

" common editor features
call fuzzymenu#Add('New buffer', {'exec': 'new'})
call fuzzymenu#Add('Delete buffer (close file)', {'exec': 'bd'})
call fuzzymenu#Add('Delete buffer (close file) WITHOUT saving', {'exec': 'bd!'})
call fuzzymenu#Add('Vertical split', {'exec': 'vs'})
call fuzzymenu#Add('Horizontal split', {'exec': 'sp'})
call fuzzymenu#Add('Select all', {'normal': 'ggVG'})
call fuzzymenu#Add('Find word under cursor', {'normal': '*'})
call fuzzymenu#Add('Next match', {'normal': 'n'})
call fuzzymenu#Add('Previous match', {'normal': 'n'})
call fuzzymenu#Add('Repeat (normal mode)', {'normal': '.'})
call fuzzymenu#Add('Repeat (command mode)', {'normal': '@:'})
call fuzzymenu#Add('Open file under cursor', {'normal': 'gf'})
call fuzzymenu#Add('Browse to link under cursor', {'normal': 'gx'})
"call fuzzymenu#Add('Replace next occurrence', {'feedkeys': 's///'})

" normal mode commands and motions
call fuzzymenu#AddAll({
      \ 'Yank (copy) a text object': {'exec': 'call fuzzymenu#textobjects#Run("y")'},
      \ 'Delete (cut) a text object': {'exec': 'call fuzzymenu#textobjects#Run("d")'},
      \ 'Change (cut a text object and switch to insert)': {'exec': 'call fuzzymenu#textobjects#Run("c")'},
    \ },
    \ {'after': 'call fuzzymenu#InsertMode()', 'tags': ['normal','fzf']})
call fuzzymenu#Add('Put (paste)', {'normal': 'p', 'tags': ['normal']})


""" fzf tools
call fuzzymenu#AddAll({
      \ 'Key mappings': {'exec': 'Maps'},
      \ 'Buffers (open files)': {'exec': 'Buffers'},
      \ 'Vim commands': {'exec': 'Commands'},
      \ 'Open recent file': {'exec': 'History'},
      \ 'Recent commands': {'exec': 'History:'},
      \ 'Recent searches': {'exec': 'History/'},
      \ 'Help': {'exec': 'Helptags'},
      \ 'Find in open buffers (files)': {'exec': 'Lines'},
      \ 'Find (in current buffer)': {'exec': 'BLines'},
      \ 'Open file': {'exec': 'Files'},
    \ },
    \ {'after': 'call fuzzymenu#InsertMode()', 'tags': ['fzf']})

" vim-go. (see also gothx.vim)
" NOTE: vim-go mappings won't load when loading plugins on demand (this is not a 'go'
" file so vim-go may not be loaded). Considering options ...
call fuzzymenu#AddAll({
        \ 'Run': {'exec': 'GoRun'},
        \ 'Test': {'exec': 'GoTest'},
        \ 'Keyify (specify keys in structs)': {'exec': 'GoKeyify'},
        \ 'IfErr': {'exec': 'GoIfErr'},
        \ 'Fill Struct': {'exec': 'GoFillStruct'},
        \ 'Play (launch in browser)': {'exec': 'GoPlay'},
        \ 'Alternate to/from test file': {'exec': 'GoAlternate'},
      \ },
      \ {'for': {'ft': 'go', 'rtp': 'vim-go'}, 'tags':['go','vim-go']})

""
" @section Mappings, mappings
" There are one normal-mode mapping, "<Leader><Leader>" to invoke fuzzymenu
if !hasmapto('<Plug>Fzm', 'n')
   nmap <Leader><Leader> <Plug>Fzm
endif

if !hasmapto('<Plug>Fzm', 'v')
   xmap <Leader><Leader> <Plug>FzmVisual
endif

endif

""
" @section Commands, commands
" There is a single command, @command(Fzm), to invoke fuzzymenu.

""
" Fzm invokes fuzzymenu
command -bang -nargs=0 -buffer Fzm call fuzzymenu#Run({'fullscreen': <bang>0})

""
" GGrep finds a file using git as a base dir
" GGrep runs fzf#vim#grep with git-grep. This is recommended in fzf docs
command! -bang -nargs=* GGrep
\ call fzf#vim#grep(
\   'git grep --line-number '.shellescape(<q-args>), 0,
\   fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel')[0] }), <bang>0)

