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

    $jobScriptBlock = {
        param ($src, $dest)
        $progress = "Syncing from $src to $dest ..."
        Write-Host $progress
        robocopy $src $dest /MIR /MOT:10 /W:1 /R:1 /XD *.tmp | ForEach-Object { Write-Host $_ }
    }

    Start-Job -ScriptBlock $jobScriptBlock -ArgumentList $source, $destination
}

# フォルダの同期処理を実行する関数を実行
foreach ($destinationFolder in $destinationFolders) {
    Sync-Folder -source $sourceFolder -destination $destinationFolder
}