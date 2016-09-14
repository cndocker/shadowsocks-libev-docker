# 一、Docker-Shadowsocks-libev 服务端
##1、介绍
基于Dockerfile文件编译出一个Shadowsocks-libev服务端的容器镜像。
##2、版本
[cndocker/shadowsocks-libev:1.0.20160914](https://hub.docker.com/r/cndocker/shadowsocks-libev/)
shadowsocks-libev 2.5.2
##3、问题
如何安装Docker

1)官网安装地址
```bash
curl -Lk https://get.docker.com/ | sh
```
2)阿里云安装地址
```bash
curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
```
RHEL、CentOS、Fedora的用户可以使用`setenforce 0`来禁用selinux以达到解决一些问题

如果你已经禁用了selinux并且使用的是最新版的Docker。

当你在issue 提交问题的时候请注意提供一下信息:
- 宿主机的发行版和版本号.
- 使用 `docker version` 命令来给出Docker版本信息.
- 使用 `docker info` 命令来给出进一步信息.
- 提供 `docker run` 命令的详情 (注意打码你的隐私信息).

# 二、安装
##1、基于docker的cndocker/shadowsocks-libev服务端安装方法
直接使用我们在 [Dockerhub](https://hub.docker.com/r/cndocker/shadowsocks-libev/) 上通过自动构建生成的镜像是最为推荐的方式

```bash
docker pull cndocker/shadowsocks-libev:latest
```
##2、下载镜像导入
从我们的项目中下载docker images后导入，镜像下载地址：
```bash
wget --no-check-certificate https://github.com/cndocker/shadowsocks-libev-docker/raw/master/images/docker-kcp-server.tar
```
###镜像MD5
    1e65b007fff171899d827268646af3a2  docker-shadowsocks-libev.tar

# 三、使用
##启动命令
```bash
docker run -dti --name=ss-server \
-p 8388:8388 \
-p 8388:8388/udp \
-e SS_SERVER_ADDR=0.0.0.0 \
-e SS_SERVER_PORT=8388 \
-e SS_PASSWORD=password \
-e SS_METHOD=aes-256-cfb \
-e SS_TIMEOUT=600 \
-e SS_DNS_ADDR=8.8.8.8 \
-e SS_UDP=true \
-e SS_ONETIME_AUTH=true \
-e SS_FAST_OPEN=true \
cndocker/shadowsocks-libev:latest
```

##变量说明（区分大小写）
| 变量名 | 默认值  | 描述 |
| :-------------- |:-----------:| :---------------------------------- |
| SS_SERVER_ADDR  |  0.0.0.0    | 提供服务的IP地址，建议使用默认的0.0.0.0  |
| SS_SERVER_PORT  |    8388     | SS提供服务的端口，TCP和UDP协议。        |
| SS_PASSWORD     |  password   | 服务密码                              |
| SS_METHOD       | aes-256-cfb | 加密方式，可选参数：table, rc4, rc4-md5, aes-128-cfb, aes-192-cfb, aes-256-cfb, bf-cfb, camellia-128-cfb, camellia-192-cfb, camellia-256-cfb, cast5-cfb, des-cfb, idea-cfb, rc2-cfb, seed-cfb, salsa20, chacha20 and chacha20-ietf |
| SS_TIMEOUT      |     600     | 连接超时时间                          |
| SS_DNS_ADDR     |   8.8.8.8   | SS服务器的DNS地址                     |
| SS_UDP          |     true    | 开启SS服务器 UDP relay                |
| SS_ONETIME_AUTH |     true    | 开启SS服务器 onetime authentication.  |
| SS_FAST_OPEN    |     true    | 开启SS服务器  TCP fast open.          |

