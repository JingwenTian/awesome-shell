#########################################################################
# File Name: ab.sh [AB压力测试POST请求]
# Author: jingwentian
# mail: mini.mosquitor@gmail.com
# Created Time: 二  2/23 12:51:27 2016
#########################################################################
#!/bin/bash

# post.json 是当前目录下你想post的json数据文件
# -p 执行post请求
# -H 添加的header头信息
# -T 设置文档类型
# -c 并发数
# -n 请求数


ab -p post.json -T application/json -H 'Authorization: Token abcd1234' -c 10 -n 2000 http://example.com/api/

#详细示例

ab -p post.json -T application/json -H 'Cookie: CN_COOKIE_SESSIONID=12334452; errorNum=0' -H 'Origin: http://example.com' -H 'Accept-Encoding: gzip, deflate' -H 'X-CSRF-TOKEN: 123456' -H 'Accept-Language: zh-CN,zh;' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1' -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Referer: http://example.com' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' -c 10 -n 100 http://example.com/api/
