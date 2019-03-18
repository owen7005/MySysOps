
## 示例
```
mkdir /data/shell -p 
cat > /data/shell/cleanlog.sh << EOF
#!/bin/bash
[ ! -d /data/javalog/ ] || find /data/javalog/ -name '*.log*' -mtime +7 -exec rm {} \;
[ ! -d /data/javalog/ ] || find /data/javalog/ -name '*.log' -mtime +7 -exec rm {} \;
EOF
chmod +x /data/shell/cleanlog.sh
(crontab -l; echo -e "10 12 * * * /data/shell/cleanlog.sh" ) | crontab -
crontab -l|grep cleanlog
```

或者这样
```
#!/bin/bash
LSHPATH=/data/shell/
LSHFILE=/data/shell/cleanlog.sh
LOGPATH=/data/javalog/

[ -d ${LSHPATH} ] || mkdir ${LSHPATH} -p 
cat > ${LSHFILE} << EOF
#!/bin/bash
[ ! -d ${LOGPATH} ] || find ${LOGPATH} -name '*.log*' -mtime +10 -exec rm {} \;
EOF

chmod +x ${LSHFILE}
(crontab -l; echo -e "10 12 * * * ${LSHFILE}" ) | crontab -
```
## 
```
curl -Lk https://raw.githubusercontent.com/marksugar/MySysOps/master/log_clean/cleanlog.sh|bash
```
