```
find ./  -regextype posix-extended ! -regex ".*\.(gif|jpg|png)"
```

# 匹配多中后缀名，[jpg|png]这种模式，其实等价于[j|p|n|g] 或者 [jpng]
```
sudo find -maxdepth 1 -regex '.*\.\(JPG\|PNG\|JPEG\|jpg\|jpeg\|png\)' -type f -mmin +720 -exec rm {} \;
```
