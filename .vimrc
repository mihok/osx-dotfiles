set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim


call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" THEMES
"
" Theme Ayu
Plugin 'ayu-theme/ayu-vim'

" Theme Monokai-Phoenix
Plugin 'reewr/vim-monokai-phoenix'


" LANGUAGES

" JavaScript                                                                   
Plugin 'pangloss/vim-javascript'
Plugin 'mustache/vim-mustache-handlebars' " handlebars
Plugin 'mxw/vim-jsx' " jsx

" Dockerfile
Plugin 'ekalinin/Dockerfile.vim'

" PHP
Plugin 'StanAngeloff/php.vim'

" Markdown
Plugin 'plasticboy/vim-markdown'

" Go
Plugin 'fatih/vim-go'


" UI 
"
" Bottom line
Plugin 'itchyny/lightline.vim'
Plugin 'taohex/lightline-buffer' " buffer bar

" Syntax checker
Plugin 'vim-syntastic/syntastic'

" Autocomplete
Plugin 'Shougo/neocomplete.vim'

" File browser
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

" Save views
Plugin 'vim-scripts/restore_view.vim'


" OTHER
"
" Git
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'


call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on



" Settings
set encoding=utf8       " UTF-8
set guifont=Meslo\ LG\ M\ DZ\ Regular\ for\ Powerline\ Nerd\ Font\ Complete\ Mono\ 13
set hidden              " hidden buffers
set number              " line numbers
set numberwidth=6       " line number width
set cpoptions+=n	" dont increase line numbers when wrapping text?
set colorcolumn=80      " 80 column width indicator
set foldmethod=syntax   " set folding based on syntax
set hlsearch            " highlight search
set shiftwidth=2        " size of an indent
set expandtab           " use spaces for tabs 
"set fillchars=vert:\│   " solid line slipt between buffers
set showtabline=2	" always show tabline

" Buffer
nnoremap <Left> :bprev<CR>
nnoremap <Right> :bnext<CR>


" Code Folding
set foldlevelstart=0

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

" "Focus" the current line.  Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a little bit (15 lines) above the center of the screen.
" 4. Pulse the cursor line.  My eyes are bad.
"
" This mapping wipes out the z mark, which I never use.
"
" I use :sus for the rare times I want to actually background Vim.
nnoremap <c-z> mzzMzvzz15<c-e>`z:Pulse<cr>

function! MyFoldText()
    let firstline = getline(v:foldstart)
    let lastline = getline(v:foldend)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('        ', 0, &tabstop)
    let firstline = substitute(firstline, '\t', onetab, 'g')
    let lastline = substitute(lastline, '^\s*', '', 'g')

    let firstline = strpart(firstline, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(firstline) - len(foldedlinecount)
    return firstline . ' ... ' . lastline . ' (' . foldedlinecount . ' lines) ' . repeat(" ",fillcharcount) . ' '
endfunction

set foldtext=MyFoldText()


" DevIcons
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

" NERDTree
"let g:NERDTreeDisableFileExtensionHighlight = 1
"let g:NERDTreeDisableExactMatchHighlight = 1
"let g:NERDTreeDisablePatternMatchHighlight = 1

"let g:NERDTreeHighlightFolders = 1                  " enables folder icon highlighting using exact match
"let g:NERDTreeHighlightFoldersFullName = 1          " highlights the folder name

let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeSyntaxEnabledExtensions = ['js', 'jsx', 'json', 'py', 'go', 'cs', 'php', 'html']

let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" Lightline
set laststatus=2        " status bar (Lightline setting)
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], 
      \              [ 'percent' ], 
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ],
      \ },
      \ 'tabline': {
      \   'left': [ [ 'bufferinfo' ], [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
      \   'right': [ [ 'close' ], ],
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'bufferbefore': 'lightline#buffer#bufferbefore',
      \   'bufferafter': 'lightline#buffer#bufferafter',
      \   'bufferinfo': 'lightline#buffer#bufferinfo'
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \   'buffercurrent': 'lightline#buffer#buffercurrent2'
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \   'buffercurrent': 'tabsel'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

"      \ 'separator': { 'left': ' » ', 'right': ' « '},
"      \ 'subseparator': { 'left': ' » ', 'right': ' « '}

let g:lightline_buffer_logo = ' '
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '+'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = ' '
let g:lightline_buffer_expand_right_icon = ' '
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = ' '

" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1
let g:lightline_buffer_rotate = 0
let g:lightline_buffer_fname_mod = ':t'
let g:lightline_buffer_excludes = ['vimfiler']

let g:lightline_buffer_maxflen = 30
let g:lightline_buffer_maxfextlen = 3
let g:lightline_buffer_minflen = 16
let g:lightline_buffer_minfextlen = 3
let g:lightline_buffer_reservelen = 20

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

"function! Filetype()
"  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
"endfunction

"function! Fileformat()
"  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
"endfunction


" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.go,*.js,*.jsx call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

" Go
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"

" JavaScript
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'


" Key Mappings
map <C-n> :NERDTreeToggle<CR>
noremap <Tab>   <C-w>w
noremap <S-Tab> <C-w><C-p>

" Go
au FileType go nmap <leader>gd <Plug>(go-doc)
au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)


" Mail
function! BreakLine()
    " Only insert <br /> when we're editing mail
    if !exists('b:insertBreakLine')
        return
    endif
    :%s/^[^<--]*$/\0<br \/>/g
endfunction

augroup AutoMail
  autocmd BufWritePre * call BreakLine()
  autocmd FileType mail let b:insertBreakLine=1
augroup END


" Theme
syntax on
colorscheme monokai-phoenix
