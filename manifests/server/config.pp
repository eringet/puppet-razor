# == Class: razor::server::config
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

class razor::server::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  validate_string($::razor::server::db_hostname)
  validate_string($::razor::server::db_database)
  validate_string($::razor::server::db_username)
  validate_string($::razor::server::db_password)

  validate_string($::razor::server::repo_store_root)

  file { '/etc/razor':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  } ->

  file { '/etc/razor/config.yaml':
    ensure  => file,
    content => template("${module_name}/config.yaml.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  } ->

  file { $::razor::server::repo_store_root:
    ensure => directory,
    owner  => 'razor',
    group  => 'razor',
    mode   => '0755',
  } ->

  staging::extract { 'microkernel.tar':
    creates => "${::razor::server::repo_store_root}/microkernel",
    target  => $::razor::server::repo_store_root,
    require => Staging::File['microkernel.tar'],
  }

  postgresql::validate_db_connection { 'razor_database_connection':
    database_host     => $::razor::server::db_hostname,
    database_name     => $::razor::server::db_database,
    database_username => $::razor::server::db_username,
    database_password => $::razor::server::db_password,
  } ->

  exec { 'migrate_razor_database':
    command => '/usr/sbin/razor-admin -e all migrate-database',
    unless  => '/usr/sbin/razor-admin -e all check-migrations',
  }
}
