# このツールについて
## 概要
このツールは、Windows上の特定のフォルダ内のファイル一式を、別のフォルダに同期し、バックアップを実現します。

## 動作環境
Windows 10以降

# 利用方法

1. `.env.example`のファイル名を`.env`に名前を変えてください。

2. `.env`ファイルをエディタで開き、以下を設定してください。
   - `$sourceFolder`には、バックアップしたいフォルダのパスを指定してください。
   - `$destinationFolders`には、バックアップ先のフォルダのパスを指定してください。
  

3. PowerShellを開き、コマンドで`file_sync.ps1`のフルパスを入力し、実行してください。

   ```
   # 例）
   .\C:\Users\ユーザー名\Documents\myscript.ps1
   ```