" プラグインが読み込まれていない場合何もせず終了する
UsePlugin 'fern.vim'

" fern-bookmark のユーザーデータファイルパス定義
let g:fern#scheme#bookmark#store#file = "~/.vim/fern-bookmark.json"

" クリップボードのパスからディレクトリパスを取得する関数定義
function! s:GetDirecotryPathFromClipboard() abort
    " 前提: クリップボードにディレクトリパス or ファイルパスが入っている
    " パスがファイルなら親ディレクトリパス、ディレクトリならそのままのパスを返却する
    let targetPath = @+
    if isdirectory(targetPath)
        return targetPath
    else
        return fnamemodify(targetPath, ':h')
    endif
endfunction

" VSCode起動関数定義
function! s:BootVscodeFromClipboardPath() abort
    " 前提: codeコマンドにPATHが通っている
    " パスがファイルなら親ディレクトリパス、ディレクトリならそのままのパスをルートとしてVSCodeを起動する
    let targetDirPath = s:GetDirecotryPathFromClipboard()
    let bootCmd = printf("code %s", targetDirPath)
    :call system(bootCmd)
endfunction

" Powershell起動関数定義
function! s:BootPwshFromClipboardPath() abort
    " 前提: wtコマンドにPATHが通っている
    " パスがファイルなら親ディレクトリパス、ディレクトリならそのままのパスをルートとしてPowershellを起動する
    let targetDirPath = s:GetDirecotryPathFromClipboard()
    " 既存のWindowsTerminalがあるならウィンドウ下30%をペイン分割して表示する
    let bootCmd = printf("wt --window 0 split-pane --horizontal --size .3 -d %s", targetDirPath)
    :call system(bootCmd)
endfunction

" Explorer起動関数定義
function! s:BootExplorerFromClipboardPath() abort
    " 前提: explorerコマンドにPATHが通っている
    " パスがファイルなら親ディレクトリパス、ディレクトリならそのままのパスをルートとしてExplorerを起動する
    let targetDirPath = s:GetDirecotryPathFromClipboard()
    let bootCmd = printf("explorer %s", targetDirPath)
    :call system(bootCmd)
endfunction

" tcd実行関数定義
function! s:TcdFromClipboardPath() abort
    " パスがファイルなら親ディレクトリパス、ディレクトリならそのままのパスをルートとしてtcdする
    let targetDirPath = s:GetDirecotryPathFromClipboard()
    execute printf("tcd %s", targetDirPath)
endfunction

" fern初期化用関数定義
function! s:init_fern() abort
    " VSCode起動Plugの定義
    nmap <Plug>(fern-my-boot-vscode)
        \ <Plug>(fern-action-yank:path)
        \ :call <SID>BootVscodeFromClipboardPath()<CR>
    " VSCode起動Plugのキーマップ定義
    nmap <buffer><silent> <C-s> <Plug>(fern-my-boot-vscode)

    " Powershell起動Plugの定義
    nmap <Plug>(fern-my-boot-pwsh)
        \ <Plug>(fern-action-yank:path)
        \ :call <SID>BootPwshFromClipboardPath()<CR>
    " Powershell起動Plugのキーマップ定義
    nmap <buffer><silent> <C-t> <Plug>(fern-my-boot-pwsh)

    " ブックマーク起動Plugの定義
    " 左側にdrawerとして出てくる。トグルできる
    nnoremap <buffer><silent> <Plug>(fern-my-enter-bookmark)
        \ :<C-u>Fern -drawer -toggle bookmark:///<CR>
    " ブックマーク起動Plugのキーマップ定義
    nmap <buffer><silent> <C-b> <Plug>(fern-my-enter-bookmark)

    " Explorer起動Plugの定義
    nmap <Plug>(fern-my-boot-explorer)
        \ <Plug>(fern-action-yank:path)
        \ :call <SID>BootExplorerFromClipboardPath()<CR>
    " Explorer起動Plugのキーマップ定義
    nmap <buffer><silent> <C-e> <Plug>(fern-my-boot-explorer)

    " 外部コマンド入力開始Plugの定義
    " カーソル行のディレクトリ or ファイルの親ディレクトリをカレントディレクトリにする
    " その後外部コマンド入力を開始する
    nmap <Plug>(fern-my-input-external-command)
        \ <Plug>(fern-action-yank:path)
        \ :call <SID>TcdFromClipboardPath()<CR>
        \ :<C-u>!
    " 外部コマンド入力開始Plugのキーマップ定義
    nmap <buffer> gi <Plug>(fern-my-input-external-command)
endfunction

" fernウィンドウが開くときに毎回初期化関数を実行する
augroup fern-custom
  " fern-custom 内のautocmd定義を削除
  " :source コマンド経由でこのファイルが2回以上呼ばれても
  " fern-custom 内の autocmd が重複定義されないようにする
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
