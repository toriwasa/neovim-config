# 設定ファイル置き場の環境変数が存在しない場合はセットする
$configDir = $env:XDG_CONFIG_HOME
if ($null -eq $configDir) {
    $configDir = "$HOME/.config"
    [System.Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", $configDir, "User")
}
# 作成対象パスを削除しておく
$targetNeovimConfigDir = "$configDir/nvim"
if (Test-Path -Path $targetNeovimConfigDir) {
    Remove-Item -Recurse $targetNeovimConfigDir
}
# このスクリプトが配置されたパスから設定ファイルディレクトリへのシンボリックリンクを作成する(要開発者モード)
New-Item -Type SymbolicLink -Target $PSScriptRoot -Path $targetNeovimConfigDir
