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
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'lervag/vimtex'
Plug 'mhinz/neovim-remote'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'ncm2/ncm2-ultisnips'
Plug 'roxma/nvim-yarp'
Plug 'SirVer/ultisnips'


call plug#end()

"Allow filetype plugins and syntax highlighting 
filetype plugin indent on
syntax on

"Change backspace to behave more intuitively
set backspace=indent,eol,start

"Set tab options for vim
set expandtab
set tabstop=8
set softtabstop=4
set shiftwidth=4

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

"Case insensitive searching UNLESS /C or capital in search
set ignorecase
set smartcase

" set Vim-specific sequences for RGB colors
if exists('$TMUX')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

"Set colorscheme
set termguicolors
set background=dark
let g:gruvbox_sign_column='bg0'
let g:gruvbox_italic=1
let g:lightline = {
       \ 'colorscheme': 'gruvbox',
       \ 'active': {
       \   'left': [ [ 'mode', 'paste' ],
       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
       \ },
       \ 'component_function': {
       \   'gitbranch': 'fugitive#head'
       \ },
       \ }
colorscheme gruvbox
" 
"Remap space as leader key
noremap <Space> <Nop>
let mapleader="\<Space>"

"Add move line shortcuts
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
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
    set mouse=v
    set nonu
    echo "Mouse usage Visual"
  else
    set mouse=a
    set nu
    echo "Mouse usage All"
  endif
endfunction

"Set no expandtab on makefile
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

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

function! s:changebranch(branch) 
    execute 'Git checkout' . a:branch
    call feedkeys("i")
endfunction

command! -bang Gbranch call fzf#run({
            \ 'source': 'git branch -a --no-color | grep -v "^\* " ', 
            \ 'sink': function('s:changebranch')
            \ })

"Add preview to Rg togglable with question mark and add shellescape find git
"root for searching top level git directory
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>).' '.shellescape(s:find_git_root()), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0) 

" Search project root
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

function ProjectWrap()
  call fzf#run({
            \ 'source': "fd . '/Users/michael/Repositories'", 
            \ 'sink': 'e' 
            \ })
  exec Glcd
endfunction


" Search all git projects in ~/Repositories
command! -bang Projects call fzf#run({
            \ 'source': "fd . '~/Repositories'", 
            \ 'sink': 'e' 
            \ })

map <silent> <leader>p :Projects<CR>

" Make gutentags use ripgrep
let g:gutentags_file_list_command = 'rg --files'

"Set vim dispatch filetype options
nnoremap <F9> :Dispatch<CR>
augroup Dispatch
  autocmd!
  autocmd FileType python let b:dispatch = 'python %'
  autocmd FileType cpp let b:dispatch = 'make -j4 ./build'
  "autocmd FileType cpp let b:dispatch = 'clang++ % -std=c++11 -g'
  autocmd FileType rust let b:dispatch = 'rustc %'
augroup END 

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
augroup END

" Clear white space on empty lines and end of line
nnoremap <silent> <F6> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

""" Nerdtree like sidepanel 
" absolute width of netrw window
let g:netrw_winsize = -28

" do not display info on the top of window
let g:netrw_banner = 0

" tree-view
let g:netrw_liststyle = 3

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" use the previous window to open file
let g:netrw_browse_split = 4
let g:NetrwIsOpen=0

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
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

" Open netrw sidebar and open preview of file under cursor with ;
noremap <silent> <leader>d :call ToggleNetrw()<CR><Paste>
autocmd filetype netrw nmap <leader>; <cr>:wincmd W<cr>

"Enable NCM2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
"set completeopt-=preview

"Configure LSP
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
    \ 'python': ['pyls'],
    \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
    \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
    \ }

" \ 'python': ['pyls'],
"Add global settings
let g:LanguageClient_settingsPath = $HOME.'/.config/nvim/settings.json'

"Add mappings for different language client commands
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
" let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

" Draw the signcolumn when language client neovim starts
augroup LanguageClient_config
  autocmd!
  autocmd User LanguageClientStarted set signcolumn=yes 
augroup END

" Change default language client sign column settings 
let g:LanguageClient_diagnosticsDisplay = {
      \        1: {
      \            "name": "Error",
      \            "texthl": "ALEError",
      \            "signText": ">>",
      \            "signTexthl": "ALEErrorSign",
      \        },
      \        2: {
      \            "name": "Warning",
      \            "texthl": "ALEWarning",
      \            "signText": ">>",
      \            "signTexthl": "ALEWarningSign",
      \        },
      \        3: {
      \            "name": "Information",
      \            "texthl": "ALEInfo",
      \            "signText": "ℹ",
      \            "signTexthl": "ALEInfoSign",
      \        },
      \        4: {
      \            "name": "Hint",
      \            "texthl": "ALEInfo",
      \            "signText": "➤",
      \            "signTexthl": "ALEInfoSign",
      \        },
      \    }
