FROM nginx:alpine
# インクルード用のディレクトリ内を削除
RUN rm -f /etc/nginx/conf.d/*
# Nginxの設定ファイルをコンテナにコピー
ADD ./nginx/hangartalk.conf /etc/nginx/conf.d/hangartalk.conf
ADD ./nginx/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/log/nginx

# ビルド完了後にNginxを起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf