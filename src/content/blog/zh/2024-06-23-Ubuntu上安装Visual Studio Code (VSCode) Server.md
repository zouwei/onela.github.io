---
title: Ubuntu上安装Visual Studio Code (VSCode) Server
tags:
  - Visual Studio Code Serve>
---

## toc
在 Ubuntu 上安装 Visual Studio Code (VSCode) Server 是通过在服务器上安装 Visual Studio Code 的远程开发扩展来实现的。



以下是一些步骤，假设你已经在服务器上安装了 Ubuntu 操作系统：

## 更新系统
   在开始之前，确保你的系统已经更新到最新版本：

   ```bash
   sudo apt update
   sudo apt upgrade
   ```

## 安装 Visual Studio Code 服务器
   下载并安装 Visual Studio Code Server。你可以选择适合你系统架构的版本。

   ```bash
   # 找到最新的vs code server最新版本（以64位系统为例，）
   wget https://github.com/coder/code-server/releases/download/v4.90.3/code-server-4.90.3-linux-amd64.tar.gz
   
   # 解压文件
   tar -xvzf code-server-4.90.3-linux-amd64.tar.gz
   
   # 将解压后的文件夹移动到适当的位置
   sudo mv code-server-4.90.3-linux-amd64 /usr/local/code-server
   
   # 如果需要，你可以创建一个符号链接
   sudo ln -s /usr/local/code-server/bin/code-server /usr/bin/code-server
   ```

   请注意，上述 URL 中的版本号可能已经过时。请访问 [code-server GitHub Releases](https://github.com/cdr/code-server/releases?ref=gholl.com) 获取最新版本的 URL。

   

## 创建一个系统用户
   为了安全起见，建议你创建一个专用的用户来运行 VSCode Server。

   ```bash
   sudo adduser --system --group --home=/var/lib/code-server --shell=/bin/bash code
   
   # 设置密码（coder用户为例，替换成自己的user）
   sudo passwd code
   ```

   这将创建一个名为 `code-server` 的系统用户，并将其主目录设置为 `/var/lib/code-server`。

## 设置系统服务
   创建一个 systemd 服务以在系统启动时自动启动 VSCode Server。

   ```bash
   sudo vim /etc/systemd/system/code-server.service
   ```

   在编辑器中添加以下内容：

   ```ini
   [Unit]
   Description=Code Server - VSCode Server
   After=network.target
   
   [Service]
   #User=code-server #指定用户启动，这里使用前面创建的专用用户来启动（替换你自己的用户名）
   Type=simple
   Environment=PASSWORD=your_password  # 设置访问密码
   ExecStart=/usr/bin/code-server --bind-addr 0.0.0.0:18080 --user-data-dir /var/lib/code-server --auth password
   Restart=always
   RestartSec=3
   
   [Install]
   WantedBy=default.target
   ```

   替换 `your_password` 为你想要的密码。保存并关闭编辑器。

## 启动和启用服务
   启动并启用 `code-server` 服务。

   ```bash
   # 配置生效
   sudo systemctl daemon-reload
   # 启动或者重启（restart）code-server
   sudo systemctl start code-server
   # 开机启动code-server
   sudo systemctl enable code-server
   # 关闭开机启动
   sudo systemctl disable code-server
   
   # 查看状态
   sudo systemctl status code-server
   ```

   这将在系统启动时自动启动 VSCode Server。

## 访问 VSCode Server
   打开浏览器，并访问 `http://your_server_ip:8080`。输入你在 systemd 服务文件中设置的密码，你将能够通过浏览器访问 Visual Studio Code。

请记住，将 `your_server_ip` 替换为你服务器的实际 IP 地址。

