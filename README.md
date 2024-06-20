# box.sh

移动云手机VMESS免流节点搭建脚本

# 使用说明

- 脚本基于sing-box最新稳定版编写
- sing-box项目地址: https://github.com/SagerNet/sing-box
- 需要先root云手机,执行命令前终端先获取root权限[su] [必须！必须！必须！]
- 搭建好的VMESS节点导入代理软件时[v2rayNG]需要更改端口才可以连接
- 获取端口需要使用抓包软件抓取移动云手机APP的UDP包的端口
- VMESS节点自带头条免流混淆[已测试联通,电信]
- 终端推荐使用 MT管理器
- 抓包软件推荐使用 黄鸟
- ROOT工具推荐使用 面具

- 此脚本仅供技术交流请在执行此脚本后的24小时内删除!

 # 注意&注意&注意
 - 如果使用MT管理器作为终端的话首次打开终端时会提示安装扩展包,请不要安装！请不要安装！请不要安装！

# 一键安装命令

```
curl -Lo /bin/box https://raw.githubusercontent.com/wuxin-52067/shell/main/box.sh && chmod 777 /bin/box && box
```

## 快捷启动
- 终端输入 box 即可呼出菜单
```
box
```

## 图文说明
<img src="https://icdn.binmt.cc/2406/667372b94966a.png" alt="alt text" title="title" width="300"/>
以上是一键安装命令执行完成后截图
<img src="https://icdn.binmt.cc/2406/667377cb1a932.png" alt="alt text" title="title" width="300"/>
以上是开启代理执行完成后截图
这里我就说一下端口,默认是10003因为我测试的时候使用的是云手机标准版,标准版的端口基本上都是10003,如果你的云手机是别的套餐版本可以使用 netstat -anu 命令查看端口是多少
<img src="https://icdn.binmt.cc/2406/66737a8c10161.png" alt="alt text" title="title" width="300"/>
以上是执行 netstat -anu 命令后的截图 请认准10.开头IP后的端口
<img src="https://icdn.binmt.cc/2406/667377cb1a932.png" alt="alt text" title="title" width="300"/>&nbsp;&nbsp;&nbsp;<img src="https://icdn.binmt.cc/2406/667372b94966a.png" alt="alt text" title="title" width="300"/>


