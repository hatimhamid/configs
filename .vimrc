set nocompatible
set encoding=UTF-8
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set backspace=indent,eol,nostop
set number
set nowrap
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
"set wrapmargin=20
set wildoptions=pum
set showmatch
set foldminlines=10
set hlsearch
set relativenumber
colorscheme one
set background=light
set cst
set csto=1
set so=999
set termwinkey=<C-x>

" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).

if &term =~ "screen."
    let &t_SI.="\eP\e[5 q\e\\"
    let &t_EI.="\eP\e[1 q\e\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[1 q"
endif
    

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
"call minpac#add('ycm-core/YouCompleteMe', {'type': 'opt'})
call minpac#add('wellle/context.vim')
call minpac#add('morhetz/gruvbox')
call minpac#add('Xuyuanp/nerdtree-git-plugin')
call minpac#add('rakr/vim-one')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('enricobacis/vim-airline-clock')
call minpac#add('ctrlpvim/ctrlp.vim')
call minpac#add('hatimhamid/QFEnter')
call minpac#add('preservim/tagbar')

augroup QFSettings
    au!
    autocmd  QuickFixCmdPre * call AddToTagStack2()
augroup END
augroup helpWindow
    au!
    autocmd! FileType help wincmd L
augroup END
augroup loadLocalVimrc
    au!
    autocmd WinEnter * silent! execute 'source'. getcwd() . '/.vimrc_wd' | set path& | execute "set path+="..getcwd().."/**"
    autocmd DirChanged * silent! source .vimrc_wd | set path& | execute "set path+="..getcwd().."/**"
augroup END

augroup VIMPROVEMENT
  autocmd!
  " Reload my vimrc everytime I save it.
  autocmd BufWritePost ~/.vimrc source ~/.vimrc
augroup END

augroup resetResetJumpListPerWindow
    au!
    autocmd WinNew * clearjumps
augroup END
augroup previewWindowSettings
  "au! CursorHold *.[ch] ++nested call PreviewWord()
augroup END

let g:fzf_layout = { 'down': '40%' }
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

let Tlist_Show_One_File = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_WinWidth = 40
nnoremap <silent> <F6> :TagbarToggle f<CR>
nnoremap <silent> <F7> :TagbarTogglePause<CR>

""g:ycm_auto_trigger = 1
""imap <silent> <leader>yh <Plug>(YCMToggleSignatureHelp)

nnoremap <Leader>m :Maps<CR>
nnoremap <f2> :Commands<cr>
nnoremap <f3> :BCommits<cr>
nnoremap <f4> :Commits<cr>
nnoremap <f5> :ContextToggle<cr>
nnoremap <leader><f5> :ContextToggleWindow<cr>

nnoremap <Leader>d :NERDTreeToggle .<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

nnoremap <Leader><right> :lnext<cr>
nnoremap <Leader>x :cnext<cr>
nnoremap <leader>q :call QuickfixToggle()<cr>
nnoremap <leader>xc :colder<cr>
nnoremap <leader>xn :cnewer<cr>
nnoremap <leader>xh :chistory<cr>
nnoremap <leader>xf :call setqflist([], 'f')<cr>
nnoremap <leader>zc :lolder<cr>
nnoremap <leader>zn :lnewer<cr>
nnoremap <leader>zh :lhistory<cr>
nnoremap <leader>zf :call setloclist([], 'f')<cr>
nnoremap <leader>ll :call LoclistToggle()<cr>

nnoremap <leader>tt :terminal ++kill=exit ++close bash<cr><c-x>J
tnoremap <F1> <c-x>N

nnoremap \\         G
nnoremap \r         :call ResetTagStack()<cr>
nnoremap \t         :tags<cr>
nnoremap <c-q>      :tag<cr>
nnoremap <leader><space> :w<cr>
nnoremap <c-]> g<c-]>
nnoremap <c-)> ]]
nnoremap <c-(> [[
nnoremap <c-c> :nohl<cr>
nnoremap <leader>v :call ToggleList()<cr>
nnoremap <Leader>j :jumps<CR>
nnoremap <f1> :Helptags<CR>

nnoremap tt g<tab>
tnoremap tt g<tab>
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
nnoremap <leader>au :argdedupe<cr>
nnoremap <leader>ag :argument<cr>
nnoremap <leader>at :argdo tabedit %<cr><cr>
nnoremap <leader>gf :argadd `git status -s \\| awk '$1 ~ /^M\\|A\\|U/ {print $2}'`<cr>
nnoremap <leader>aa :argadd %<cr>
nnoremap <leader>ad :argdele %<cr>
nnoremap <leader>al :args<cr>
nnoremap <leader>ac :%argdelete<cr>
nnoremap <leader>aw :arglocal<cr>
nnoremap <leader>ak :argglobal<cr>

nnoremap <leader>wa :all<cr>
nnoremap <leader>wo :only<cr>
nnoremap <leader>wf :Windows<cr>
nnoremap <c-W><c-]> :vsplit<cr><c-]>
nnoremap <leader>ws :let g:temp_win_info=winsaveview()<cr>: let g:temp_buf_nr=bufnr()<cr><C-w>c
nnoremap <leader>wr :vsplit<cr>:execute "e" " #"..g:temp_buf_nr<cr>: call winrestview(g:temp_win_info)<cr>
nnoremap <leader>wx :split<cr>:execute "e" " #"..g:temp_buf_nr<cr>: call winrestview(g:temp_win_info)<cr>

"nnoremap <c-W>} :exe "ptag " .. expand("<cword>")<cr>:call getchar()<cr>:wincmd P<cr>:normal zr<cr>:wincmd p
nnoremap <c-W>} :call PreviewWord2()<cr>

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
let g:qfenter_exclude_filetypes = ['nerdtree', 'taglist']

