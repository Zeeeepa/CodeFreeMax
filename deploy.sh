#!/bin/bash

# Kiro2API 一键部署脚本
set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 项目目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# 默认配置
DEFAULT_IMAGE="ssmdo/kiro2api:latest"
DEFAULT_PORT=8000

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}       Kiro2API 一键部署脚本${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# 检查 Docker 是否安装
check_docker() {
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}错误: Docker 未安装${NC}"
        echo -e "请先安装 Docker: https://docs.docker.com/get-docker/"
        exit 1
    fi
    echo -e "${GREEN}✓ Docker 已安装${NC}"
}

# 检查 Docker Compose 是否安装
check_docker_compose() {
    if docker compose version &> /dev/null; then
        COMPOSE_CMD="docker compose"
    elif command -v docker-compose &> /dev/null; then
        COMPOSE_CMD="docker-compose"
    else
        echo -e "${RED}错误: Docker Compose 未安装${NC}"
        echo -e "请先安装 Docker Compose"
        exit 1
    fi
    echo -e "${GREEN}✓ Docker Compose 已安装${NC}"
}

# 初始化配置
init_config() {
    # 创建数据目录
    mkdir -p "$SCRIPT_DIR/data"
    
    # 创建 .env 文件
    if [ ! -f "$SCRIPT_DIR/.env" ]; then
        cp "$SCRIPT_DIR/.env.example" "$SCRIPT_DIR/.env"
        echo -e "${GREEN}✓ 已创建 .env 配置文件${NC}"
    fi
}

# 启动服务
start() {
    echo -e "${YELLOW}正在启动服务...${NC}"
    $COMPOSE_CMD up -d
    echo -e "${GREEN}✓ 服务已启动${NC}"
    echo ""
    echo -e "访问地址: ${BLUE}http://localhost:${DEFAULT_PORT}${NC}"
}

# 停止服务
stop() {
    echo -e "${YELLOW}正在停止服务...${NC}"
    $COMPOSE_CMD down
    echo -e "${GREEN}✓ 服务已停止${NC}"
}

# 重启服务
restart() {
    echo -e "${YELLOW}正在重启服务...${NC}"
    $COMPOSE_CMD restart
    echo -e "${GREEN}✓ 服务已重启${NC}"
}

# 查看日志
logs() {
    $COMPOSE_CMD logs -f
}

# 更新镜像
update() {
    echo -e "${YELLOW}正在拉取最新镜像...${NC}"
    $COMPOSE_CMD pull
    echo -e "${YELLOW}正在重启服务...${NC}"
    $COMPOSE_CMD up -d
    echo -e "${GREEN}✓ 更新完成${NC}"
}

# 查看状态
status() {
    $COMPOSE_CMD ps
}

# 显示帮助
show_help() {
    echo "用法: $0 [命令]"
    echo ""
    echo "命令:"
    echo "  start    启动服务"
    echo "  stop     停止服务"
    echo "  restart  重启服务"
    echo "  logs     查看日志"
    echo "  update   更新镜像并重启"
    echo "  status   查看服务状态"
    echo "  help     显示帮助信息"
    echo ""
}

# 主函数
main() {
    check_docker
    check_docker_compose
    init_config
    
    case "${1:-start}" in
        start)
            start
            ;;
        stop)
            stop
            ;;
        restart)
            restart
            ;;
        logs)
            logs
            ;;
        update)
            update
            ;;
        status)
            status
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            echo -e "${RED}未知命令: $1${NC}"
            show_help
            exit 1
            ;;
    esac
}

main "$@"

