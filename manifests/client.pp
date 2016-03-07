# == Class: razor:;client
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
  validate_re($package_ensure, '^(present|latest|installed|[._0-9a-zA-Z:-]+)$')

  package { $package_name:
    ensure   => $package_ensure,
    provider => $package_provider,
  }
}
