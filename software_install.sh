name=$1
simple_name=$2
name_tar=$name.tar.gz
download_url=$3
sources="/opt/sources"
apps_install="/opt/apps_install"
if [[ ! -d "$apps_install/$name" ]] && [[ ! -f "$sources/$name_tar" ]]; then
mkdir -p $source
cd $sources
wget $download_url
tar -zxvf $name_tar
fi

if [ ! -d "$apps_install/$name" ]; then
mkdir -p /opt/apps_install
cd $sources/$name
./configure --prefix=$apps_install/$name
make && make install
ln -snf $apps_install/$name /opt/apps/$simple_name
fi

chown -R resin:resin $apps_install/$name
echo "all done"
