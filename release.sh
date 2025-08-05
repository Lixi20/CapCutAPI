#!/usr/bin/sh

service_name=cap_cut

echo "正在拉取最新代码..."
git pull || { echo "git pull 失败"; exit 1; }

# 创建运行用户（如果不存在）
id huanzhou || useradd --comment HuanZhou --home-dir /var/lib/huanzhou --shell /sbin/nologin --create-home --system --user-group huanzhou

# 创建目录并设置权限
mkdir -p /var/cache/capcut/
chown -R huanzhou:huanzhou /var/cache/capcut/

# 拷贝 service 文件和配置文件
echo y | cp ${service_name}.service /usr/lib/systemd/system/${service_name}.service

# 重载服务并启动
systemctl daemon-reload
systemctl enable ${service_name}
systemctl restart ${service_name}
systemctl status ${service_name}