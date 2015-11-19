nginx="nginx-1.9.6"
resin_tar="$nginx.tar.gz"
sources="/opt/sources"
apps_install="/opt/apps_install"
ngx_openresty=ngx_openresty-1.9.3.1

#pre work
# 安装pcre, nginx的rewrite模块会用到，在安装pcre之前，需要先安装c++， 命令如： yum install gcc gcc-c++ autoconf automake
sh ../software_intall.sh pcre-8.37 pcre http://sourceforge.net/projects/pcre/files/pcre/8.37/pcre-8.37.tar.gz/download
sh lua-5.3.1_intall.sh

if [[ ! -d "$apps_install/$nginx" ]] && [[ ! -f "$sources/$nginx_tar" ]]; then
mkdir -p $sources
cd $sources
wget http://nginx.org/download/nginx-1.9.6.tar.gz
tar -zxvf $nginx_tar
fi

cd $sources/$nginx
wget https://openresty.org/download/ngx_openresty-1.9.3.1.tar.gz --no-check-certificate
tar -zxvf ${ngx_openresty}.tar.gz

if [ ! -d "$apps_install/$nginx" ]; then
mkdir -p /opt/apps_install
./configure --prefix=$apps_install/$nginx \
    --conf-path=/opt/conf/nginx/nginx.conf \
    --with-debug \
    --with-pcre=$apps_install/pcre-8.37 \
    --with-http_stub_status_module \
    --with-http_realip_module \
    --with-http_ssl_module \
    # --add-module=../ngx_devel_kit-0.2.19 \
    --add-module=${ngx_openresty}/lua-nginx-module-0.9.3 \
    --add-module=../memc-nginx-module-0.14 \
    --add-module=../xss-nginx-module-0.04 \
    --add-module=../headers-more-nginx-module-0.24 \
    --add-module=../set-misc-nginx-module-0.23 \
    --add-module=../nginx-upstream-consistent \
    --add-module=../nginx-http-concat-1.2.2 \
    --add-module=../passport-$ppversion \
    --add-module=../saccounts-$saversion \
    --add-module=../ngx_http_substitutions_filter_module \
    --add-module=../echo-nginx-module-0.50 \
    | awk '/was configured/{print $0}'
fi

mkdir -p /opt/conf/nginx
mkdir -p /opt/logs/nginx
useradd resin
chown -R resin:resin $apps_install$resin
echo "all done"
