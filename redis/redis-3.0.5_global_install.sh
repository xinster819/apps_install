# redis-3.0.5支持集群
# 如果需要搭建集群，需要在服务器安装ruby和rubygem，具体可以参照
#  sudo yum install ruby
#  sudo yum install gcc g++ make automake autoconf curl-devel openssl-devel zlib-devel httpd-devel apr-devel apr-util-devel sqlite-devel
#  sudo yum install ruby-rdoc ruby-devel
#  sudo yum install rubygems
#  gem install redis
#  启动一个cluster参见  http://redis.io/topics/cluster-tutorial
redis="redis-3.0.5"
redis_tar="$redis.tar.gz"
sources="/opt/sources"
apps_install="/opt/apps_install"

if [[ ! -d "$apps_install/$redis" ]] && [[ ! -f "$sources/$redis_tar" ]]; then
mkdir -p $source
cd $sources
wget -d /opt/sources/ http://download.redis.io/releases/redis-3.0.5.tar.gz
tar -zxvf $redis_tar
fi

if [ ! -d "$apps_install/$redis" ]; then
mkdir -p /opt/apps_install
mv $sources/$redis $apps_install/$redis
cd $apps_install/$redis
make
ln -s $apps_install/$redis /opt/apps/redis
fi

mkdir -p /opt/conf/redis
mkdir -p /opt/logs/redis
echo "all done"
