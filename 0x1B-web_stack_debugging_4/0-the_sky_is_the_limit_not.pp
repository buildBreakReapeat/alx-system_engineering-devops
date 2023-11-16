# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Stop and disable the default Nginx service
service { 'nginx':
  ensure => stopped,
  enable => false,
}

# Configure Nginx
file { '/etc/nginx/nginx.conf':
  ensure  => file,
  content => template('nginx/nginx.conf.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Define Nginx virtual host configuration
file { '/etc/nginx/conf.d/my_website.conf':
  ensure  => file,
  content => template('nginx/my_website.conf.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Increase the ULIMIT of the default file
exec { 'fix--for-nginx':
  command => 'sed -i "s/15/4096/" /etc/default/nginx',
  path    => '/usr/local/bin/:/bin',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Restart Nginx service
exec { 'nginx-restart':
  command => 'service nginx restart',
  path    => '/etc/init.d/',
  require => Exec['fix--for-nginx'],
  notify  => Service['nginx'],
}

# Start Nginx service
service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
  hasstatus  => true,
  subscribe  => [File['/etc/nginx/nginx.conf'], File['/etc/nginx/conf.d/my_website.conf'], Exec['nginx-restart']],
}
