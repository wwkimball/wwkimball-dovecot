# Class: dovecot
#
# This module fully manages dovecot in every respect.
#
# @summary Fully manages dovecot.
#
# @param config_file_attributes Puppet attributes to apply to all dovecot
#  configuration files, per:
#  https://docs.puppet.com/puppet/latest/types/file.html#file-attributes.
#  Default is found in the data directory of this module's source and is applied
#  per this module's hiera.yaml.
# @param config_file_path Directory where all dovecot configuration files are
#  managed.  A conf.d subdirectory is implied and will be handled identically
#  to this directory.  Default is found in the data directory of this module's
#  source and is applied per this module's hiera.yaml.
# @param config_file_path_attributes Puppet attributes applied to
#  `config_file_path` and its implied conf.d subdirectory.  Default is found in
#  the data directory of this module's source and is applied per this module's
#  hiera.yaml.
# @param config_files Set of all configuration files found in the conf.d
#  subdirectory of `config_file_path` and their entire contents.  The structure
#  of this Hash is as follows:<br>
#  &nbsp; FILENAME:<br>
#  &nbsp;&nbsp;&nbsp; SIMPLE_KEY: SIMPLE_VALUE<br>
#  &nbsp;&nbsp;&nbsp; REPEATING_KEY:<br>
#  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - SIMPLE_VALUE<br>
#  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - SIMPLE_VALUE_N<br>
#  &nbsp;&nbsp;&nbsp; SECTION_NAME:<br>
#  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Any set of SECTION_KEY, REPEATING_KEY, and nested SECTION_NAME<br>
#  &nbsp; ...<br>
#  You can wholly remove any existing key and its entire value using the
#  knock-out prefix, `config_hash_key_knockout_prefix`, even if you don't
#  specify a lookup_options:dovecot::config_files:merge:knockout_prefix to
#  enable knocking out values and array elements.  The default value fully
#  comprises all vendor-supplied configuration files, without comments, and is
#  found in the data directory of this module's source and is applied per this
#  module's hiera.yaml.
# @param config_hash_key_knockout_prefix String of characters which, when
#  present as a prefix to any supporting Hash key, will cause that entire key
#  and its value to be removed from the resulting rendered configuration file.
#  Default is found in the data directory of this module's source and is applied
#  per this module's hiera.yaml.
# @param master_config Entire content of the primary dovecot.conf file expressed
#  as a Hash with structure:<br>
#  &nbsp; SIMPLE_KEY: SIMPLE_VALUE<br>
#  &nbsp; REPEATING_KEY:<br>
#  &nbsp;&nbsp;&nbsp; - SIMPLE_VALUE<br>
#  &nbsp;&nbsp;&nbsp; - SIMPLE_VALUE_N<br>
#  &nbsp; SECTION_NAME:<br>
#  &nbsp;&nbsp;&nbsp; Any set of SECTION_KEY, REPEATING_KEY, and nested SECTION_NAME<br>
#  &nbsp; ...<br>
#  You can wholly remove any existing key and its entire value using the
#  knock-out prefix, `config_hash_key_knockout_prefix`, even if you don't
#  specify a lookup_options:dovecot::master_config:merge:knockout_prefix.  The
#  default value fully comprises the vendor-supplied configuration for this
#  file, without comments, and is found in the data directory of this module's
#  source and is applied per this module's hiera.yaml.
# @param package_ensure Precise version number of the primary dovecot package to
#  install (and lock-in, blocking up/downgrades) or any Puppet token value to
#  more generically control the installed package version or to uninstall
#  dovecot, optionally purging all dovecot configuration files.  By default,
#  this package is merely installed without any up/downgrade management.
# @param package_name Name of the primary dovecot package to manage, per your
#  operating system and distribution.  Default is found in the data directory of
#  this module's source and is applied per this module's hiera.yaml.
# @param plugin_packages Set of dovecot plugin packages to manage.  The
#  structure of this Hash is as follows ([square-bracketed] keys are optional):<br>
#  &nbsp; PACKAGE_NAME:<br>
#  &nbsp;&nbsp;&nbsp; [ensure]:  https://docs.puppet.com/puppet/latest/types/package.html#package-attribute-ensure <br>
#  &nbsp;&nbsp;&nbsp; [provider]: https://docs.puppet.com/puppet/latest/types/package.html#package-attribute-provider <br>
#  &nbsp;&nbsp;&nbsp; [source]: https://docs.puppet.com/puppet/latest/types/package.html#package-attribute-source <br>
#  &nbsp; ...<br>
#  No plugin packages are installed, by default.  Merely supplying a set of
#  PACKAGE_NAME keys with empty Hash bodies ({}) is sufficient to ensure each
#  named plugin package is installed, though they will not be otherwise managed.
# @param purge_config_file_path Indicates whether to ensure that only Puppet-
#  managed configuration files exist in `config_file_path`.  Default is found in
#  the data directory of this module's source and is applied per this module's
#  hiera.yaml.
# @param service_enable Indicates whether the dovecot service will self-start
#  on node restart.  Default is found in the data directory of this module's
#  source and is applied per this module's hiera.yaml.
# @param service_ensure One of running (dovecot service is kept on) or stopped
#  (dovecot service is kept off).  Default is found in the data directory of
#  this module's source and is applied per this module's hiera.yaml.
# @param service_managed Indicates whether Puppet will manage the dovecot
#  service.  All other service_* parameters are ignored when this is disabled.
#  Default is found in the data directory of this module's source and is applied
#  per this module's hiera.yaml.
# @param service_name Name of the service to manage when `service_managed` is
#  enabled.  Default is found in the data directory of this module's source and
#  is applied per this module's hiera.yaml.
#
# @example Minimum configuration, sufficient for vendor-specified defaults
#  ---
#  classes:
#    - dovecot
#
class dovecot(
  Hash[String[4], Any]        $config_file_attributes,
  String[3]                   $config_file_path,
  Hash[String[4], Any]        $config_file_path_attributes,
  String                      $config_hash_key_knockout_prefix,
  Hash[String[1], Any]        $master_config,
  String[1]                   $package_ensure,
  String[2]                   $package_name,
  Boolean                     $purge_config_file_path,
  Boolean                     $service_enable,
  Enum['running', 'stopped']  $service_ensure,
  Boolean                     $service_managed,
  String[2]                   $service_name,
  Optional[Hash[
    String[2],
    Hash[
      String[2],
      Any
  ]]]                         $config_files    = undef,
  Optional[Hash[
    Pattern[/^dovecot-[a-z]+$/],
    Struct[{
      Optional['ensure']   => String[1],
      Optional['provider'] => String[1],
      Optional['source']   => String[1],
  }]]]                        $plugin_packages = undef,
) {
  class { '::dovecot::package': }
  -> class { '::dovecot::config': }
  ~> class { '::dovecot::service': }
  -> Class['dovecot']
}
# vim: syntax=puppet:tabstop=2:softtabstop=2:shiftwidth=2:expandtab:ai
