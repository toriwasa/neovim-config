" VSCode Neovim 内での設定
" VSCodeのバックエンドとしてNeovimが起動されていないなら何もせず終了する
if !exists('g:vscode')
    finish
endif

" 以下VSCode Neovimでの設定
" 便利なキーマップ定義
" 現在開いているファイルのファイル名を拡張子付きでコピーする
nnoremap <leader>yf :call VSCodeNotify('copy-file-name.copyFileNameWithExtension')<CR>
