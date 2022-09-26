set nocompatible
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
set showmatch
set foldminlines=10
set hlsearch
set relativenumber
set so=999

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
set statusline=

" Status line left side.
set statusline+=\ %{FugitiveHead(7)}\ %F\ %{mode()}\ %{ObsessionStatus('','notrack')}\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ %b\ %l:%c\ %p%%

" Show the status on the second to last line.
set laststatus=2

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

let g:fzf_layout = { 'down': '40%' }

augroup loadLocalVimrc
    au!
    silent autocmd DirChanged * source .vimrc
augroup END

augroup resetResetJumpListPerWindow
    au!
    autocmd WinNew * clearjumps
augroup END

"Remaps"
let mapleader = " "
nnoremap <Leader>s :Files<CR>
nnoremap <Leader>d :NERDTreeToggle .<CR>
nnoremap <Leader>f :NERDTreeFind<CR>
nnoremap <Leader>g :NERDTreeVCS<CR>
nnoremap <Leader>j :jumps<CR>
nnoremap <Leader><space> :cnext<cr>
nnoremap <Leader>bc :bdelete<cr>
nnoremap <c-W><c-]> :vsplit<cr><c-]>
nnoremap <Leader><right> :lnext<cr>
nnoremap <leader>q :call QuickfixToggle()<cr>
nnoremap <leader>l :call LoclistToggle()<cr>
nnoremap <leader>o :let temp=@%<cr>:bufdo bdelete!<cr>:execute 'e' temp<cr>`"
nnoremap <leader>tt :terminal<cr><c-w>J
nnoremap <leader>n :next<cr>
nnoremap <leader>p :prev<cr>
nnoremap <leader>af :first<cr>
nnoremap <leader>al :last<cr>
nnoremap )         ]m
nnoremap (         [m
nnoremap <leader>gf :args `git status -s \\| awk '$1 ~ /^M\\|A\\|U/ {print $2}'`<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>at :argdo tabedit %<cr><cr>
nnoremap <leader>aa :argadd %<cr>
nnoremap <leader>ad :argdele %<cr>
nnoremap <leader>aw :all<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>wo :only<cr>
nnoremap \         G
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>t] :vsplit<cr><c-]><c-w>T
noremap <c-]> g<c-]>

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
