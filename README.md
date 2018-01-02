# dovecot

[![Build Status](https://travis-ci.org/wwkimball/wwkimball-dovecot.svg?branch=master)](https://travis-ci.org/wwkimball/wwkimball-dovecot) [![Version](https://img.shields.io/puppetforge/v/wwkimball/dovecot.svg)](https://forge.puppet.com/wwkimball/dovecot) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/3bfb5fb2b84042cf972b468eb1418b80)](https://www.codacy.com/app/wwkimball/wwkimball-dovecot?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=wwkimball/wwkimball-dovecot&amp;utm_campaign=Badge_Grade) [![Coverage Status](https://coveralls.io/repos/github/wwkimball/wwkimball-dovecot/badge.svg?branch=master)](https://coveralls.io/github/wwkimball/wwkimball-dovecot?branch=master)

### Foreword

The original author of this module has long promoted a line of thinking that
builds off of **Infrastructure As Code** into **Infrastructure As Data**.  With
Hiera and modules like this, end-users can simply import the code they need and
then fully express their entire enterprise infrastructure purely as data without
any more code to write or support (not even antiquated roles/profiles).  As
such, all examples in this document and the module's in-file documentation are
presented strictly as YAML.

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

This module was written from scratch, specifically for Puppet 5 and Hiera 5 to fully manage dovecot; nothing more and nothing less.  No assumptions are made as to what you intend to do with dovecot other than enjoy full control over it via Hiera in every respect.

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

Pre-generated, web-accessible reference documentation -- with abundant **examples** -- can be found at [GitHub Pages for this project](https://wwkimball.github.io/wwkimball-dovecot/puppet_classes/dovecot.html), generated via [Puppet Strings](https://github.com/puppetlabs/puppet-strings).  If you do not have access to this on-line documentation, please just run `bundle install && bundle exec rake strings:generate` from this module's top directory to have a local copy of the documentation generated for you in the [docs](docs/index.html) directory.

## Limitations

Please refer to the *operatingsystem_support* section of [metadata.json](metadata.json) for known, proven-in-production OS compatibility.  This is not an exhaustive list.  You will very likely find that this module runs just fine on other operating system and version combinations, given the proper inputs.  In fact, if you do, please report it back so the metadata can be updated!

## Development

Please refer to [CONTRIBUTING](CONTRIBUTING.md) to learn how to hack this module.
