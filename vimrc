""
"" Just the minimal VIM setup I needed.
"" Thanks:
""   Mislav Marohnić  <mislav.marohnic@gmail.com>
""   Gary Bernhardt  <destroyallsoftware.com>
""   Drew Neil  <vimcasts.org>
""   Tim Pope  <tbaggery.com>
""   Janus  <github.com/carlhuda/janus>
""

set nocompatible
syntax enable
set encoding=utf-8
filetype plugin indent on

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"

" Nerdtre
Bundle 'scrooloose/nerdtree'

" Color schemes
Bundle 'mrtazz/molokai.vim'

" Ruby
Bundle "tpope/vim-rails"
Bundle "vim-ruby/vim-ruby"

" Make VIM easier
Bundle "mileszs/ack.vim"
Bundle "tpope/vim-endwise"
Bundle "tpope/vim-commentary"
Bundle "delimitMate.vim"
Bundle "Lokaltog/vim-powerline"

" Command-T
" Bundle "git://git.wincent.com/command-t.git"

" ctrlp
Bundle "kien/ctrlp.vim"

" Git
Bundle "tpope/vim-fugitive"

" Javascript
Bundle "pangloss/vim-javascript"

" Markdown
Bundle "tpope/vim-markdown"

" CTags
Bundle "taglist.vim"

color molokai

set ruler       " show the cursor position all the time
set cursorline
set showcmd     " display incomplete commands
set number
set numberwidth=6

set wildmode=longest,list,full
set wildmenu

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

"" Whitespace
set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
"" Searching
set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter

function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

if has("autocmd")
  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab

  " Make sure all mardown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif

" provide some context when editing
set scrolloff=3

" don't use Ex mode, use Q for formatting
map Q gq

" clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" Insert the current directory into a command
cmap <C-P> <C-R>=expand("%:p:h") . "/"

" remap space to :
nnoremap <Space> :

" exit with 'jj'
imap jj <Esc>

" map leader to ,
let mapleader=","

map <leader>gg :topleft 100 :split Gemfile<cr>
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

nnoremap <leader><leader> <c-^>

" find merge conflict markers
nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

imap <C-e> <C-o>A
imap <C-a> <C-o>I

imap <c-c> <esc>

" disable cursor keys in normal mode
map <Left>  :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up>    :echo "no!"<cr>
map <Down>  :echo "no!"<cr>

set backupdir=~/.vim/_backup    " where to put backup files.
set directory=~/.vim/_temp      " where to put swap files.

if has("statusline") && !&cp
  set laststatus=2  " always show the status bar
  let g:Powerline_symbols = 'fancy'

   " Start the status line
  "set statusline=%f\ %m\ %r

  " Add fugitive
  "set statusline+=%{fugitive#statusline()}

  " Finish the statusline
  "set statusline+=Line:%l/%L[%p%%]
  "set statusline+=Col:%v
  "set statusline+=Buf:#%n
  "set statusline+=[%b][0x%B]
 endif

nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>

nnoremap <F8> :set invpaste paste?<CR>
set pastetoggle=<F8>

nnoremap <F7> :set invnumber number?<CR>

