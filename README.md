# Puppet Razor Module

[![Puppet Forge](http://img.shields.io/puppetforge/v/jmkeyes/razor.svg)](https://forge.puppetlabs.com/jmkeyes/razor)
[![Build Status](https://travis-ci.org/jmkeyes/puppet-razor.svg?branch=master)](https://travis-ci.org/jmkeyes/puppet-razor)

#### Table of Contents

 1. [Overview](#overview)
 2. [Description](#description)
 3. [Todo](#todo)
 4. [Contributors](#contributors)

## Overview

This module manages the installation and configuration of the Razor
provisioning engine and is intended to work with Puppet 3.x and 4.x.

## Description

This module contains two main classes:

  * `razor::server` (For deploying and managing the Razor server.)
  * `razor::client` (For managing the razor deployment remotely.)

More documentation will be available soon.

## Todo

  * The `razor-server` package and it's dependencies are not packaged with
    Puppet Collections, so if you're running Puppet 4.x, you will also need
    the original Puppet repositories. I may include a shim in this module.

  * This module does not setup or maintain the DHCP or TFTP servers. Those
    should be handled separately by following the Razor installation guide.

  * I'd like to see a native Puppet type/provider for managing Razor through
    it's API. A lot of Razor's configuration could be managed though it's API
    very effectively.

## Contributors

Thanks to the following people who have contributed to this module!

  * [Danny](https://github.com/kemra102)
