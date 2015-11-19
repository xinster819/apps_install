nginx="nginx-1.9.6"
nginx_tar="$nginx.tar.gz"
pcre="pcre-8.37"
ngx_devel_kil="ngx_devel_kit-0.2.19"
lua_nginx_module="lua-nginx-module-0.9.19"
sources="/opt/sources"
apps_install="/opt/apps_install"

#pre work
# 安装pcre, nginx的rewrite模块会用到，在安装pcre之前，需要先安装c++， 命令如： yum install gcc gcc-c++ autoconf automake
# 安装lua 5.1


if [[ ! -d "$apps_install/$nginx" ]] && [[ ! -f "$sources/$nginx_tar" ]]; then
mkdir -p $sources
cd $sources
wget http://nginx.org/download/$nginx_tar
tar -zxvf $nginx_tar
wget http://sourceforge.net/projects/pcre/files/pcre/8.37/pcre-8.37.tar.gz/download
tar -zxvf pcre-8.37.tar.gz
wget --no-check-certificate https://github.com/simpl/ngx_devel_kit/archive/v0.2.19.tar.gz
mv v0.2.19 v0.2.19.tar.gz
tar -zxvf v0.2.19.tar.gz
wget --no-check-certificate https://github.com/openresty/lua-nginx-module/archive/v0.9.19.tar.gz
mv v0.9.19 v0.9.19.tar.gz
tar -zxvf v0.9.19.tar.gz
fi

if [ ! -d "$apps_install/$nginx" ]; then
mkdir -p $apps_install/$nginx
cd $sources/$nginx
./configure --prefix=$apps_install/$nginx \
    --conf-path=/opt/conf/nginx/nginx.conf \
    --with-debug \
    --with-pcre=$sources/$pcre \
    --with-http_stub_status_module \
    --with-http_realip_module \
    --with-http_ssl_module \
    --with-ngx_http_memcached_module \
    --add-module=$sources/$ngx_devel_kil \
    --add-module=$sources/$lua_nginx_module \
    # memc-nginx-module-0.14 这个是对ngx_http_memcached_module的扩展，支持set、delete等操作，用处不大
    # --add-module=../memc-nginx-module-0.14 \
    # xss-nginx-module 支持在nginx层针对jsonp请求，处理
    # --add-module=../xss-nginx-module-0.04 \
    # headers-more-nginx-module 支持more_set、more_clear headers
    # --add-module=../headers-more-nginx-module-0.24 \
    # 支持md5等加密
    # --add-module=../set-misc-nginx-module-0.23 \
    # 支持memcached的一致性hash
    # --add-module=../nginx-upstream-consistent \
    # --add-module=../nginx-http-concat-1.2.2 \
    # --add-module=../ngx_http_substitutions_filter_module \
    # --add-module=../echo-nginx-module-0.50 \
make && make install
fi

mkdir -p /opt/conf/nginx
mkdir -p /opt/logs/nginx
useradd resin
chown -R resin:resin $apps_install/$nginx
echo "all done"
