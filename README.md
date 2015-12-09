## Build

## source
git clone https://github.com/northwolf521/skynet-test.git
cd skynet-test
make

## redis
安装redis
安装mysql
安装protobuf

## Test
将scrit/metoo.sql导入到mysql<br/>
配置server/config/config.test文件中的mysql连接信息<br/>

## run
./script/redis.sh
./script/login.sh
./script/game.sh

lua client.lua login 80 1
lua client.lua roleinit 80 1 "metoo"
