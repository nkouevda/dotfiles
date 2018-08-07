" self
syn keyword     pythonBuiltin   self

" Built-in constants
syn keyword     pythonConstant  False True None NotImplemented Ellipsis __debug__

" String formatting
syn match       pythonEscape    "%\(([^)]*)\)\?[ #0+-]*\([0-9]\+\|\*\)\?\(\.\([0-9]\+\|\*\)\?\)\?[hlL]\?[diouxXeEfFgGcrs%]" contained

" URL encoding
syn match       pythonEscape    "%\(25\)*[0-9A-Fa-f]\{2}" contained

hi! link        pythonBuiltin   Identifier
hi! link        pythonConstant  Constant
hi! link        pythonEscape    SpecialChar
