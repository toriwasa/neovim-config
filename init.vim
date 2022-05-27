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
    Plug 'machakann/vim-sandwich'
    Plug 'tpope/vim-speeddating'
    Plug 'tpope/vim-repeat'
    Plug 'inkarkat/vim-ReplaceWithRegister'
    Plug 'arthurxavierx/vim-caser'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'kana/vim-textobj-user'
    Plug 'lambdalisue/fern.vim'
    Plug 'lambdalisue/fern-hijack.vim'
    Plug 'lambdalisue/fern-bookmark.vim'
    Plug 'rebelot/kanagawa.nvim'
call plug#end()

" 【有効なプラグインの設定のみ利用する関数定義】
" vim-plug でコメントアウトされたプラグイン設定は読み込まずに終了するための関数定義
" 参考: https://zenn.dev/mattn/articles/565c4ec71f461cbbf5c9
" 使い方: _config/plugin-config.vim の先頭に UsePlugin 'plugin-name' と書く
let s:plugs = get(s:, 'plugs', get(g:, 'plugs', {}))
function! FindPlugin(name) abort
  return has_key(s:plugs, a:name) ? isdirectory(s:plugs[a:name].dir) : 0
endfunction
command! -nargs=1 UsePlugin if !FindPlugin(<args>) | finish | endif

" 【個別configファイル読み込み】
" _config 配下のvimファイルを読み込む
" 前提: このファイルがあるディレクトリ が runtimepath から読める場所にあること
" Windowsの場合 $LOCALAPPDATA/nvim -> neovim-config に対してジャンクションリンクを貼る
" :source の度に読み込まれる
runtime! _config/*.vim
