limit_conn_zone $binary_remote_addr zone=addr:10m;

server {
  server_name  juev.ru juev.org www.juev.ru;
  rewrite ^(.*) http://www.juev.org$1 permanent;
}

server {
  listen 80;
  server_name www.juev.org;
  charset utf-8;

  access_log  /home/user/logs/juevru/access.log;
  error_log   /home/user/logs/juevru/error.log;

  client_max_body_size 5M;


  location ~* \.(db|hbs|conf)$  { deny all; }
  location ~ /\.ht { deny all; }
  location ~ /\. { deny all; }
  location ~ ~$  { deny all; }

  location ~ ^/(robots\.txt|favicon\.ico) {
    root /home/user/web/seo/;
    expires 30d;
    access_log off;
  }

#  location ~ ^/assets/(img|js|css|fonts)/  {
#    root /home/user/web/ghost/content/themes/juev;
#    expires 30d;
#    access_log off;
#  }
#
#  location ~ ^/(img/|css/|lib/|vendor/|fonts/) {
#    root /home/user/web/ghost/content/themes/juev/assets;
#    expires 30d;
#    access_log off;
#  }

  location ~ ^/(content/images/) {
    root /home/user/web/ghost;
    expires 30d;
    access_log off;
  }

  rewrite ^/atom.xml /rss/ permanent;
  
  location / {
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header HOST $http_host;
    proxy_set_header X-NginX-Proxy true;

    proxy_pass http://proxy_app;
  }
}

upstream proxy_app {
    # Use the default ghost port (2368)
    server 127.0.0.1:2368;
}
