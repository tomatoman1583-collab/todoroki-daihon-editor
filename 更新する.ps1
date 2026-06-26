# 轟 台本エディタ（公開版）を最新に更新するスクリプト（Windows用）
# 使い方：このファイルを右クリック →「PowerShellで実行」、またはマサトが「公開版を更新して」と言えばClaudeが実行する。
#
# やること：
#   1. 元ファイル ..\台本エディタ.html を index.html に上書きコピー
#   2. 変更をGitHubに送る（git commit + push）
#   3. GitHub Pages が自動で作り直す（反映まで1分ほど）
#
# 公開URL： https://tomatoman1583-collab.github.io/todoroki-daihon-editor/

$ErrorActionPreference = "Stop"
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $here

$gh  = "C:\Program Files\GitHub CLI\gh.exe"   # ※Windows専用パス。Macで動かすときは要変更
$src = Join-Path $here "..\台本エディタ.html"

Copy-Item $src (Join-Path $here "index.html") -Force
git add index.html

# 変更が無ければここで終わり
$changed = git status --porcelain
if (-not $changed) {
    Write-Host "変更なし。すでに最新だぞ。" -ForegroundColor Yellow
    exit 0
}

git commit -m "台本エディタを更新"
git push

Write-Host ""
Write-Host "送信完了！1分ほどで公開版に反映されるぞ。" -ForegroundColor Green
Write-Host "URL: https://tomatoman1583-collab.github.io/todoroki-daihon-editor/" -ForegroundColor Cyan
