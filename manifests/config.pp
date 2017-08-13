# Class: dovecot::config
#
# This subclass manages dovecot configuration files.
#
# @example
#
class dovecot::config {
  $conf_dot_d_path = "${dovecot::config_file_path}/conf.d"

  # Cleanly uninstall when the primary package is purged.  Allow 'absent' to
  # leave the configuration behind.
  if 'purged' == $dovecot::package_ensure {
    file {
      default:
        ensure  => absent,
        force   => true,;

      $dovecot::config_file_path:;
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
      ensure       => directory,
      *            => $dovecot::config_file_path_attributes,
    }
  
    # Manage dovecot.conf
    file {
      default:
        ensure => file,
        *      => $dovecot::config_file_attributes,;
  
      "${dovecot::config_file_path}/dovecot.conf":
        content => template("${module_name}/config-file.erb"),;
    }
  
    # Manage all auxilliary configuration files
    pick($dovecot::config_files, {}).each | String $file, Hash $config, | {
      file {
        default:
          ensure => file,
          *      => $dovecot::config_file_attributes,;
    
        "${conf_dot_d_path}/${file}":
          content => template("${module_name}/config-file.erb"),;
      }
    }
  }
}
# vim: tabstop=2:softtabstop=2:shiftwidth=2:expandtab:ai
