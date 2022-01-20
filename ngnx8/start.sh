#!/bin/bash
#chown -R www-data /var/www/project
#chgrp -R www-data /var/www/project
# [https://tengine.taobao.org/nginx_docs/en/docs/faq/daemon_master_process_off.html]
# (Can I run nginx with “daemon off” or “master_process off” settings in a production environment?)
#nginx -g 'daemon off;'
# [https://docs.docker.com/engine/reference/run/#detached--d]
service nginx start
service php8.0-fpm start
/bin/bash
