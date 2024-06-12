# box.sh

移动云手机VMESS免流节点搭建脚本

# 注意事项&使用说明

- 脚本基于sing-box最新稳定版编写
- sing-box项目地址: https://github.com/SagerNet/sing-box
- 需要先root云手机,执行命令前终端先获取root权限[su]
- 因为移动云手机的传输端口是固定的所以不可修改端口[脚本不提供端口修改]
- 搭建好的VMESS节点导入代理软件时[v2rayNG]需要更改端口才可以连接
- 端口需要使用抓包软件抓取移动云手机APP的UDP包的端口
- VMESS节点自带头条免流混淆[已测试联通,电信]
- 终端推荐使用 MT管理器
- 抓包软件推荐使用 黄鸟

# 一键安装命令

```
curl -Lo /data/box.sh https://raw.githubusercontent.com/wuxin-52067/shell/main/box.sh && cd /data && chmod 777 box.sh && ./box.sh start
```

## 快捷启动
```
./data/box.sh start
```

## 快捷停止
```
./data/box.sh stop
```