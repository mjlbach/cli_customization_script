call plug#begin($HOME.'/.neovim/plugged')

Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'lervag/vimtex'
Plug 'mhinz/neovim-remote'
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'
Plug 'jpalardy/vim-slime'
Plug 'edkolev/tmuxline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector'

call plug#end()

"Allow filetype plugins and syntax highlighting 
set autoindent
filetype plugin indent on
syntax on

"Change backspace to behave more intuitively
set backspace=indent,eol,start

"Set tab options for vim
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

"Set highlight on search
set nohlsearch
set incsearch

"Make line numbers default
set number

"Do not save when switching buffers
set hidden

"Enable mouse mode
set mouse=a

"Enable break indent
set breakindent

"Set show command
set showcmd

"Keep swap and undo files in same location
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set undodir=$HOME/.vim/undo//
set undofile

"Remove backups for coc
set nobackup
set nowritebackup

"Case insensitive searching UNLESS /C or capital in search
set ignorecase
set smartcase

" set Vim-specific sequences for RGB colors
if exists('$TMUX')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" CocCurrentFunction
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

"Set colorscheme
colorscheme onedark 
set termguicolors
" set background=dark
" let g:gruvbox_sign_column='bg0'
" let g:gruvbox_italic=1
let g:onedark_terminal_italics=1
let g:lightline = {
       \ 'colorscheme': 'onedark',
       \ 'active': {
       \   'left': [ [ 'mode', 'paste' ],
       \             [ 'cocstatus', 'gitbranch', 'readonly', 'filename', 'modified', 'currentfunction'] ]
       \ },
       \ 'component_function': {
       \   'gitbranch': 'fugitive#head',
       \   'cocstatus': 'coc#status',
       \   'currentfunction': 'CocCurrentFunction'
       \ },
       \ }

 
"Remap space as leader key
noremap <Space> <Nop>
let mapleader="\<Space>"

" Remap for dealing with word wrap
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

"Add move line shortcuts
nnoremap <A-k> :m .-1<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-1<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-1<CR>gv=gv
nnoremap <A-j> :m .+1<CR>==

"Remap increment keys from tmux binds

"Remap escape to leave terminal mode
"tnoremap <Esc> <C-\><C-n>

"Add map to enter paste mode
set pastetoggle=<F3>

"Allow copy and paste to clipboard
nnoremap <F10> :call ToggleMouse()<CR>

function! ToggleMouse()
  if &mouse == 'a'
    IndentLinesDisable
    set mouse=v
    set nonu
    echo "Mouse usage Visual"
  else
    IndentLinesEnable
    set mouse=a
    set nu
    echo "Mouse usage All"
  endif
endfunction

"Set no expandtab on makefile
augroup Make
  autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
augroup end

"Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

"Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"Add fzf
set rtp+=/usr/local/opt/fzf

" Add neovim remote for vimtex 
" let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_compiler_progname = $HOME.'/.virtualenvs/neovim3/bin/nvr'
let g:vimtex_compiler_progname = $HOME.'/.virtualenvs/neovim3/bin/nvr'

"Add leader shortcuts
"nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>f :ProjectFiles<CR>
nnoremap <silent> <leader><space> :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>t :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>s :Rg<CR>
nnoremap <silent> <leader>c :Commits<CR>
nnoremap <silent> <leader>b :Gbranch<CR>
nnoremap <silent> <leader>p :Projects<CR>

"Alternative shortcut without using fzf
nnoremap <leader>, :buffer *
nnoremap <leader>. :e<space>**/
nnoremap <leader>g :tjump *

" Intelligent switching of branches
function! s:gitCheckoutRef(ref) 
    execute('Git checkout ' . a:ref)
    " call feedkeys("i")
endfunction

function! s:gitListRefs()
   let l:refs = execute("Git for-each-ref --format='\\%(refname:short)'")
   return split(l:refs,'\r\n*')[1:] "jump past the first line which is the git command
endfunction

command! -bang Gbranch call fzf#run({ 'source': s:gitListRefs(), 'sink': function('s:gitCheckoutRef'), 'dir':expand('%:p:h') })

" Search project root
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

"Add preview to Rg togglable with question mark and add shellescape find git
"root for searching top level git directory
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>).' '.shellescape(s:find_git_root()), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0) 

"Add command for searching files within current git directory structure
command! ProjectFiles execute 'Files' s:find_git_root()

function! s:switch_project()
  let command = 'fd -H -t d --maxdepth 3 .git ' . $HOME . ' | sed -En "s/\/.git//p"'

  call fzf#run({
        \ 'source': command,
        \ 'sink':   'lcd',
        \ 'options': '-m -x +s',
        \ 'window':  'enew' })

endfunction

command! Projects call s:switch_project()

" Make gutentags use ripgrep
let g:gutentags_file_list_command = 'rg --files'
let g:gutentags_ctags_extra_args = ['-n', '-u']

" Configure vim slime to use tmux
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}

"Set vim dispatch filetype options
nnoremap <F9> :Dispatch<CR>
augroup Dispatch
  autocmd!
  autocmd FileType python let b:dispatch = 'flake8 $(git rev-parse --show-toplevel)/**/*.py'
  autocmd FileType cpp let b:dispatch = 'make ./build'
  autocmd FileType rust let b:dispatch = 'rustc %'
augroup end 

augroup Python
  autocmd FileType python setlocal makeprg=flake8
augroup end 
"Change preview window location
set splitbelow

"Remap number increment to alt
nnoremap <A-a> <C-a>
vnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>
vnoremap <A-x> <C-x>

"n always goes forward
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]

nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

"Neovim python support
let g:python3_host_prog=$HOME.'/.virtualenvs/neovim3/bin/python'
let g:python_host_prog=$HOME.'/.virtualenvs/neovim2/bin/python'

" Use jq to format json files on gqq
augroup JSON 
  autocmd!
  autocmd FileType json setlocal formatprg=jq\ .
augroup end

" Clear white space on empty lines and end of line
nnoremap <silent> <F6> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

""" Nerdtree like sidepanel 
" absolute width of netrw window
let g:netrw_winsize = -28

" do not display info on the top of window
let g:netrw_banner = 0

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" variable for use by ToggleNetrw function
let g:NetrwIsOpen=0

" Lexplore toggle function
function! ToggleNetrw()

    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
        let g:netrw_liststyle = 0
        let g:netrw_chgwin=-1
    else
        let g:NetrwIsOpen=1
        let g:netrw_liststyle = 3
        silent Lexplore
    endif
endfunction

" Open netrw sidebar and open preview of file under cursor with ;
noremap <silent> <leader>d :call ToggleNetrw()<CR><Paste>

" Function to open preview of file under netrw
augroup Netrw
  autocmd filetype netrw nmap <leader>; <cr>:wincmd W<cr>
augroup end

" Vim polyglot language specific settings
let g:python_highlight_space_errors = 0

" COC options
let g:coc_global_extensions = ['coc-lists', 'coc-json', 'coc-python', 'coc-git']

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>rf  <Plug>(coc-format-selected)
nmap <leader>rf  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of
"languageserver.

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Using CocList
nnoremap <silent> <space>L  :<C-u>CocList<cr>

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>C  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>O  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>S  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>P  :<C-u>CocListResume<CR>