nnoremap <leader>o :set isfname-=/<cr>:normal gf<cr> :set isfname+=/<cr>
"nnoremap <leader>o :exe "e " expand("<cfile>:t")<cr>
nnoremap <leader>le :exec "lgrep --exclude=tags --exclude=cscope.* -rI \""..expand("<cWORD>").."\" "..getcwd()<cr> :call GetCSQF('ll')<cr>
nnoremap <leader>ce :exec "grep --exclude=tags --exclude=cscope.* -rI \""..expand("<cWORD>").."\" "..getcwd()<cr> :call GetCSQF('qf')<cr>
nnoremap <leader>lw :exec "lgrep --exclude=tags --exclude=cscope.* -rI "..expand("<cword>").." "..getcwd()<cr> :call GetCSQF('ll')<cr>
nnoremap <leader>cw :exec "grep --exclude=tags --exclude=cscope.* -rI "..expand("<cword>").." "..getcwd()<cr> :call GetCSQF('qf')<cr>
nnoremap <leader>lq :set iskeyword-=_ <cr> :let sw = expand("<cword>") <cr>:set iskeyword+=_<cr>:exec "lgrep --exclude=tags --exclude=cscope -rI "..sw.." "..getcwd()<cr> :call GetCSQF('ll')<cr>
nnoremap <leader>cq :set iskeyword-=_ <cr>:let sw = expand("<cword>")<cr>:set iskeyword+=_<cr>:exec "grep --exclude=tags --exclude=cscope -rI "..sw.." "..getcwd()<cr> :call GetCSQF('qf')<cr>
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
nnoremap <leader>cs :cs find s <C-R>=expand("<cword>")<CR><CR>:call GetCSQF('qf')<CR>
"Functions calling this functions
nnoremap <leader>cc :cs find c <C-R>=expand("<cword>")<CR><CR>:call GetCSQF('qf')<CR>
"Files including this file
nnoremap <leader>ci :cs find i %:t<CR><CR>:call GetCSQF('qf')<CR>
"Places where symbol assigned a value
nnoremap <leader>ca :cs find a <C-R>=expand("<cword>")<CR><CR>:call GetCSQF('qf')<CR>
"Functions called by a function
nnoremap <leader>cd :cs find d <C-R>=expand("<cword>")<CR><CR>:call GetCSQF('qf')<CR>
"Find this string
nnoremap <leader>ct :cs find t <C-R>=expand("<cword>")<CR><CR>:call GetCSQF('qf')<CR>
"Find global definition
nnoremap <leader>cg :cs find g <C-R>=expand("<cword>")<CR><CR>:call GetCSQF('qf')<CR>

nnoremap <leader>ls :lcs find s <C-R>=expand("<cword>")<CR><CR>:call GetCSQF('ll')<CR>
"Functions calling this functions
nnoremap <leader>lc :lcs find c <C-R>=expand("<cword>")<CR><CR>:call GetCSQF('ll')<CR>
"Files including this file
nnoremap <leader>li :lcs find i %:t<CR><CR>:call GetCSQF('ll')<CR>
"Places where symbol assigned a value
nnoremap <leader>la :lcs find a <C-R>=expand("<cword>")<CR><CR>:call GetCSQF('ll')<CR>
"Functions called by a function
nnoremap <leader>ld :lcs find d <C-R>=expand("<cword>")<CR><CR>:call GetCSQF('ll')<CR>
"Find this string
nnoremap <leader>lt :lcs find t <C-R>=expand("<cword>")<CR><CR>:call GetCSQF('ll')<CR>
"Find global definition
nnoremap <leader>lg :lcs find g <C-R>=expand("<cword>")<CR><CR>:call GetCSQF('ll')<CR>

function! IsLLOpen(locdict)
    if (1 == a:locdict.loclist && tabpagenr() == a:locdict.tabnr)
        return 1
    endif
    return 0
endfunction
function! IsQFOpen(locdict)
    if (1 != a:locdict.loclist && 1 == a:locdict.quickfix && tabpagenr() == a:locdict.tabnr)
        return 1
    endif
    return 0
