# lua need install readline first; like:  yum install readline-devel
# 2015-11-19  lua-nginx-module 只支持5.1版本， 5.2及其以上都不支持
name=lua-5.1.5
simple_name=lua
name_tar=$name.tar.gz
download_url=http://www.lua.org/ftp/lua-5.1.5.tar.gz
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
mv $sources/$name $apps_install/$name
cd $apps_install/$name
make linux install
ln -snf $apps_install/$name /opt/apps/$simple_name
fi
chown -R resin:resin $apps_install/$name
echo "all done"
