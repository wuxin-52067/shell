# box.sh

移动云手机VMESS免流节点搭建脚本

# 使用说明

- 脚本基于sing-box最新稳定版编写
- sing-box项目地址: https://github.com/SagerNet/sing-box
- 需要先root云手机,执行命令前终端先获取root权限[su]
- 搭建好的VMESS节点导入代理软件时[v2rayNG]需要更改端口才可以连接
- 获取端口需要使用抓包软件抓取移动云手机APP的UDP包的端口
- VMESS节点自带头条免流混淆[已测试联通,电信]
- 终端推荐使用 MT管理器
- 抓包软件推荐使用 黄鸟

- 此脚本仅供技术交流请在使用此脚本后的24小时内删除!

 # 注意&注意&注意
 - 如果使用MT管理器作为终端的话首次打开终端时会提示安装扩展包,请不要安装！请不要安装！请不要安装！

# 一键安装命令

```
curl -Lo /bin/box https://raw.githubusercontent.com/wuxin-52067/shell/main/box.sh && chmod 777 /bin/box && box
```

## 快捷启动【脚本菜单】
```
box
```

## 快捷停止
```
./data/box.sh stop
```
