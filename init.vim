" 【使わないプラグインのロード停止設定】
" netrw系プラグインを無効にする
" 参考: https://vim-jp.org/vimdoc-ja/usr_41.html
let g:loaded_netrw              = 1
let g:loaded_netrwPlugin        = 1
let g:loaded_netrwSettings      = 1
let g:loaded_netrwFileHandlers  = 1

" 【plugin読み込み設定】
" 一時的に使わないpluginはコメントアウトする
call plug#begin('~/.vim/plugged')
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-speeddating'
    Plug 'tpope/vim-repeat'
    Plug 'inkarkat/vim-ReplaceWithRegister'
    Plug 'arthurxavierx/vim-caser'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'lambdalisue/fern.vim'
    Plug 'lambdalisue/fern-hijack.vim'
    Plug 'lambdalisue/fern-bookmark.vim'
call plug#end()

" 【vim全体設定】
" 無名レジスタを使って yank/paste する場合はクリップボードを経由させる
set clipboard+=unnamed
" 小文字検索時に大文字小文字を区別しない
set ignorecase
" 大文字を含む検索をするときは大文字小文字を区別する
set smartcase
" 常に編集中ファイルのディレクトリがカレントディレクトリになる
set autochdir

" Tabをスペース4つとして扱う
set tabstop=4
" インデント操作時スペース4つずつ処理する
set shiftwidth=4
" TabキーでSpaceが入力される
" <Tab>を入力する場合は <C-v><Tab> を入力する
set expandtab

" vsplit時は下に新規ウィンドウを開く
set splitbelow
" split時は右に新規ウィンドウを開く
set splitright

" Markdown の Lint Error を通常テキスト同様のハイライト設定にする
highlight link markdownError Normal

" 外部grepを実行する場合はripgrepを使う
" 前提: rg コマンドにPATHが通っていること
if executable("rg")
    let &grepprg = 'rg --vimgrep --no-heading'
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" 【個別設定読み込み】
" vim-plug でコメントアウトされたプラグイン設定は読み込まずに終了するための関数定義
" 参考: https://zenn.dev/mattn/articles/565c4ec71f461cbbf5c9
" 使い方: _config/plugin-config.vim の先頭に UsePlugin 'plugin-name' と書く
let s:plugs = get(s:, 'plugs', get(g:, 'plugs', {}))
function! FindPlugin(name) abort
  return has_key(s:plugs, a:name) ? isdirectory(s:plugs[a:name].dir) : 0
endfunction
command! -nargs=1 UsePlugin if !FindPlugin(<args>) | finish | endif

" 前提: このファイルがあるディレクトリ が runtimepath から読める場所にあること
" Windowsの場合 $LOCALAPPDATA/nvim -> neovim-config に対してジャンクションリンクを貼る
" _config 配下のvimファイルを読み込む
" :source の度に読み込まれる
runtime! _config/*.vim
