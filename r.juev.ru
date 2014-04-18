server {
  listen 80;
  server_name reader.juev.ru;

  root /home/ubuntu/www/miniflux;
  index index.php;
  autoindex off;

  charset utf-8;

  location / {
    try_files $uri $uri/ =404;
  }

  access_log  off;
  error_log   /home/ubuntu/logs/miniflux/error.log;

  location ~ /\. {
    deny all;
    access_log      off;
    log_not_found   off;
  }

  location ~ /data {
    deny all;
    access_log      off;
    log_not_found   off;
  }

  location ~ \.php$ {
    fastcgi_pass unix:/var/run/php5-fpm.sock;
    # fastcgi_pass 127.0.0.1:9000;
    fastcgi_index index.php;
    include fastcgi_params;
  }
}
