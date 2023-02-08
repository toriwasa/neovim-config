# 設定ファイル置き場の環境変数が存在しない場合はセットする
if ($null -eq $env:XDG_CONFIG_HOME) {
    [System.Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", "$env:HOME/.config", "User")
}
# 作成対象パスを削除しておく
Remove-Item -Recurse -Force $env:XDG_CONFIG_HOME/nvim
# このスクリプトが配置されたパスから設定ファイルディレクトリへのシンボリックリンクを作成する(要開発者モード)
New-Item -Type SymbolicLink -Target $PSScriptRoot -Path $env:XDG_CONFIG_HOME/nvim
