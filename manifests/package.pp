# Class: dovecot::package
#
# This subclass manages the dovecot package and all dovecot-* plugin packages.
#
# @summary Manages all dovecot packages.
#
# @example Default; no plugins and dovecot is present but not updated
#  ---
#  classes:
#    - dovecot
#
# @example Keep dovecot up-to-date
#  ---
#  classes:
#    - dovecot
#  dovecot::package_ensure: latest
#
# @example Install the mysql plugin (no automatic updates)
#  ---
#  classes:
#    - dovecot
#  dovecot::plugin_packages:
#    dovecot-mysql: {}
#
# @example Install the mysql plugin and keep all dovecot packages up-to-date
#  ---
#  classes:
#    - dovecot
#  dovecot::package_ensure: latest
#  dovecot::plugin_packages:
#    dovecot-mysql:
#      ensure: latest
#
# @example Uninstall everything dovecot-related but retain its configuration
#  ---
#  classes:
#    - dovecot
#  dovecot::package_ensure: absent
#
# @example Uninstall everything dovecot-related and destroy its configuration
#  ---
#  classes:
#    - dovecot
#  dovecot::package_ensure: purged
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
    if $dovecot::package_ensure in ['absent', 'purged'] {
      package { $name:
        ensure => $dovecot::package_ensure,
        before => [ Package['dovecot'], ],
      }
    } else {
      package {
        default: *=> $default_plugin_attributes,;
        $name:   *=> $attrs,;
      }
    }
  }
}
# vim: syntax=puppet:tabstop=2:softtabstop=2:shiftwidth=2:expandtab:ai
