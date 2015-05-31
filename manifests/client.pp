# == Class: razor:;client

class razor::client (
  $package_name     = 'razor-client',
  $package_ensure   = 'installed',
  $package_provider = undef
) {
  # Fail fast if we're not using a new Puppet version.
  if versioncmp($::puppetversion, '3.7.0') < 0 {
    fail('This module requires the use of Puppet v3.7.0 or newer.')
  }

  validate_string($package_name)

  validate_string($package_ensure)
  validate_re($package_ensure, '^(present|latest|nstalled|[._0-9a-zA-Z:-]+)$')

  package { $package_name:
    ensure   => $package_ensure,
    provider => $package_provider,
  }
}
