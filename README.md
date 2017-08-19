# dovecot

[![Build Status](https://travis-ci.org/wwkimball/wwkimball-dovecot.svg?branch=master)](https://travis-ci.org/wwkimball/wwkimball-dovecot) [![Version](https://img.shields.io/puppetforge/v/wwkimball/dovecot.svg)](https://forge.puppet.com/wwkimball/dovecot)

### Foreword

The author of this module has long promoted a line of thinking that builds off of **Infrastructure As Code** into **Infrastructure As Data**.  With Hiera and modules like this, you can express your entire enterprise infrastructure purely as data without any more code for you to write or manage (not even antiquated roles/profiles when you use Hiera as your external node classifier and Facter for role assignments).  As such, all examples in this document and the module's in-file documentation are presented strictly as YAML.

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with dovecot](#setup)
    * [What dovecot affects](#what-dovecot-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with dovecot](#beginning-with-dovecot)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module was written from scratch, specifically for Puppet 5 and Hiera 5 to fully manage dovecot; nothing more and nothing less.  No assumptions are made as to what you intend to do with dovecot other than install or uninstall it and its plugins, configure it or delete its configuration files, and -- when not ignoring it -- keep its service running or not running.

Here, "fully manage" means this Puppet module:

* Installs, upgrades, downgrades, version-pins, and uninstalls dovecot and its plugins.
* Controls every line in every dovecot configuration file, both vendor- and user-supplied.
* Optionally controls the dovecot service.

This is one of a generation of Puppet modules that fully extends control over the subject resources to Hiera.  Use modules like this where you'd rather express your infrastructure as data without any further Puppet code beyond the modules that make this possible.

## Setup

### What dovecot affects

This module specifically affects the following resources:

* The primary dovecot package, or whatever it is named for your platform.
* Any set of dovecot plugin packages that you define, including what to do with them.
* Every line of every file in the dovecot configuration directory and its conf.d subdirectory.
* The dovecot service -- by any name -- if you so choose.

### Setup Requirements

Please refer to the *dependencies* section of [metadata.json](metadata.json) to learn what other modules this one needs, if any.

### Beginning with dovecot

At its simplest, you can install dovecot in its vendor-supplied default state merely with:

```
---
classes:
  - dovecot
```

## Usage

Many usage examples are provided via the source code documentation.  Refer to the [Reference](#reference) section to learn how to access it.

## Reference

This module is extensively documented via [Puppet Strings](https://github.com/puppetlabs/puppet-strings).  Pre-generated, web-accessible reference documentation can be found at [GitHub Pages for this project](https://wwkimball.github.io/wwkimball-dovecot/docs/puppet_classes/dovecot.html).

## Limitations

Please refer to the *operatingsystem_support* section of [metadata.json](metadata.json) for OS compatibility.  This is not an exhaustive list.  You will very likely find that this module runs just fine on other operating system and version combinations, given the proper inputs.

## Development

Please refer to [CONTRIBUTING](CONTRIBUTING.md) to learn how to hack this module.
