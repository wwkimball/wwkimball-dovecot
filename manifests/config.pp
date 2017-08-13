# Class: dovecot::config
#
# This subclass manages dovecot configuration files.
#
# @example
#
class dovecot::config {
  # Ensure the configuration directories exists
  $conf_dot_d_path = "${dovecot::config_file_path}/conf.d"
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
# vim: tabstop=2:softtabstop=2:shiftwidth=2:expandtab:ai
