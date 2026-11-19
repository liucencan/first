# first

`D:\git` 目录的 Git 仓库（默认分支 `main`），已同步推送到 GitHub 与 Gitee。

## 远程

| 名称 | 地址 | 协议 | 状态 |
|---|---|---|---|
| github | https://github.com/liucencan/first.git | HTTPS + GCM | 已推送 |
| gitee | git@gitee.com:liuchencan/first.git | SSH | 已推送 |

- 本地仓库：`D:\git\.git`
- 一键脚本：`push.ps1`
- 双端 `main` 指向同一提交：`fb1e077`

## 认证方式

- **GitHub**：HTTPS，凭据存于 Windows 凭据管理器（Git Credential Manager 2.9.1）。
- **Gitee**：SSH 密钥 `C:\Users\qwertyuiop\.ssh\id_ed25519`，已登记到 Gitee 账号 `liuchencan`（流沉璨）。

校验命令：

```powershell
ssh -T git@gitee.com      # Hi 流沉璨(@liuchencan)! You've successfully authenticated
ssh -T git@github.com     # 未登记公钥时会 Permission denied，属正常
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

只推当前分支跟踪的远端：`git push`

## 一致性检查

```powershell
git ls-remote github refs/heads/main
git ls-remote gitee  refs/heads/main
```

两行 SHA 相同即表示双端同步。

## 已忽略内容

见 `.gitignore`（系统文件、编辑器目录、日志与临时文件）。
