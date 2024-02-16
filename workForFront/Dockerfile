FROM nginx
# 移除默认的NGINX配置
RUN rm /etc/nginx/conf.d/default.conf

# 复制NGINX配置文件到容器中
COPY https_default.conf /etc/nginx/conf.d/default.conf
COPY dist/ /usr/share/nginx/html/
#创建ssl目录
RUN mkdir /etc/nginx/ssl

# 将CA证书复制到容器中的/etc/nginx/ssl/目录
COPY .plugin/www.yueyvlunhui.cn_chain.crt /etc/nginx/ssl/
COPY .plugin/www.yueyvlunhui.cn_key.key /etc/nginx/ssl/
# 暴露NGINX的端口
EXPOSE 443