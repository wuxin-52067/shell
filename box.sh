system="/bin"

show(){
clear
echo "\033[0m"
echo "##############################################"
echo -e "#                                            #"
echo -e "#     \033[33m移动云手机 VMESS一键搭建脚本\033[0m           #"
echo -e "# \033[32m作者\033[0m: by の 吾心                           #"
echo -e "# \033[32m项目\033[0m: https://github.com/wuxin-52067/shell #"
echo -e "#                                            #"
echo "##############################################"
}

start_proxy(){
echo ""
echo "\033[33m正在启动..."
if [ ! -f $system/boxs ]; then
DNS="https://223.5.5.5/dns-query"
IPV4=$(curl -s ipv4.ip.sb)
IPV6=$(curl -s ipv6.ip.sb)
config='{"log":{"level":"info","disabled":true},"dns":{"servers":[{"address":"'$DNS'"}]},"inbounds":[{"type":"vmess","listen":"::","listen_port":'$3',"users":[{"uuid":"'$1'","alterId":0}],"transport":{"type":"'$2'"}}],"outbounds":[{"type":"direct"},{"type":"dns","tag":"dns-out"}],"route":{"rules":[{"protocol":"dns","outbound":"dns-out"}]}}'
if [ "$2" == "http" ]; then
vIPV4="vmess://"$(echo '{"add":"'$IPV4'","aid":"0","alpn":"","fp":"","host":"is.snssdk.com","id":"'$1'","net":"tcp","path":"/","port":"'$3'","ps":"移动云-v4","scy":"auto","sni":"","tls":"","type":"http","v":"2"}' | base64 -w 0)
vIPV6="vmess://"$(echo '{"add":"'$IPV6'","aid":"0","alpn":"","fp":"","host":"is.snssdk.com","id":"'$1'","net":"tcp","path":"/","port":"'$3'","ps":"移动云-v6","scy":"auto","sni":"","tls":"","type":"http","v":"2"}' | base64 -w 0)
else
vIPV4="vmess://"$(echo '{"add":"'$IPV4'","aid":"0","alpn":"","fp":"","host":"is.snssdk.com","id":"'$1'","net":"ws","path":"/","port":"'$3'","ps":"移动云-v4","scy":"auto","sni":"","tls":"","type":"","v":"2"}' | base64 -w 0)
vIPV6="vmess://"$(echo '{"add":"'$IPV6'","aid":"0","alpn":"","fp":"","host":"is.snssdk.com","id":"'$1'","net":"ws","path":"/","port":"'$3'","ps":"移动云-v6","scy":"auto","sni":"","tls":"","type":"","v":"2"}' | base64 -w 0)
fi
echo "$config\n//v4=$vIPV4\n//v6=$vIPV6" > $system/boxs
fi
chmod 777 $system/sing-box
$system/sing-box run -c boxs >/dev/null 2>&1 &
echo ""
echo "\033[32m代理状态: ✅"
v4=$(grep '^//v4=' $system/boxs | cut -d '=' -f 2)
v6=$(grep '^//v6=' $system/boxs | cut -d '=' -f 2)
echo ""
echo "\033[33mIPV4节点 :"
echo "\033[36m$v4"
echo ""
echo "\033[33mIPV6节点 :"
echo "\033[36m$v6"
echo ""
}

get_singbox(){
clear
if [ ! -f $system/sing-box ]; then
VERSION=$(curl -s https://api.github.com/repos/SagerNet/sing-box/releases/latest \
    | grep tag_name \
    | cut -d ":" -f2 \
    | sed 's/\"//g;s/\,//g;s/\ //g;s/v//')
rm -rf $system/sing-box-$VERSION-android-arm64
rm -f $system/sing-box-$VERSION-android-arm64.tar.gz
curl -Lo $system/sing-box-$VERSION-android-arm64.tar.gz "https://github.com/SagerNet/sing-box/releases/download/v$VERSION/sing-box-$VERSION-android-arm64.tar.gz"
if [ $? -eq 0 ]; then
tar -xf $system/sing-box-$VERSION-android-arm64.tar.gz -C $system
mv $system/sing-box-$VERSION-android-arm64/sing-box $system
rm -rf $system/sing-box-$VERSION-android-arm64
rm -f $system/sing-box-$VERSION-android-arm64.tar.gz
else
clear
show
echo ""
echo "❎ 无法下载核心文件请检查网络是否正常!"
echo ""
fi
fi
}

init_vmess(){
echo "请输入UUID [默认随机]"
read uuid
if [ "$uuid" == "" ]; then
uuid=$(cat /proc/sys/kernel/random/uuid)
fi
while true; do
echo "\033[32m请输入传输协议 [http,ws][默认http]"
read tra
if [ "$tra" == "" ]; then
tra="http"
break
elif [ "$tra" == "http" ] || [ "$tra" == "ws" ]; then
break
else
echo "\033[31m\n输入无效,请重新输入[http,ws]\n"
fi
done
echo "请输入端口 [默认10003]"
read ports
if [ "$ports" == "" ]; then
ports=10003
fi
start_proxy $uuid $tra $ports
}

main(){
get_singbox
show
PS=`ps -fe | grep sing-box | grep -v grep | wc -l`
if [ $PS -eq 0 ]; then
echo ""
echo "\033[32m代理状态: ❎"
else
echo ""
echo "\033[32m代理状态: ✅"
fi
echo ""
echo "1. 开启代理"
echo "2. 关闭代理"
echo "3. 重启代理"
echo "4. 重置核心"
echo "5. 卸载核心"
echo "6. 退出脚本"
echo ""
echo "请输入选项[1~6]"
read str
if [ "$str" == "1" ]; then
if [ $PS -eq 0 ]; then
if [ ! -f $system/boxs ]; then
init_vmess
else
start_proxy
fi
else
echo ""
echo "\033[32m代理状态: ✅"
echo ""
fi
elif [ "$str" == "2" ]; then
killall sing-box >/dev/null 2>&1
echo ""
echo "\033[31m代理状态: ❎"
echo ""
elif [ "$str" == "3" ]; then
if [ $PS -eq 0 ]; then
echo ""
echo "\033[31m代理状态: ❎"
echo ""
else
killall sing-box >/dev/null 2>&1
echo ""
echo "\033[32m正在重启..."
sleep 1
start_proxy
fi
elif [ "$str" == "4" ]; then
if [ ! $PS -eq 0 ]; then
killall sing-box >/dev/null 2>&1
fi
rm -f $system/boxs
echo ""
echo "\033[32m🔰核心所有已重置"
echo ""
elif [ "$str" == "5" ]; then
if [ ! $PS -eq 0 ]; then
killall sing-box >/dev/null 2>&1
fi
rm -f $system/boxs
rm -f $system/sing-box
rm -f $system/box
echo ""
echo "\033[33m🔰核心已卸载"
echo ""
elif [ "$str" == "6" ]; then
echo ""
echo "\033[33m🔰脚本已退出"
echo ""
exit 1
else
clear
main
fi
}

main
