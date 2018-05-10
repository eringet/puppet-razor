# == Class: razor::server::install
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

class razor::server::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  $package_name   = pick($::razor::server::package_name, 'razor-server')
  $package_ensure = pick($::razor::server::package_ensure, 'installed')

  validate_string($package_name)

  validate_string($package_ensure)
  validate_re($package_ensure, '^(present|latest|installed|[._0-9a-zA-Z:-]+)$')

  package { $package_name:
    ensure => $package_ensure,
  }

  archive { 'microkernel.tar':
    source       => 'http://links.puppetlabs.com/razor-microkernel-latest.tar',
    path         => '/tmp/microkernel.tar',
    proxy_server => $proxy_server,
    extract      => true,
    extract_path => $::razor::server::repo_store_root,
    creates      => $::razor::server::repo_store_root/microkernel,
  }
}
