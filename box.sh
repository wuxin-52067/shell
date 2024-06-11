system="/data/box"

show(){
clear
echo ""
echo "########################################"
echo -e "#                                      #"
echo -e "#     \033[33m移动云手机 VMESS一键搭建脚本\033[0m     #"
echo -e "# \033[32m作者\033[0m: by の 吾心                     #"
echo -e "# \033[32m企鹅\033[0m: 958901541                      #"
echo -e "#                                      #"
echo "########################################"
echo ""
}

start_proxy(){
PORT=10003
DNS="https://223.5.5.5/dns-query"
IPV4=$(curl -s ipv4.ip.sb)
config='{"log":{"level":"info","disabled":true},"dns":{"servers":[{"address":"'$DNS'"}]},"inbounds":[{"type":"vmess","listen":"::","listen_port":'$PORT',"users":[{"uuid":"'$1'","alterId":0}],"transport":{"type":"'$2'"}}],"outbounds":[{"type":"direct"},{"type":"dns","tag":"dns-out"}],"route":{"rules":[{"protocol":"dns","outbound":"dns-out"}]}}'
echo "$config" > config.json
chmod 777 sing-box
./sing-box run -c config.json >/dev/null 2>&1 &
if [ "$2" == "http" ]; then
echo "\E[1;36mvmess://"$(echo '{"add":"'$IPV4'","aid":"0","alpn":"","fp":"","host":"is.snssdk.com","id":"'$1'","net":"tcp","path":"/","port":"443","ps":"移动云","scy":"auto","sni":"","tls":"","type":"http","v":"2"}' | base64)
else
echo "\E[1;36mvmess://"$(echo '{"add":"'$IPV4'","aid":"0","alpn":"","fp":"","host":"is.snssdk.com","id":"'$1'","net":"ws","path":"/","port":"443","ps":"移动云","scy":"auto","sni":"","tls":"","type":"","v":"2"}' | base64)
fi
echo ""
echo "\033[32m代理状态: 已开启"
}

rm_config(){
rm $system/config.json
}

stop_proxy(){
show
rm_config >/dev/null 2>&1
killall sing-box >/dev/null 2>&1
echo "\033[31m代理状态: 已关闭"
}

get_singbox(){
if [ ! -d $system ];then
mkdir $system
cd $system
VERSION=$(curl -s https://api.github.com/repos/SagerNet/sing-box/releases/latest \
    | grep tag_name \
    | cut -d ":" -f2 \
    | sed 's/\"//g;s/\,//g;s/\ //g;s/v//')
curl -Lo sing-box-$VERSION-android-arm64.tar.gz "https://github.com/SagerNet/sing-box/releases/download/v$VERSION/sing-box-$VERSION-android-arm64.tar.gz"
tar -xf sing-box-$VERSION-android-arm64.tar.gz -C $system
mv $system/sing-box-$VERSION-android-arm64/sing-box $system
rm -rf sing-box-$VERSION-android-arm64
rm sing-box-$VERSION-android-arm64.tar.gz
else
cd $system
fi
}

init(){
show
echo "请输入UUID [默认随机]"
read uuid
if [ "$uuid" == "" ];then
uuid=$(cat /proc/sys/kernel/random/uuid)
fi
while true; do
echo "请输入传输协议 [http,ws][默认http]"
read tra
if [ "$tra" == "" ]; then
tra="http"
break
elif [ "$tra" == "http" ] || [ "$tra" == "ws" ]; then
break
else
echo "输入无效,请重新输入http或ws"
fi
done
start_proxy $uuid $tra
}

case "$1" in
start)
get_singbox
PS=`ps -fe | grep sing-box | grep -v grep | wc -l`
if [ $PS -eq 0 ];then
init
else
clear
echo ""
echo "\033[32m代理状态: 已开启"
fi
;;
stop)
stop_proxy
;;
*)
echo ""
echo "参数错误: 用法[start,stop]"
exit 1
;;
esac
