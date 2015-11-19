port=$1
mkdir -p /opt/conf/redis/$port
mkdir -p /opt/data/redis/$port
mkdir -p /opt/logs/redis/$port
cp ./redis.conf /opt/conf/redis/$port/$port.conf
sed -i "s/##port##/$port/" /opt/conf/redis/$port/$port.conf
/opt/apps/redis/src/redis-server /opt/conf/redis/$port/$port.conf
