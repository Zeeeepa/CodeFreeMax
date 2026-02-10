# CodeFreeMax

> ⚠️ **关于 Token 安全性的说明**
>
> 近期有用户在 L 站反馈称本程序存在「偷取用户 Token」的行为，在此做出统一回应：
>
> 本程序对用户 Token 的处理方式为 **服务端加密存储**，相关操作仅用于防止程序被破解/逆向，属于正常的安全防护措施，**并非窃取用户 Token**。
>
> 如果不放心，GitHub 上有人提供了本程序的 **去授权版**，可以直接免授权使用。
>
> 此外，**v3.0.0 全新 PaaS 架构即将上线**，账号数据仍由本地管理，但 Token 将通过接入点进行转发。如果你对此仍有顾虑，也可以选择不购买/不使用，我们完全尊重你的选择。
>
> ⚠️ **本程序后续将不再提供任何免费服务。**

🚀 将 Kiro、Antigravity、Warp、Orchids、Grok 等 IDE/服务转换为兼容 OpenAI / Claude / Augment Code 格式的 API 服务。

> 公共授权码：`144bd7a0-6ca2-4b7e-ac1c-1a29afb50662`

## ✨ 功能特性

### 多渠道支持

| 渠道 | Claude 协议 | OpenAI 协议 | 免费 | 备注 |
|------|:-----------:|:-----------:|:----:|------|
| Kiro | ✅ | ✅ | ❌ | ⭐ AugmentCode 推荐渠道 |
| Antigravity | ✅ | ✅ | ✅ | 可与 Kiro 自由切换 |
| Warp | ✅ | ✅ | ❌ | |
| Orchids | ✅ | ✅ | ❌ | ⚠️ 暂停出售 |
| ClaudeCode | ✅ | — | ❌ | 仅支持 Claude 协议 |
| Grok | — | ✅ | ✅ | 纯 OpenAI 协议 |

- API 端点格式：`http://localhost:8000/{渠道}/v1`，如 `/kiro/v1`、`/antigravity/v1`

### 核心能力

- 🔄 **多协议** — 同时支持 Claude `/v1/messages` 和 OpenAI `/v1/chat/completions`
- 🧠 **上下文自动压缩** — ClaudeCode 多轮对话自动压缩，超长会话不丢失、不卡顿
- 🚀 **Augment Code 适配** — 完美反代 Augment Code，配合魔改插件使用
- 🌐 **代理池** — 支持 HTTP/HTTPS/SOCKS5，可按渠道独立配置代理
- 🔑 **Session 派生** — 代理地址支持 `%s` 占位符，自动替换为账号 Session ID，实现 IP 隔离
- ⚖️ **负载均衡** — 多账号随机分配，自动跳过异常账号
- 🔁 **自动重试** — 可配置重试次数、延迟和验证码重试
- 📋 **模型管理** — 自定义模型列表、名称映射、启用/禁用、排序
- 💾 **数据持久化** — SQLite 存储，方便备份迁移
- 🎨 **管理界面** — 全新前端界面，操作直观

## 项目展示

<img src="img/v1.png" alt="CodeFreeMax 界面展示 1">
<br>
<img src="img/v2.png" alt="CodeFreeMax 界面展示 2">
<br>
<img src="img/v3.png" alt="CodeFreeMax 界面展示 3">
<br>
<img src="img/v4.png" alt="CodeFreeMax 界面展示 4">
<br>

## 快速开始

### 1. 下载部署文件

```bash
git clone https://github.com/ssmDo/CodeFreeMax.git
cd CodeFreeMax/
```

### 2. 一键部署

```bash
chmod +x deploy.sh
./deploy.sh
```

运行 `./deploy.sh` 会自动执行：停止旧服务 → 拉取最新镜像 → 启动服务

### 3. 常用命令

```bash
# 查看日志
docker compose logs -f

# 停止服务
docker compose down

# 查看状态
docker compose ps
```

## 配置说明

### .env 文件

```bash
# Docker 镜像配置
DOCKER_IMAGE=ssmdo/kiro2api:latest

# 服务端口
PORT=8000
```

### config.yaml 文件

```yaml
server:
  address: ":8000"  # 服务监听地址

database:
  default:
    type: "sqlite"
    link: "sqlite:./data/augment.db"  # 数据库路径
```

## 目录结构

```
deploy/
├── README.md           # 部署说明
├── deploy.sh           # 一键部署脚本
├── docker-compose.yml  # Docker Compose 配置
├── config.yaml         # 应用配置文件
├── .env.example        # 环境变量示例
└── data/               # 数据目录（自动创建）
    └── augment.db      # SQLite 数据库
```

## 常见问题

### 1. 端口被占用

修改 `.env` 文件中的 `PORT` 变量：

```bash
PORT=8080
```

### 2. 更新到最新版本

直接重新运行部署脚本即可：

```bash
./deploy.sh
```

### 3. 查看运行日志

```bash
docker compose logs -f
```

### 4. 数据持久化

数据存储在 `./data` 目录中，包括 SQLite 数据库文件。备份时请备份此目录。

## 🔌 Augment Code 配套使用

本项目可配合魔改版 Augment-BYOK 插件使用，实现在 Augment Code 中使用自定义 API 端点。

> ⚠️ **V2.3.0 用户注意**: 更新到 V2.3.0 后，插件需要更新到 v3.0.0 才能使用上下文压缩功能！

👉 **使用教程**: [飞书文档](https://tcn1dv9putrz.feishu.cn/wiki/NfNEwWkGuiWhNJkHFdRcfXrPnn1)
🔑 **访问密码**: `734&Q851`

## 🙏 鸣谢

- [Augment-BYOK](https://github.com/AnkRoot/Augment-BYOK) - 本插件基于此项目进行魔改，感谢原作者的开源贡献

## ☕ 捐赠

如果这个项目对你有帮助，欢迎请作者喝杯咖啡 ☕

<img src="wx.jpg" alt="微信赞赏码" width="200">

## License

MIT License