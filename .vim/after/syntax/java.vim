" Capital identifiers
syn match javaSpecial '[A-Za-z0-9_$]\@<![A-Z_$][A-Za-z0-9_$]*' containedin=javaParenT,javaParenT1,javaParenT2

hi! link javaCommentTitle Comment
