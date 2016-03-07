# == Class: razor::server
#
# Copyright 2016 Joshua M. Keyes <joshua.michael.keyes@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class razor::server (
  $manage_database = true,
  $repo_store_root = '/var/lib/razor/repo-store',
  $db_hostname     = 'localhost',
  $db_database     = 'razor',
  $db_username     = 'razor',
  $db_password     = 'razor',
  $package_name    = undef,
  $package_ensure  = undef,
  $service_name    = undef,
  $service_ensure  = undef,
  $service_enable  = undef,
) {
  # Fail fast if we're not using a new Puppet version.
  if versioncmp($::puppetversion, '3.7.0') < 0 {
    fail('This module requires the use of Puppet v3.7.0 or newer.')
  }

  contain '::razor::server::install'
  contain '::razor::server::config'
  contain '::razor::server::service'

  if $manage_database {
    contain '::razor::server::database'

    Class['::razor::server::database'] ->
    Class['::razor::server::config']
  }

  Class['::razor::server::install'] ->
  Class['::razor::server::config'] ~>
  Class['::razor::server::service']
}
