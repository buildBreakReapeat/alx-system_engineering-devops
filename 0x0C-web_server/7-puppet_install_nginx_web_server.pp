# nginx config

package {
    'nginx':
    ensure => present,
}

file {'/var/www/html/index.nginx-debian.html':
    content => 'Hello World!',
}

file_line {'configure redirection':
    path  =>  '/etc/nginx/sites-available/default',
    after =>  'server_name _;',
    line  =>  "\nlocation /redirect_me {\n\treturn 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;\n}\n",
}

service {'nginx':
    ensure => running,
}
