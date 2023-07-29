# スクリプトが配置されているディレクトリを実行ディレクトリに設定
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $scriptPath

# envファイルのパス
$envFilePath = ".\.env"

if (Test-Path $envFilePath) {
    Write-Host "Info: Reading env file.: $envFilePath..."
    # envファイルを読み込んで、環境変数に設定
    $envContent = Get-Content $envFilePath -Raw

    # 環境変数に設定
    Invoke-Expression $envContent
} else {
    Write-Error "Error: Env file is not exist.: $envFile..."
    Exit 1
}

# robocopyを使ってフォルダを同期するジョブを開始する関数
function Sync-Folder {
    param ($source, $destination)

    try {
        Write-Host "Syncing from $source to $destination ..."
        robocopy $source $destination /MIR /W:1 /R:1 /XD *.tmp | ForEach-Object { Write-Host $_ }
        Write-Host "Synced from $destination to $source ..."
    }
    catch {
        Write-Error "Error: Syncing from $source to $destination ... detail: $($_.exception.message) "
    }
}

# フォルダの同期処理を実行する関数を実行
foreach ($destinationFolder in $destinationFolders) {

    # フォルダが存在しない場合はエラーを出力して終了
    if (!(Test-Path $sourceFolder)) {
        Write-Error "Error: Source folder is not exist.: $sourceFolder"
        Exit 1
    }

    # フォルダが存在しない場合はエラーを出力して処理をスキップ
    if (!(Test-Path $destinationFolder)) {
        Write-Error "Error: Destination folder is not exist.: $destinationFolder"
        continue
    }

    Sync-Folder -source $sourceFolder -destination $destinationFolder
}