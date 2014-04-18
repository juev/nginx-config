server {
  listen 80;
  server_name vim.juev.ru;

  root /home/ubuntu/www/vim;
  index index.html;

  modern_browser unlisted;
  ancient_browser curl Wget;
  if ($ancient_browser){
    rewrite  ^  /vim.html;
    # rewrite  ^  https://raw.github.com/Juev/dotvim/master/install.sh permanent;
  }
  autoindex off;

  charset utf-8;

  try_files $uri $uri/ index.html;

  access_log  off;
  error_log   off;

  location ~ /\. {
    deny all;
    access_log      off;
    log_not_found   off;
  }

  location ~* ^.+\.(sh|html|htm|php|xml|html.gz)$ {
    add_header Cache-Control "max-age=0, no-cache";
    add_header "X-UA-Compatible" "IE=Edge,chrome=1";
  }

  location ~* ^.+\.(css|js|jpg|jpeg|gif|png|ico|gz|svg|svgz|ttf|otf|woff|eot|mp4|ogg|ogv|webm)$ {
    access_log off;
    add_header Cache-Control  "public, max-age=2592000";
  }
}
