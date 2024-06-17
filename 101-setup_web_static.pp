# Define the file resources to ensure the directories are present
file { '/data':
  ensure => directory,
}

file { '/data/web_static':
  ensure => directory,
}

file { '/data/web_static/releases':
  ensure => directory,
}

file { '/data/web_static/shared':
  ensure => directory,
}

file { '/data/web_static/releases/test':
  ensure  => directory,
  require => File['/data/web_static/releases'],
}

# Create the index.html file in the test directory
file { '/data/web_static/releases/test/index.html':
  ensure  => file,
  content => '<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>',
  require => File['/data/web_static/releases/test'],
}

# Create the symbolic link
file { '/data/web_static/current':
  ensure  => link,
  target  => '/data/web_static/releases/test',
  require => File['/data/web_static/releases/test/index.html'],
}

# Ensure proper permissions for the created directories and files
file { ['/data', '/data/web_static', '/data/web_static/releases', '/data/web_static/shared', '/data/web_static/releases/test', '/data/web_static/releases/test/index.html']:
  ensure => directory,
  owner  => 'ubuntu',
  group  => 'ubuntu',
  mode   => '0755',
  require => File['/data'],
}

