" Vim syntax file
" Language: Jade
" Maintainer: Joshua Borton
" Credits: Tim Pope
" Filenames: *.jade

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'jade'
endif

runtime! syntax/html.vim
unlet! b:current_syntax

syn case match

syn region jadeJavascript matchgroup=jadeJavascriptOutputChar start="[!&]\==\|\~" skip=",\s*$" end="$" contained contains=@htmlJavaScript keepend
syn region jadeJavascript matchgroup=jadeJavascriptChar start="-" skip=",\s*$" end="$" contained contains=@htmlJavaScript keepend
syn cluster jadeTop contains=jadeBegin,jadeComment,jadeHtmlComment
syn match   jadeBegin "^\s*\%([<>]\|&[^=~ ]\)\@!" nextgroup=jadeTag,jadeClassChar,jadeIdChar,jadePlainChar,jadeJavascript
syn match   jadeTag "\w\+\%(:\w\+\)\=" contained contains=htmlTagName,htmlSpecialTagName nextgroup=@jadeComponent
syn cluster jadeComponent contains=jadeAttributes,jadeIdChar,jadeBlockExpansionChar,jadeClassChar,jadePlainChar,jadeJavascript
syn match   jadeComment ' *\/\/.*$'
syn region  jadeHtmlComment start="^\z(\s*\)/"  end="^\%(\z1 \| *$\)\@!"
syn region  jadeAttributes matchgroup=jadeAttributesDelimiter start="(" skip=+\%(\\\\\)*\\'+ end=")" contained contains=jadeHtmlArg,htmlArg,jadeAttributeString,htmlEvent,htmlCssDefinition nextgroup=@jadeComponent
syn match   jadeClassChar "\." contained nextgroup=jadeClass
syn match   jadeBlockExpansionChar ":\s" contained nextgroup=jadeTag
syn match   jadeIdChar "#{\@!" contained nextgroup=jadeId
syn match   jadeClass "\%(\w\|-\)\+" contained nextgroup=@jadeComponent
syn match   jadeId "\%(\w\|-\)\+" contained nextgroup=@jadeComponent
syn region  jadeDocType start="^\s*!!!" end="$"
" Unless I'm mistaken, syntax/html.vim requires
" that the = sign be present for these matches.
" This adds the matches back for jade.
syn keyword jadeHtmlArg contained href title

syn match   jadePlainChar "\\" contained
syn region  jadeInterpolation matchgroup=jadeInterpolationDelimiter start="#{" end="}" contains=@htmlJavaScript
syn match   jadeInterpolationEscape "\\\@<!\%(\\\\\)*\\\%(\\\ze#{\|#\ze{\)"

syn region  jadeAttributeString start=+\%(=\s*\)\@<='+ skip=+\%(\\\\\)*\\'+ end=+'+ contains=jadeInterpolation
syn region  jadeAttributeString start=+\%(:\s*\)\@<='+ skip=+\%(\\\\\)*\\'+ end=+'+ contains=jadeInterpolation
syn region  jadeAttributeString start=+\%(=\s*\)\@<="+ skip=+\%(\\\\\)*\\'+ end=+"+ contains=jadeInterpolation
syn region  jadeAttributeString start=+\%(:\s*\)\@<="+ skip=+\%(\\\\\)*\\'+ end=+"+ contains=jadeInterpolation

syn region  jadeJavascriptFilter matchgroup=jadeFilter start="^\z(\s*\):javascript\s*$" end="^\%(\z1 \| *$\)\@!" contains=@htmlJavaScript
syn region  jadeMarkdownFilter matchgroup=jadeFilter start="^\z(\s*\):markdown\s*$" end="^\%(\z1 \| *$\)\@!"

syn region  jadeJavascriptBlock start="^\z(\s*\)script" nextgroup=@jadeComponent,jadeError end="^\%(\z1 \| *$\)\@!" contains=@jadeTop,@htmlJavascript keepend
syn region  jadeCssBlock        start="^\z(\s*\)style" nextgroup=@jadeComponent,jadeError  end="^\%(\z1 \| *$\)\@!" contains=@jadeTop,@htmlCss keepend

syn match  jadeError "\$" contained

hi def link jadeTag                    Special
hi def link jadeHtmlArg                htmlArg
hi def link jadeAttributeString        String
hi def link jadeAttributesDelimiter    Identifier
hi def link jadeIdChar                 Special
hi def link jadeClassChar              Special
hi def link jadeBlockExpansionChar     Special
hi def link jadeId                     Identifier
hi def link jadeClass                  Type
hi def link jadeInterpolationDelimiter Delimiter
hi def link jadeFilter                 PreProc
hi def link jadeDocType                PreProc
hi def link jadeComment                Comment
hi def link jadeHtmlComment            jadeComment

let b:current_syntax = "jade"

if main_syntax == "jade"
  unlet main_syntax
endif
