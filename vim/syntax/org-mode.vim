" Vim syntax file
" Language: Org mode
" Maintainer: Simon Watts
" Latest Revision: 28/05/20

if exists("b:current_syntax")
    finish
endif

" ---- Syntax definitions ----

" Keywords
" syn keyword synElemKeyword keyword1 keyword2

" Matches
" syn match synElemMatch 'regexp'

" Regions
" syn region synElemRegion start='x' end='y'

syn match orgH1 '^\*\{1\}\s.*'
syn match orgH2 '^\*\{2\}\s.*'
syn match orgH3 '^\*\{3\}\s.*'
syn match orgH4 '^\*\{4\}\s.*'
syn match orgH5 '^\*\{5\}\s.*'
syn match orgH6 '^\*\{6\}\s.*'
syn match orgH7 '^\*\{7\}\s.*'
syn match orgH8 '^\*\{8\}\s.*'
syn match orgH9 '^\*\{9\}\**\s.*'

syn match orgMeta '^#+.*'

syn match orgBullet '^\s*-'
syn match orgBullet '^\s*+'

syn match orgTable '^\s*|.*|\s*$'

syn region orgVerbatim start='=' end='=' oneline
"syn match orgVerbatim '=.*='
syn region orgCode start='\~' end='\~' oneline

syn match orgCheckboxEmpty '\[\s\]'
syn match orgCheckboxPartial '\[-\]'
syn match orgCheckboxComplete '\[X\]'

syn keyword orgTodo TODO

" ---- Highlight scheme definitions ----

let b:current_syntax = "org-mode"

hi def link orgH1 Title
hi def link orgH2 PreProc
hi def link orgH3 Type
hi def link orgH4 Statement
hi def link orgH5 Constant
hi def link orgH6 String
hi def link orgH7 Function
hi def link orgH8 Special
hi def link orgH9 StorageClass
" or 

hi def link orgMeta     Comment

"hi def link orgBullet   Constant
hi def link orgBullet   Statement
"hi def link orgBullet   Type

hi def link orgTable    String

hi def link orgVerbatim Identifier

"hi def link orgCode     Type
"hi def link orgCode     Identifier
" Only jellybeans really uses this?
hi def link orgCode     Statement
"hi def link orgCode     Special

" Or switch these top 2
hi def link orgCheckboxEmpty        Constant
hi def link orgCheckboxPartial      Type
hi def link orgCheckboxComplete     String

hi def link orgTodo TODO

