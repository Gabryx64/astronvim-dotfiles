syn keyword todo contained TODO FIXME XXX NOTE
syn match comment "#.*$" contains=celTodo

syn keyword keywordFlow If Then Else EndI
syn keyword keywordFlow While Do EndW
syn keyword keywordIO Scan Print

syn match number '\d\+'
syn match number '[-+]\d\+'
syn match number '\d\+\.\d*'
syn match number '[-+]\d\+\.\d*'
syn match number '[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+'
syn match number '\d[[:digit:]]*[eE][\-+]\=\d\+'
syn match number '[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'
syn match number '\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'

syn region string start='"' end='"' contained
syn match op '<-'
syn match op '[+*-/]+'

syn match ident '[a-zA-Z_][a-zA-Z0-9_]*'

let b:current_syntax = "nls"

hi def link todo        Todo
hi def link comment     Comment
hi def link keywordFlow Keyword
hi def link keywordIO   Macro
hi def link number      Float
hi def link string      String
hi def link op          Operator
hi def link ident       Identifier
