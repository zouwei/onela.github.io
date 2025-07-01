---
title: Ubuntu基于Docker搭建pixman
tags:
  - IPTV
---
> 



## 免责声明

**本程序仅供学习或测试设备，禁止中国大陆用户使用，不得用于商业用途，否则后果自负**



![img](https://img.shields.io/docker/v/pixman/pixman?label=Version) ![img](https://img.shields.io/docker/pulls/pixman/pixman?label=Pulls) ![img](https://img.shields.io/docker/image-size/pixman/pixman?label=Image%20size)

## 使用方法

只要是支持 Docker 的系统都可以使用，比如 Linux、Windows、macOS 等。

Arm/v7 架构系统请使用 [pixman/pixman-armv7](https://hub.docker.com/r/pixman/pixman-armv7) 镜像，自行修改后面使用方法里的 `pixman/pixman` 为 `pixman/pixman-armv7`

- Docker 安装方法：https://docs.docker.com/engine/install/
- Docker 入门：https://yeasy.gitbook.io/docker_practice
- 在群晖 Synology 部署：https://pixman.io/topics/14

### 直接使用命令运行

```
docker pull pixman/pixman
# 默认 latest 版本，也可以指定版本号，比如 1.0.0
# docker pull pixman/pixman:1.0.0

docker run -d --name=pixman -p 5000:5000 pixman/pixman
```

如果需要修改端口，可以修改 `-p 5000:5000` 中第一个 `5000` 为其他端口号。

```
docker run -d --name=pixman -p 5050:5000 pixman/pixman
```

如果某些域名无法访问，可以使用 `-e` 参数设置代理，注意将 192.168.50.50:7890 换成你自己代理的 ip 和端口

```
docker run -d --name=pixman -p 5000:5000 -e http_proxy=http://192.168.50.50:7890 -e https_proxy=http://192.168.50.50:7890 pixman/pixman
```

如果你需要访问 MytvSuper 直播源，那需要设置 MYTVSUPER_TOKEN 环境变量：

```
docker run -d --name=pixman -p 5000:5000 -e http_proxy=http://192.168.50.50:7890 -e https_proxy=http://192.168.50.50:7890 -e MYTVSUPER_TOKEN=YOUR_TOKEN pixman/pixman
```

如需让容器在宿主机重启后自动启动，可以使用 `--restart=always` 参数：

```
docker run -d --name=pixman -p 5000:5000 --restart=always pixman/pixman
```

导入外部的 m3u 文件，从而通过 `http://ip:port/your.m3u` 访问：

```
docker run -d --name=pixman -p 5000:5000 -v /path/to/yours:/app/app/data/m3u --restart=always pixman/pixman

# 挂载后，将 m3u 文件放到 /path/to/yours 目录下，然后通过 http://ip:port/your.m3u 访问
```

当需要更新镜像时，可以使用以下命令：

```
# 停止目前正在运行的容器
docker stop pixman

# 删除目前正在运行的容器
docker rm pixman

# 删除旧的镜像
docker rmi pixman/pixman

# 重新拉取最新的镜像
docker pull pixman/pixman

# 运行最新的镜像
docker run -d --name=pixman -p 5000:5000 --restart=always pixman/pixman
```

### 使用 docker-compose 运行

新建一个 `docker-compose.yml` 文件，内容如下：

```
services:
  pixman:
    image: pixman/pixman
    restart: always
    container_name: pixman
    environment:
      - http_proxy=http://192.168.50.50:7890
      - https_proxy=http://192.168.50.50:7890
      - MYTVSUPER_TOKEN=YOUR_TOKEN
      - HAMI_SESSION_ID=YOUR_SESSION_ID
      - HAMI_SERIAL_NO=YOUR_SERIAL_NO
      - HAMI_SESSION_IP=YOUR_SESSION_IP
    ports:
      - 5050:5000
```

然后在 `docker-compose.yml` 文件所在目录运行以下命令：

```
docker compose up -d
```

当需要更新镜像时，可以使用以下命令：

```
# 停止并删除目前正在运行的容器
docker compose down

# 拉取最新的镜像
docker compose pull

# 运行最新的镜像
docker compose up -d
```

## 支持的命令

```
# 清理缓存
docker exec pixman sh -c 'flask clean_cache'

# 更新 mytvsuper_tivimate.m3u 文件
docker exec pixman sh -c 'flask mytvsuper_tivimate'
```

## 代理规则

容器会请求以下域名或 IP，常见的 Clash 内核软件或 Surge 软件的规则配置如下：

```
rules:
  # 国内
  - DOMAIN-SUFFIX,dnsany.com,DIRECT
  - DOMAIN-SUFFIX,cmvideo.cn,DIRECT
  - DOMAIN-SUFFIX,chinamobile.com,DIRECT
  - DOMAIN-SUFFIX,mobaibox.com,DIRECT
  - DOMAIN-SUFFIX,gitv.tv,DIRECT
  - DOMAIN-SUFFIX,cctv.cn,DIRECT
  - DOMAIN-SUFFIX,yangshipin.cn,DIRECT
  - DOMAIN-SUFFIX,gcable.cn,DIRECT
  - IP-CIDR,183.206.0.0/15,DIRECT,no-resolve
  - IP-CIDR,223.5.5.5/32,DIRECT,no-resolve
  - IP-CIDR,27.36.0.0/14,DIRECT,no-resolve
  - IP-CIDR,183.238.66.0/24,DIRECT,no-resolve

  # 自行测试当地是否能够直连，不能直连删掉下面这行
  - DOMAIN,beesport.livednow.com,DIRECT

  # 台湾
  - DOMAIN-SUFFIX,cdn.hinet.net,Taiwan

  # 海外
  - DOMAIN-SUFFIX,livednow.com,Proxy
  - DOMAIN-SUFFIX,orz-7.com,Proxy
  - DOMAIN-SUFFIX,4gtv.tv,Proxy
  - DOMAIN-SUFFIX,hinet.net,Proxy
  - DOMAIN-SUFFIX,ofiii.com,Proxy
  - DOMAIN-SUFFIX,googlevideo.com,Proxy
  - DOMAIN-SUFFIX,youtube.com,Proxy
  - DOMAIN-SUFFIX,mytvsuper.com,Proxy
  - DOMAIN-SUFFIX,thetvapp.to,Proxy
```

## 支持的直播源

- 四季線上 4GTV (

  ```
  http://ip:port/4gtv.m3u
  ```

  )

  - [四季線上 4GTV 解析播放代码 第一弹](https://pixman.io/topics/10)
  - [四季線上 4GTV 无需解锁代理播放 第二弹](https://pixman.io/topics/12)
  - [四季線上 4GTV 免费播放全部频道 第三弹](https://pixman.io/topics/13)

- 江苏移动魔百盒 TPTV (

  ```
  http://ip:port/tptv.m3u
  ```

   

  或

   

  ```
  http://ip:port/tptv_proxy.m3u
  ```

  )

  - [江苏移动魔百盒 全国 CDN 版本](https://pixman.io/topics/16)
  - [Nginx 代理 TPTV 和 iTV](https://pixman.io/topics/39)
  - [江苏移动 IPTV 频道更新](https://pixman.io/topics/36)

- 央视频直播源 (

  ```
  http://ip:port/ysp.m3u
  ```

  )

  - [抛砖引玉 央视频直播源已发布](https://pixman.io/topics/21)

- LITV 直播源 (合并到 4gtv)

  - [LITV 切片代理源已更新到 Docker image pixman/pixman](https://pixman.io/topics/23)

- YouTube 直播源 (

  ```
  http://ip:port/youtube/{VIDEO_ID}
  ```

  )

  - [pixman 已支持 YouTube 直播源拉取](https://pixman.io/topics/27)
  - [YouTube 直播支持通过播放列表生成 M3U](https://pixman.io/topics/29)

- MytvSuper 直播源 (

  ```
  http://ip:port/mytvsuper.m3u
  ```

  )

  - [pixman 已支持 MytvSuper 直播源](https://pixman.io/topics/31)

- Beesport 直播源 (

  ```
  http://ip:port/beesport.m3u
  ```

  )

  - [pixman 新增一批体育频道](https://pixman.io/topics/33)

- 中国移动 iTV 平台 (

  ```
  http://ip:port/itv.m3u
  ```

   

  或

   

  ```
  http://ip:port/itv_proxy.m3u
  ```

  )

  - [无需 IPV6，三网通看移动 iTV 直播源](https://pixman.io/topics/37)
  - [Nginx 代理 TPTV 和 iTV](https://pixman.io/topics/39)

- ~~四川广电蜀小果~~

- TheTV (`http://ip:port/thetv.m3u`)

- Hami Video (

  ```
  http://ip:port/hami.m3u
  ```

  )

  - [pixman 新增 Hamivideo 支持](https://pixman.io/topics/71)

## 更新日志
