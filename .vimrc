set nocompatible
set encoding=UTF-8
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set backspace=indent,eol,nostop
set number
set shiftwidth=4
set softtabstop=4
set expandtab
set cursorline
set undofile
set undodir=~/.vim/
set incsearch
set wildmenu
set wildmode=longest:full
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set smartcase
set history=1000
filetype on
filetype plugin on
set autoindent
set smartindent
syntax on
set foldmethod=indent
set wrapmargin=20
set wildoptions=pum
set showmatch
set foldminlines=10
set hlsearch
set relativenumber
""colorscheme gruvbox
""set background=dark
set cst
set csto=1
set so=999
set termwinkey=<C-s>
set dir=~/swaps

" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

" STATUS LINE ------------------------------------------------------------ {{{
" Clear status line when vimrc is reloaded.
"set statusline=
"
"" Status line left side.
"set statusline+=\ %{FugitiveHead(7)}\ %F\ %{mode()}\ %{ObsessionStatus('','notrack')}\ %M\ %Y\ %R
"
"" Use a divider to separate the left side from the right side.
"set statusline+=%=
"
"" Status line right side.
"set statusline+=\ %%10=%b\ Lines\=%L\ %l:%c\ %p%%
"
"" Show the status on the second to last line.
"set laststatus=2

packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('tpope/vim-obsession')
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
call minpac#add('preservim/nerdtree')
call minpac#add('tpope/vim-fugitive')
call minpac#add('ycm-core/YouCompleteMe', {'type': 'opt'})
call minpac#add('wellle/context.vim')
call minpac#add('morhetz/gruvbox')
call minpac#add('Xuyuanp/nerdtree-git-plugin')
call minpac#add('rakr/vim-one')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('enricobacis/vim-airline-clock')
call minpac#add('ctrlpvim/ctrlp.vim')
call minpac#add('yssl/QFEnter')

let g:fzf_layout = { 'down': '40%' }
augroup QFSettings
    au!
    autocmd  QuickFixCmdPre * call AddToTagStack()
augroup END
augroup helpWindow
    au!
    autocmd! FileType help wincmd L
augroup END
augroup loadLocalVimrc
    au!
    autocmd DirChanged * silent! source .vimrc
augroup END

augroup resetResetJumpListPerWindow
    au!
    autocmd WinNew * clearjumps
augroup END

"Remaps"
"CTRL-S,K available"
let mapleader = " "
nnoremap <Leader>s :CtrlPCurWD<CR>
nnoremap <C-p> :CtrlPCurFile<CR>
nnoremap <Leader>r :CtrlPRoot<CR>
let g:ctrlp_by_filename = 1
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_arg_map = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0


nnoremap <Leader>m :Maps<CR>
nnoremap <f2> :Commands<cr>
nnoremap <f3> :BCommits<cr>
nnoremap <f4> :Commits<cr>
nnoremap <f5> :ContextToggle<cr>
nnoremap w<f5> :ContextToggleWindow<cr>

nnoremap <Leader>d :NERDTreeToggle .<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

nnoremap <Leader><right> :lnext<cr>
nnoremap <Leader><space> :cnext<cr>
nnoremap <leader>q :call QuickfixToggle()<cr>
nnoremap <leader>xc :colder<cr>
nnoremap <leader>xn :cnewer<cr>
nnoremap <leader>l :call LoclistToggle()<cr>

nnoremap <leader>tt :terminal ++kill=exit ++close bash<cr><c-s>J
tnoremap <F1> <c-s>N

