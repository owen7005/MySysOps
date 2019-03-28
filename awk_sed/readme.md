## awk
倒数第3和第4是状态码
```
awk '$(NF-3) == "[502]" || $(NF-2) == "[502]" {print $0}'  logfile
```
2，计算0-23每个小时日志访问量
```
awk -F'"|:' '{S[$2]++}END{for(i in S){print i"\t"S[i]}}' logfile | sort -n
```
3，查看各端口的进程数
```
ss -an | awk -F"[[:space:]]+|:" '{S[$5]++}END{for(i in S){print S[i]"\t"i}}' | sort -rn |more
```
4，计算当前一小时内每分钟的访问量
```
awk -F":" '$2 == hour {S[$3]++}END{for(i in S){print i"\t"S[i]}}' hour=`date +%H` logfile | sort -n
```
5，计算当前一分钟个域名访问量
```
awk -F'"|:' '$2 == hour && $3 == min && /GET/ {S[$8]++}END{for(i in S){print S[i]"\t"i}}' hour=`date +%H` min=`date +%M` logfile | sort -rn
```
```
ps -ef|awk '/[s]ersync2/{print $0}'
```

CentOS 7 网卡以eth命名

```
awk '/^GRUB_CMDLINE_LINUX/' /etc/default/grub|grep 'net.ifnames=0' || sed -ri 's/^(GRUB_CMDLINE_LINUX.*)(")$/\1 net.ifnames=0\2/' /etc/default/grub
awk '/^GRUB_CMDLINE_LINUX/' /etc/default/grub|grep 'biosdevname=0' || sed -ri 's/^(GRUB_CMDLINE_LINUX.*)(")$/\1 biosdevname=0\2/' /etc/default/grub
```

## 退出

```
ps aux|awk  '/ssh/{print $2;exit}'
```

## sed

sed取基名与目录名：

```
echo /etc/sysconfig/network-scripts/ | sed -r 's@(^/.*/)([^/]+/?)@\1@'
echo /etc/sysconfig/network-scripts/ | sed -r 's@(^/.*/)([^/]+/?)@\2@'
```

提取文章中的ip地址：

```
grep -oP '\d+\.\d+\.\d+\.\d+' file
awk '{for(i =1; i <=NF; i++){ if($i~/[0-9]\.[0-9]/) print $i}}' file
```

## 生成max地址

```
echo "$(hexdump -n3 -e'/3 "88:88:2F" 3/1 ":%02X"' /dev/random)"
```

## 创建用户并创建明文密码

```
useradd -p `openssl passwd -1 -salt 'salt' 123456` guest -o -u 0 -g root -G root -s /bin/bash -d /home/test
```

## 生成随机密码字符串

```
echo "$(date +"%s%N"| sha256sum | base64 | head -c 16)"
```

## 修改密码

修改为统一密码

```
echo "local.5B25BBCV.linuxea.com.cn" | passwd --stdin "root"
echo "local.linuxea.ds.com" | passwd --stdin "root"
```
修改为随机密码
```
Password=$(date +"%s%N"| sha256sum | base64 | head -c 24) && CPassword=$(python -c "import crypt, getpass;print crypt.crypt('${Password}')") && echo -e ${Password} && echo -e ${Password} |passwd --stdin "root"
```
创建一个用户并配置一个随机密码

```
Password=$(date +"%s%N"| sha256sum | base64 | head -c 24) && CPassword=$(python -c "import crypt, getpass;print crypt.crypt('${Password}')") && echo -e "$Password\n$CPassword" && useradd -p "$CPassword" php
```

创建一个用户加入组并设置一个随机密码

```
Password=$(date +"%s%N"| sha256sum | base64 | head -c 24) && CPassword=$(python -c "import crypt, getpass;print crypt.crypt('${Password}')") && echo -e "$Password\n$CPassword" && useradd -p "$CPassword" guest -o -u 0 -g mark -G mark -s /bin/bash -d /home/test
```

