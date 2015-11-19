# memcached-1.4.24
memcached="memcached-1.4.24"
memcached_tar="$memcached.tar.gz"
libevent="libevent-2.0.22-stable"
sources="/opt/sources"
apps_install="/opt/apps_install"

if [[ ! -d "$apps_install/$memcached" ]] && [[ ! -f "$sources/$memcached_tar" ]]; then
mkdir -p $source
cd $sources
wget http://www.memcached.org/files/memcached-1.4.24.tar.gz
tar -zxvf $memcached_tar
wget --no-check-certificate https://sourceforge.net/projects/levent/files/libevent/libevent-2.0/libevent-2.0.22-stable.tar.gz
tar -zxvf $libevent.tar.gz
cd $libevent
./configure
make && make install
fi

if [ ! -d "$apps_install/$memcached" ]; then
mkdir -p $apps_install/$memcached
cd $sources/$memcached
./configure --prefix=$apps_install/$memcached
make && make install
ln -s $apps_install/$memcached /opt/apps/memcached
fi
echo "all done"
