
if has("syntax")
  syntax on
endif

set number           "行番号の表示
set title            "ターミナルのタイトルにファイル名を表示
set ambiwidth=double "文脈によって解釈が異なる全角文字の幅を、2に固定する
set tabstop=4        "インデント幅
set shiftwidth=4     "vimが自動で生成する（読み込み時など）tab幅をスペース4つ文にする
set expandtab        "tabを半角スペースで挿入する
set smartindent      "改行時などに、自動でインデントを設定してくれる
set autoindent       "改行時のインデントを継続
set mouse=a          "マウスの入力を受け付ける
set history=100      "コマンドの履歴数
set whichwrap=b,s,h,l,<,>,[,] "行頭行末の左右移動で行をまたぐ
set ignorecase       "検索で大文字と小文字を区別しない
"コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:full
set autoread         "他で書き換えられた場合、自動で読み直す
set ruler            "カーソルの位置情報を表示
set showcmd          "入力中のステータスを表示する
set laststatus=2     "ステータスラインの表示
" ステータスラインのフォーマット
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]
" ステータスラインの色
highlight StatusLine term=bold cterm=bold ctermfg=black ctermbg=gray
set incsearch        "インクリメンタル検索を有効にする
hi Comment ctermfg=gray "コメントアウトの部分を灰色にする

inoremap <C-h> <LEFT>
inoremap <C-j> <DOWN>
inoremap <C-k> <UP>
inoremap <C-l> <RIGHT>
inoremap <C-d> <BS>
inoremap <C-c> <Esc>
inoremap <C-e> <Esc>

inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

nnoremap tree :<C-u>NERDTree<CR>

nnoremap s <Nop>
nnoremap ss :<C-u>split<CR>
nnoremap sv :<C-u>vsplit<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sn gt
nnoremap sp gT
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sw <C-w>w
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sq :<C-u>wq<CR>


""""""""""""""""""""""""""""""
" Vim-Plug
""""""""""""""""""""""""""""""
"
" ## Installation
" Download plug.vim and put it in the "autoload" directory.
"
"     curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" ## Usage
" Add a vim-plug section to your ~/.vimrc (or ~/.config/nvim/init.vim for Neovim):
"
" 1. Begin the section with plug#begin()
" 2. List the plugins with Plug commands
" 3. plug#end() to update &runtimepath and initialize plugin system
"
call plug#begin()
Plug 'tomtom/tcomment_vim'
Plug 'scrooloose/nerdtree'
call plug#end()
""""""""""""""""""""""""""""""


" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""