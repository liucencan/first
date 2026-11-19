# first

`D:\git` 目录的 Git 仓库（默认分支 `main`）。

## 远程

| 名称 | 地址 | 状态 |
|---|---|---|
| github | https://github.com/liucencan/first.git | 已推送 |
| gitee | https://gitee.com/GITEE_USER/first.git | 待配置账号 |

- 本地仓库：`D:\git\.git`
- 一键脚本：`push.ps1`

## 当前状态

GitHub 已通过 HTTPS + Git Credential Manager 完成首次推送，`main` 已建立跟踪。

Gitee 侧缺少两样东西：

1. `liucencan` 在 Gitee 上不存在（`https://gitee.com/liucencan` 返回 404），需要确认 Gitee 用户名；
2. 本机没有 Gitee 的凭据。

## Gitee 推送（二选一）

### 方式 A：SSH

把公钥加到 Gitee（设置 → SSH 公钥）：

```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmWG93yiSdNOnSyLp4YYiRu6fqSOXRJMEns6N+NJbqH qwertyuiop-dsh
```

然后：

```powershell
cd D:\git
git remote set-url gitee git@gitee.com:GITEE_USER/first.git
ssh -T git@gitee.com
git push -u gitee main
```

### 方式 B：HTTPS + 私人令牌

Gitee → 设置 → 私人令牌 → 生成新令牌（勾选 `projects` 权限）。

```powershell
cd D:\git
git remote set-url gitee https://gitee.com/GITEE_USER/first.git
git push -u gitee main
# 提示输入用户名时填 GITEE_USER，密码处粘贴令牌
```

也可写入凭据管理器，避免重复输入：

```powershell
"protocol=https`nhost=gitee.com`nusername=GITEE_USER`npassword=GITEE_TOKEN`n" | git credential approve
```

## 日常命令

```powershell
git add -A
git commit -m "message"
git push github main
git push gitee main
```

## 已忽略内容

见 `.gitignore`（系统文件、编辑器目录、日志与临时文件）。
