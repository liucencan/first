# git

`D:\git` 目录已初始化为 Git 仓库（默认分支 `main`）。

## 现状

- 本地仓库：`D:\git\.git`
- 分支：`main`
- 远程：`github`、`gitee`（当前为占位地址 `USERNAME/REPO`）
- 一键脚本：`push.ps1`

## 首次推送（三步）

### 1. 把公钥加到两个平台

已生成密钥：`C:\Users\qwertyuiop\.ssh\id_ed25519`

公钥全文：

```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmWG93yiSdNOnSyLp4YYiRu6fqSOXRJMEns6N+NJbqH qwertyuiop-dsh
```

- GitHub → Settings → SSH and GPG keys → New SSH key
- Gitee → 设置 → SSH 公钥 → 添加公钥

验证：

```powershell
ssh -T git@github.com
ssh -T git@gitee.com
```

### 2. 在两个平台各建一个**空**仓库（不要勾选 README / .gitignore / License）

名字与 `-Repo` 参数保持一致。

### 3. 一键推送

```powershell
cd D:\git
pwsh -File .\push.ps1 -User 你的GitHub用户名 -Repo 仓库名
```

两个平台用户名不同时：

```powershell
pwsh -File .\push.ps1 -User github用户名 -Repo 仓库名 -GiteeUser gitee用户名
```

想走 HTTPS（用 Git Credential Manager 浏览器登录，免配 SSH）：

```powershell
pwsh -File .\push.ps1 -User 用户名 -Repo 仓库名 -Https
```

## 直接用 API 建仓库（可选）

```powershell
# GitHub
curl -X POST https://api.github.com/user/repos `
  -H "Authorization: Bearer GITHUB_TOKEN" `
  -H "Accept: application/vnd.github+json" `
  -d '{\"name\":\"REPO\",\"private\":false}'

# Gitee
curl -X POST "https://gitee.com/api/v5/user/repos" `
  -d "access_token=GITEE_TOKEN&name=REPO&private=false"
```

## 日常命令

```powershell
git add -A
git commit -m "message"
git push github main
git push gitee main
```

一次推两边：

```powershell
git push github main; git push gitee main
```

## 已忽略内容

见 `.gitignore`（系统文件、编辑器目录、日志与临时文件）。
