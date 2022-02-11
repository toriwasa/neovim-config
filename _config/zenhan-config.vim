" 特定タイミングでIMEをオフにする設定
" 前提: > scoop install zenhan で zenhan.exe にPATHが通っていること
" zenhan-custom という名前のaugroupを定義
augroup zenhan-custom
    " zenhan-custom 内のautocmd定義を削除
    " :source コマンド経由でこのファイルが2回以上呼ばれても
    " zenhan-custom 内の autocmd が重複定義されないようにする
    autocmd!
    " zenhan コマンドへのPATHが通っていればautocmdを定義する
    if executable('zenhan')
        " insertモード抜けるときとコマンドラインモード抜けるときに
        " zenhanコマンドを実行してIME OFFにする
        autocmd InsertLeave * :call system('zenhan 0')
        autocmd CmdlineLeave * :call system('zenhan 0')
    endif
augroup END
