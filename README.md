# Kiro2API 部署指南

## 快速开始

### 1. 下载部署文件

```bash
# 克隆部署目录
git clone https://github.com/ssmdo/kiro2api.git
cd kiro2api/deploy
```

或者直接下载 deploy 目录中的文件。

### 2. 配置

复制并编辑配置文件：

```bash
# 复制环境变量配置
cp .env.example .env

# 编辑配置（可选）
vim .env
```

编辑 `config.yaml` 根据需要修改配置。

### 3. 启动服务

```bash
# 添加执行权限
chmod +x deploy.sh

# 启动服务
./deploy.sh start
```

## 命令说明

| 命令 | 说明 |
|------|------|
| `./deploy.sh start` | 启动服务 |
| `./deploy.sh stop` | 停止服务 |
| `./deploy.sh restart` | 重启服务 |
| `./deploy.sh logs` | 查看日志 |
| `./deploy.sh update` | 更新镜像并重启 |
| `./deploy.sh status` | 查看服务状态 |

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
    link: "sqlite:./data/kiro.db"  # 数据库路径

kiro:
  apiTarget: "https://q.us-east-1.amazonaws.com"
  authTarget: "https://prod.us-east-1.auth.desktop.kiro.dev"
  version: "0.8.0"
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
    └── kiro.db         # SQLite 数据库
```

## 常见问题

### 1. 端口被占用

修改 `.env` 文件中的 `PORT` 变量：

```bash
PORT=8080
```

### 2. 更新到最新版本

```bash
./deploy.sh update
```

### 3. 查看运行日志

```bash
./deploy.sh logs
```

### 4. 数据持久化

数据存储在 `./data` 目录中，包括 SQLite 数据库文件。备份时请备份此目录。

## License

MIT License

