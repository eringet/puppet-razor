# == Class: razor::server::service

class razor::server::service {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  $service_name   = pick($::razor::server::service_name,   'razor-server')
  $service_ensure = pick($::razor::server::service_ensure, 'running')
  $service_enable = pick($::razor::server::service_enable, true)

  validate_string($service_name)

  validate_string($service_ensure)
  validate_re($service_ensure, '^(running|stopped|[._0-9a-zA-Z:-]+)$')

  validate_bool($service_enable)

  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
  }
}
