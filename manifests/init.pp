# Class: dovecot
#
# This module fully manages dovecot
#
class dovecot(
  Hash[String[4], Any]        $config_file_attributes,
  String[3]                   $config_file_path,
  Hash[String[4], Any]        $config_file_path_attributes,
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
# vim: tabstop=2:softtabstop=2:shiftwidth=2:expandtab:ai
