# == Define: docker:build
#
# Create image from provided Dockerfile
#

define docker::build(
  $image = $title,
  $tag   = 'latest',
  $content,
  $tmp = "/tmp/docker_build-${title}",
  ) {
  validate_re($image, '^[\S]*$')
  file {$tmp:
      ensure => directory,
      owner  => root,
      group  => docker,
      mode   => "750",
  }
  exec { "build-${image}-${tag}":
      cwd => $tmp,
      command => "docker build -t ${image}/${tag}",
      unless => "docker.io images ${image} | grep ${image} | grep -q ${tag}",
  }

}
