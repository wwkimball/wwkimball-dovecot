# Class: dovecot::package
#
# This subclass manages the dovecot package.
#
# @example
#  ---
#  classes:
#    - dovecot
#  dovecot::package_ensure: latest
#
class dovecot::package {
  $default_plugin_attributes = {
    ensure  => present,
    require => Package['dovecot'],
    tag     => [ 'dovecot-plugin', ],
  }

  package { 'dovecot':
    name   => $dovecot::package_name,
    ensure => $dovecot::package_ensure,
  }

  pick($dovecot::plugin_packages, {}).each | String $name, Hash $attrs | {
    package {
      default: *=> $default_plugin_attributes,;
      $name:   *=> $attrs,;
    }
  }
}
# vim: tabstop=2:softtabstop=2:shiftwidth=2:expandtab:ai
