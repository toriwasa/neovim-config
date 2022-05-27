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

" 外部grepを実行する場合はripgrepを使う
" 前提: rg コマンドにPATHが通っていること
if executable("rg")
    let &grepprg = 'rg --vimgrep --no-heading'
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

