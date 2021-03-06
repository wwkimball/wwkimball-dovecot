# Class: dovecot::config
#
# This subclass manages all dovecot configuration files, from the primary
# dovecot.conf to every file in the conf.d directory including custom, user-
# created files.  All configuration files are kept on the node unless
# `dovecot::package_ensure: purged`.
#
# @summary Manages all dovecot configuration files.
#
# @example Default configuration; all files are vendor-defaults
#  ---
#  classes:
#    - dovecot
#
# @example Add Let's Encrypt certificates
#  ---
#  classes:
#    - dovecot
#    - letsencrypt  # Not documented, here
#  dovecot::config_files:
#    10-ssl.conf:   # Use Let's Encrypt certificates
#      ssl_cert: </etc/letsencrypt/live/mail.%{facts.domain}/fullchain.pem
#      ssl_key: </etc/letsencrypt/live/mail.%{facts.domain}/privkey.pem
#
# @example Miscellaneous customizations
#  ---
#  classes:
#    - dovecot
#  dovecot::master_config:
#    '--!include_try': --     # Remove all "soft" includes
#  dovecot::config_files:
#    10-logging.conf:
#      auth_verbose: 'yes'    # Log auth failures and causes
#
# @example Remove dovecot but retain the configuration files
#  ---
#  classes:
#    - dovecot
#  dovecot::package_ensure: absent
#
# @example Remove all configuration files
#  ---
#  classes:
#    - dovecot
#  dovecot::package_ensure: purged
#
class dovecot::config {
  $conf_dot_d_path = "${dovecot::config_file_path}/conf.d"
  $knockout_prefix = $dovecot::config_hash_key_knockout_prefix

  # Cleanly uninstall when the primary package is purged.  Allow 'absent' to
  # leave the configuration behind.
  if 'purged' == $dovecot::package_ensure {
    file { $dovecot::config_file_path:
      ensure => absent,
      force  => true,
    }
  } else {
    # Ensure the configuration directories exists
    file { $dovecot::config_file_path:
      ensure       => directory,
      purge        => $dovecot::purge_config_file_path,
      recurse      => $dovecot::purge_config_file_path,
      recurselimit => 2,
      *            => $dovecot::config_file_path_attributes,
    }
    -> file { $conf_dot_d_path:
      ensure => directory,
      *      => $dovecot::config_file_path_attributes,
    }

    # Manage dovecot.conf
    file { "${dovecot::config_file_path}/dovecot.conf":
      ensure  => file,
      content => template("${module_name}/config-file.erb"),
      *       => $dovecot::config_file_attributes,
    }

    # Manage all auxilliary configuration files
    pick($dovecot::config_files, {}).each | String $file, Hash $config, | {
      file { "${conf_dot_d_path}/${file}":
        ensure  => file,
        content => template("${module_name}/config-file.erb"),
        *       => $dovecot::config_file_attributes,
      }
    }
  }
}
# vim: syntax=puppet:tabstop=2:softtabstop=2:shiftwidth=2:expandtab:ai
