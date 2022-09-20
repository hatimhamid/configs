set nocompatible
set number
set shiftwidth=4
set softtabstop=4
set expandtab
set cursorline
set undofile
set undodir=~/.vim/
set incsearch
set smartindent
set wildmenu
set wildmode=longest:full
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set smartcase
set history=1000
filetype on
filetype plugin on
set autoindent
syntax on
set foldmethod=indent
set wrapmargin=20
set showmatch
silent autocmd DirChanged * source .vimrc
set foldminlines=10
set hlsearch
set relativenumber

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


let g:fzf_layout = { 'down': '40%' }

"Remaps"
let mapleader = " "
nnoremap <Leader>s :Files<CR>
nnoremap <Leader>d :NERDTreeToggle .<CR>
nnoremap <Leader>f :NERDTreeFind<CR>
nnoremap <Leader>g :NERDTreeVCS<CR>
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
nnoremap )         ]m
nnoremap (         [m
nnoremap <leader>gf :args `git status -s \\| awk '$1 ~ /^M\\|A\\|U/ {print $2}'`<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>at :argdo tabedit %<cr><cr>
nnoremap <leader>aw :all<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>wo :only<cr>
nnoremap \         G
nnoremap <leader>tc :tabclose<cr>
noremap j <cr>
noremap k -
noremap <c-]> g<c-]>


set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
nnoremap <leader>cc :cs find 0 <C-R>=expand("<cword>")<CR><CR>
"Functions calling this functions
nnoremap <leader>cf :cs find 3 <C-R>=expand("<cword>")<CR><CR>
"Files including this file
nnoremap <leader>ci :cs find 8 %:t<CR><CR>
"Places where symbol assigned a value
nnoremap <leader>cv :cs find 9 <C-R>=expand("<cword>")<CR><CR>
"Functions called by a function
nnoremap <leader>ca :cs find 2 <C-R>=expand("<cword>")<CR><CR>
"Find this string
nnoremap <leader>cs :cs find 4 <C-R>=expand("<cword>")<CR><CR>


function! QuickfixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
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
endfunction
