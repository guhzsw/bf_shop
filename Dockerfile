FROM php:7.4-apache

# 安装MySQL和PHP扩展依赖
RUN apt-get update && apt-get install -y \
    default-mysql-server \
    default-mysql-client \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    supervisor \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql mysqli zip

# 启用Apache模块
RUN a2enmod rewrite

# 设置工作目录
WORKDIR /var/www/html

# 复制项目文件
COPY . /var/www/html/

# 设置权限
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 777 /var/www/html/upload

# 配置Apache
RUN echo '<Directory /var/www/html/>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
    </Directory>' >> /etc/apache2/apache2.conf

# 配置Supervisor
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 设置启动脚本
COPY docker/start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

# 暴露端口
EXPOSE 80

# 启动服务
CMD ["/usr/local/bin/start.sh"]
