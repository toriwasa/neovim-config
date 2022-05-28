" ファイルに分けるまでもない全般設定
" 特定分野の設定が増えてきたら別のファイルに分離すること
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

" 画面再描画時に検索ハイライトを消す
nnoremap <C-l> :nohlsearch<CR><C-l>

" Markdown の Lint Error を通常テキスト同様のハイライト設定にする
highlight link markdownError Normal

" " 【pwsh版設定】
" " 2022-05-28現在は起動が遅いのでpowershell版を使う
" let &shell = 'pwsh -NoLogo'
" " Powershell 7.2.1 以降の場合は実行結果文字列にANSIエスケープシーケンスが表示されないように
" " コマンド実行前に [System.Management.Automation.OutputRendering]::PlainText; が必要
" " 実行時の遅延の原因になる起動時の権利ロゴやpwsh用のプロファイル読み込みはスキップ
" " ps1を実行できるように実行ポリシーを変更
" " コマンド実行結果が文字化けしないように入出力の文字コードをUTF8に変更
" let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;[System.Management.Automation.OutputRendering]::PlainText;'
" let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
" let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
" set shellquote= shellxquote=

" " 【Powershell版設定】
" " 2022-05-28現在はPowershell5.1系の方が起動が速いのでこちらをshellとして指定する
" " ターミナルとして使う際に起動時の著作権メッセージが出ないように -NoLogo を指定する
" let &shell = 'powershell -NoLogo'
" " コマンド実行時は以下の引数で実行する
" " 実行時の遅延の原因になる起動時の権利ロゴやpwsh用のプロファイル読み込みはスキップ
" " ps1を実行できるように実行ポリシーを変更
" " コマンド実行結果が文字化けしないように入出力の文字コードをUTF8に変更
" let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
" let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
" let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
" set shellquote= shellxquote=

" 外部grepを実行する場合はripgrepを使う
" 前提: rg コマンドにPATHが通っていること
if executable("rg")
    let &grepprg = 'rg --vimgrep --no-heading'
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
