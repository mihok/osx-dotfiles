" =============================================================================
" Filename: autoload/lightline/colorscheme/seoul256.vim
" Author: atweiden
" License: MIT License
" Last Change: 2022/03/15 23:58:59.
" =============================================================================

let s:base03 = [ '#151513', 233 ]
let s:base02 = [ '#30302c', 236 ]
let s:base01 = [ '#4e4e43', 239 ]
let s:base00 = [ '#666656', 242  ]
let s:base0 = [ '#808070', 244 ]
let s:base1 = [ '#949484', 246 ]
let s:base2 = [ '#a8a897', 248 ]
let s:base3 = [ '#e8e8d3', 253 ]
let s:yellow = [ '#d8af5f', 3 ]
let s:orange = [ '#d7875f', 216 ]
let s:red = [ '#d68787', 131 ]
let s:magenta = [ '#df5f87', 168 ]
let s:peach = [ '#d7afaf', 181 ]
let s:blue = [ '#1693A5', 14 ] " 109
let s:cyan = [ '#87d7d7', 23 ]
let s:green = [ '#FBB829', 220 ]
let s:white = [ '#d0d0d0', 252 ]
let s:ultrawhite = [ '#FFFFFF', 15 ]

let s:tabhl = [ '#FF0066', 197 ]
let s:tabbg = [ '#333333', 234 ]
let s:tabselbg = [ '#D7D7AF', 236 ]
let s:tabselfg = [ '#111111', 231 ]
let s:tabinactive = [ '#777777', 102 ]

let s:mihoksystems = [ '#782A3A', 88 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:base02, s:blue ], [ s:base3, s:base01 ] ]
let s:p.normal.right = [ [ s:base02, s:base1 ], [ s:base2, s:base01 ] ]
let s:p.inactive.right = [ [ s:base02, s:base00 ], [ s:base0, s:base02 ] ]
let s:p.inactive.left =  [ [ s:base0, s:base02 ], [ s:base00, s:base02 ] ]
let s:p.insert.left = [ [ s:base02, s:green ], [ s:base3, s:base01 ] ]
let s:p.replace.left = [ [ s:base02, s:white ], [ s:base3, s:base01 ] ]
let s:p.visual.left = [ [ s:base02, s:tabhl ], [ s:base3, s:base01 ] ]
let s:p.normal.middle = [ [ s:base0, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base00, s:base02 ] ]
let s:p.tabline.left = [ [ s:ultrawhite, s:tabhl ] ]
let s:p.tabline.tabsel = [ [ s:tabselfg, s:tabselbg ] ]
let s:p.tabline.middle = [ [ s:tabinactive, s:tabbg ] ]
" let s:p.tabline.right = copy(s:p.normal.right)
let s:p.tabline.right = [ [ s:tabbg, s:tabbg ] ]
let s:p.normal.error = [ [ s:red, s:base02 ] ]
let s:p.normal.warning = [ [ s:yellow, s:base01 ] ]

let g:lightline#colorscheme#seoul256#palette = lightline#colorscheme#flatten(s:p)