nnoremap \\         G
nnoremap \t         :tags<cr>
nnoremap <c-q>      :tag<cr>
nnoremap <leader>w :w<cr>
nnoremap <c-]> g<c-]>
nnoremap <c-)> ]]
nnoremap <c-(> [[
nnoremap <c-c> :nohl<cr>
nnoremap <leader>v :call ToggleList()<cr>
nnoremap <Leader>j :jumps<CR>
nnoremap <f1> :Helptags<CR>

nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>ta :tabnew<cr>: argdo tabedit<cr><cr>:tabclose<cr>
nnoremap <leader>tb :tab split<cr>
nnoremap <leader>tx :tab all<cr>
nnoremap <leader>t] :vsplit<cr><c-w>T<c-]>

nnoremap <leader>bo :let temp=@%<cr>:bufdo bdelete!<cr>:execute 'e' temp<cr>`"
nnoremap <Leader>bd :bdelete<cr>
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprev<cr>
nnoremap <leader>bv :sbnext<cr>
nnoremap <leader>bl :ls<cr>
nnoremap <Leader>bs :History<cr>
nnoremap <Leader>bb :BLines<cr>

nnoremap <leader>n :next<cr>
nnoremap <leader>p :prev<cr>
nnoremap <leader>af :first<cr>
nnoremap <leader>al :last<cr>
nnoremap <leader>at :argdo tabedit %<cr><cr>
nnoremap <leader>gf :args `git status -s \\| awk '$1 ~ /^M\\|A\\|U/ {print $2}'`<cr>
nnoremap <leader>aa :argadd %<cr>
nnoremap <leader>ad :argdele %<cr>
nnoremap <leader>al :args<cr>
nnoremap <leader>ac :%argdelete<cr>
nnoremap <leader>aw :arglocal<cr>

nnoremap <leader>wa :all<cr>
nnoremap <leader>wo :only<cr>
nnoremap <leader>wf :Windows<cr>
nnoremap <c-W><c-]> :vsplit<cr><c-]>
nnoremap <leader>ws :let g:temp_win_info=winsaveview()<cr>: let g:temp_buf_nr=bufnr()<cr><C-w>c
nnoremap <leader>wr :vsplit<cr>:execute "e" " #"..g:temp_buf_nr<cr>: call winrestview(g:temp_win_info)<cr>

inoremap {<cr> {<cr>}<Esc>O
inoremap (<cr> (<cr>)<Esc>O
inoremap [<cr> [<cr>]<Esc>O
inoremap "<cr> "<cr>"<Esc>O
inoremap '<cr> '<cr>'<Esc>O
inoremap `<cr> `<cr>`<Esc>O
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha

cnoremap w!! w !sudo tee > /dev/null %

let g:qfenter_keymap = {}
let g:qfenter_keymap.open = ['<CR>']
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']
let g:qfenter_keymap.open_keep = ['g<CR>']
let g:qfenter_keymap.vopen_keep = ['g<C-v>']
let g:qfenter_keymap.hopen_keep = ['g<C-x>']
let g:qfenter_keymap.topen_keep = ['g<C-t>']
let g:qfenter_exclude_filetypes = ['nerdtree']

set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
nnoremap <leader>cs :cs find 0 <C-R>=expand("<cword>")<CR><CR>:call GetCSQF()<CR>
"Functions calling this functions
nnoremap <leader>cc :cs find 3 <C-R>=expand("<cword>")<CR><CR>:call GetCSQF()<CR>
"Files including this file
nnoremap <leader>ci :cs find 8 %:t<CR><CR>:call GetCSQF()<CR>
"Places where symbol assigned a value
nnoremap <leader>ca :cs find 9 <C-R>=expand("<cword>")<CR><CR>:call GetCSQF()<CR>
"Functions called by a function
nnoremap <leader>cd :cs find 2 <C-R>=expand("<cword>")<CR><CR>:call GetCSQF()<CR>
"Find this string
nnoremap <leader>ct :cs find 4 <C-R>=expand("<cword>")<CR><CR>:call GetCSQF()<CR>

function! QuickfixToggle(open = "")
    if (a:open ==? 'open' || empty(filter(getwininfo(), 'v:val.quickfix')))
        let g:wid = win_getid()
        copen
        execute "normal \<c-w>J"
    else
        cclose
        call win_gotoid(g:wid)
        unlet g:wid
    endif
endfunction
function! LoclistToggle()
    if empty(filter(getwininfo(), 'v:val.loclist'))
        let g:wid = win_getid()
        lopen
        execute "normal \<c-w>J"
    else
        lclose
        call win_gotoid(g:wid)
        unlet g:wid
    endif
endfunction

function! AddToTagStack()
    let tag = expand('<cword>')
    let g:p_item = {'bufnr': bufnr(), 'from': [bufnr(), line('.'), col('.'), 0], 'tagname': tag}
    "let winid = win_getid()
    "let stack = gettagstack(winid)
    "let stack['items'] = [item]
    "call settagstack(winid, stack, 't')
endfunction

function! g:RecoverTagStack()
    let winid = win_getid()
    let stack = gettagstack(winid)
    let stack['items'] = [g:p_item]

    ""if stack['length'] == stack['curidx']
    ""    echom "length equal curidx"
    ""    let action = 'r'
    ""    let stack['items'][stack['curidx']-1] = g:p_item
    ""elseif stack['length'] > stack['curidx']
    ""    let action = 'r'
    ""    if stack['curidx'] > 1
    ""        echom "length greater curidx"
    ""        let stack['items'] = add(stack['items'][:stack['curidx']-2], g:p_item)
    ""    else
    ""        echom "length greater curidx is 1"
    ""        let stack['items'] = [g:p_item]
    ""    endif
    ""else
    ""    echom "length less curidx"
    ""    let action = 'a'
    ""    let stack['items'] = [g:p_item]
    ""endif
    ""let stack['curidx'] += 1

    call settagstack(winid, stack, 't')

endfunction

function! ToggleList()
    if (&list == 0)
        execute "set list"
    else
        execute "set nolist"
    endif
endfunction

function! GetCSQF()
    if empty(getqflist())
        echom "No results"
    else
        execute "normal \<C-o>"
        execute "normal zz"
        execute "call QuickfixToggle('open')"
    endif
endfunction

let g:NERDTreeShowHidden = 1
let g:NERDTreeGitStatusPorcelainVersion=1

" NERDTree Git Plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "M",
    \ "Staged"    : "S",
    \ "Untracked" : "U",
    \ "Renamed"   : "R",
    \ "Unmerged"  : "NM",
    \ "Deleted"   : "D",
    \ "Dirty"     : "DR",
    \ "Clean"     : "C",
    \ 'Ignored'   : "I",
    \ "Unknown"   : ""
    \ }
