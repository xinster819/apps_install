# python-2.7.10
python="Python-2.7.10"
libevent="libevent-2.0.22-stable"
sources="/opt/sources"
apps_install="/opt/apps_install"

if [[ ! -d "$apps_install/$python" ]] && [[ ! -f "$sources/$python_tar" ]]; then
mkdir -p $source
cd $sources
wget --no-check-certificate https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz
tar -zxvf Python-2.7.10.tgz
wget --no-check-certificate https://sourceforge.net/projects/levent/files/libevent/libevent-2.0/libevent-2.0.22-stable.tar.gz
tar -zxvf $libevent.tar.gz
cd $libevent
./configure
make && make install
fi

if [ ! -d "$apps_install/$python" ]; then
mkdir -p $apps_install/$python
cd $sources/$python
./configure --prefix=$apps_install/$python
make && make install
ln -s $apps_install/$python /opt/apps/python
fi
echo "all done"
