<#
.SYNOPSIS
    一次性把当前仓库配置好并推送到 GitHub 与 Gitee（SSH 方式）。

.EXAMPLE
    pwsh -File .\push.ps1 -User yourname -Repo yourrepo

.EXAMPLE
    # 若两个平台用户名不同
    pwsh -File .\push.ps1 -User yourname -Repo yourrepo -GiteeUser othername
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string] $User,          # GitHub 用户名 / 组织名
    [Parameter(Mandatory)] [string] $Repo,          # 远程仓库名（两边一致）
    [string] $GiteeUser,                            # Gitee 用户名，缺省与 GitHub 相同
    [string] $Message = "chore: 初始化仓库",
    [switch] $Https                                 # 用 HTTPS 而不是 SSH
)

$ErrorActionPreference = 'Stop'
if (-not $GiteeUser) { $GiteeUser = $User }

Set-Location -Path $PSScriptRoot

if ($Https) {
    $githubUrl = "https://github.com/$User/$Repo.git"
    $giteeUrl  = "https://gitee.com/$GiteeUser/$Repo.git"
} else {
    $githubUrl = "git@github.com:$User/$Repo.git"
    $giteeUrl  = "git@gitee.com:$GiteeUser/$Repo.git"
}

foreach ($pair in @(@('github', $githubUrl), @('gitee', $giteeUrl))) {
    $name, $url = $pair
    git remote remove $name 2>$null | Out-Null
    git remote add $name $url
    Write-Host "[remote] $name -> $url"
}

# 有未提交改动就先提交
if (git status --porcelain) {
    git add -A
    git commit -m $Message
}

foreach ($name in @('github', 'gitee')) {
    Write-Host "`n=== push $name ===" -ForegroundColor Cyan
    git push -u $name main
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "$name 推送失败。若是首次推送且远端已有内容，先执行： git pull --rebase $name main"
    }
}

Write-Host "`n=== 结果 ===" -ForegroundColor Cyan
git remote -v
git log --oneline -1
