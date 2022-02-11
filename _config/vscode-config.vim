" VSCode Neovim 内での設定
" VSCodeのバックエンドとして起動されていないなら何もせず終了する
if !exists('g:vscode')
    finish
endif

" 以下VSCode Neovimでの設定
" 便利なキーマップ定義
" copy full path
nnoremap <leader>yP :call VSCodeNotify('copyFilePath')<CR>
" copy relative path
nnoremap <leader>yp :call VSCodeNotify('copyRelativeFilePath')<CR>
" copy file name with extention
nnoremap <leader>yf :call VSCodeNotify('copy-file-name.copyFileName')<CR>