endfunction
function! QuickfixToggle(open = "")
    if (a:open ==? 'open' || empty(filter(getwininfo(), 'IsQFOpen(v:val)')))
        "let g:wid = win_getid()
        copen
        execute "normal \<c-w>J"
    else
        cclose
        "call win_gotoid(g:wid)
        "unlet g:wid
    endif
endfunction
function! LoclistToggle(open = "")
    if (a:open ==? 'open' || empty(filter(getwininfo(), 'IsLLOpen(v:val)')))
        "let g:wid = win_getid()
        lopen
        execute "normal \<c-w>J"
    else
        lclose
        "call win_gotoid(g:wid)
        "unlet g:wid
    endif
endfunction

function! AddToTagStack2()
    let tag = expand('<cword>')
    let pos = [bufnr()] + getcurpos()[1:]
    let g:item = {'bufnr': pos[0], 'from': pos, 'tagname': tag}
    let g:winid = win_getid()
endfunction

function! g:RecoverTagStack2()
    " Jump was successful, write previous location to tag stack.
    let stack = gettagstack(win_getid())
    let stack['items'] = [g:item]
    call settagstack(win_getid(), stack, 't')
endfunction

function! AddToTagStack()
    silent! if exists(g:p_item)
        unlet g:p_item
    endif
    let tag = expand('<cword>')
    let g:p_item = {'bufnr': bufnr(), 'from': [bufnr(), line('.'), col('.'), 0], 'tagname': tag}
    let winid = win_getid()

    let stack = gettagstack(winid)

    if stack['length'] == stack['curidx']
        let action = 'r'
        let stack['items'][stack['curidx']-1] = g:p_item
    elseif stack['length'] > stack['curidx']
        let action = 'r'
        if stack['curidx'] > 1
            let stack['items'] = add(stack['items'][:stack['curidx']-2], g:p_item)
        else
            let stack['items'] = [g:p_item]
        endif
    else
        let action = 'a'
        let stack['items'] = add(stack['items'], g:p_item)
    endif
    let stack['length'] = len(stack['items'])
    let g:p_item = stack
endfunction

function! g:RecoverTagStack()
    let winid = win_getid()
    
    ""let g:p_item['items'][g:p_item['length'] - 1]['bufnr'] = bufnr()

    call settagstack(winid, g:p_item, 'r')

endfunction

function! ResetTagStack()
    call settagstack(win_getid(), {'items' :[]}, 'r')
endfunction

function! ToggleList()
    if (&list == 0)
        execute "set list"
    else
        execute "set nolist"
    endif
endfunction

function! GetCSQF(type)
    if (a:type ==? 'qf')
        if empty(getqflist())
            echom "No results"
        else
            execute "normal \<C-o>"
            execute "normal zz"
            execute "call QuickfixToggle('open')"
        endif
    elseif (a:type ==? 'll')
        if empty(getloclist(0))
            echom "No results"
        else
            execute "normal \<C-o>"
            execute "normal zz"
            execute "call LoclistToggle('open')"
        endif

    endif
endfunction

function! PreviewWord2()
    if &previewwindow			" don't do this in the preview window
      return
    endif
    let w = expand("<cword>")		" get the word under cursor
    if w =~ '\a'			" if the word contains a letter

      " Delete any existing highlight before showing another tag
      silent! wincmd P			" jump to preview window
      if &previewwindow		" if we really get there...
        match none			" delete existing highlight
        wincmd p			" back to old window
      endif

      " Try displaying a matching tag for the word under the cursor
      try
         exe "ptag " .. w
      catch
        return
      endtry

      silent! wincmd P			" jump to preview window
      if &previewwindow		" if we really get there...
         if has("folding")
           silent! normal zr
         endif
        wincmd p			" back to old window
      endif
    endif
endfun
function! PreviewWord()
    if &previewwindow			" don't do this in the preview window
      return
    endif
    let w = expand("<cword>")		" get the word under cursor
    if w =~ '\a'			" if the word contains a letter

      " Delete any existing highlight before showing another tag
      silent! wincmd P			" jump to preview window
      if &previewwindow		" if we really get there...
        match none			" delete existing highlight
        wincmd p			" back to old window
      endif

      " Try displaying a matching tag for the word under the cursor
      try
         exe "ptag " .. w
      catch
        return
      endtry

      silent! wincmd P			" jump to preview window
      if &previewwindow		" if we really get there...
         if has("folding")
           silent! .foldopen		" don't want a closed fold
         endif
         call search("$", "b")		" to end of previous line
         let w = substitute(w, '\\', '\\\\', "")
         call search('\<\V' .. w .. '\>')	" position cursor on match
         " Add a match highlight to the word at this position
        hi previewWord term=bold ctermbg=green guibg=green
         exe 'match previewWord "\%' .. line(".") .. 'l\%' .. col(".") .. 'c\k*"'
        wincmd p			" back to old window
      endif
    endif
endfun
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
