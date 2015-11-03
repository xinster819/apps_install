resin="resin-4.0.46"
resin_tar="$resin.tar.gz"
sources="/opt/sources/"
apps_install="/opt/apps_install/"

if [[ ! -d "$apps_install$resin" ]] && [[ ! -f "$sources$resin_tar" ]]; then
mkdir -p $source
cd $sources
wget -d /opt/sources/ http://caucho.com/download/resin-4.0.46.tar.gz
tar -zxvf $resin_tar
fi

if [ ! -d "$apps_install$resin" ]; then
mkdir -p /opt/apps_install
mkdir -p /opt
cd $sources$resin
./configure --prefix=$apps_install$resin
make && make install
ln -snf $apps_install/$resin /opt/apps/resin
fi

mkdir -p /opt/conf/resin
mkdir -p /opt/logs/resin
useradd resin
chown -R resin:resin $apps_install$resin
echo "all done"
