# Class: dovecot::service
#
# This subclass optionally manages the dovecot service.  The name of the managed
# service can be customized if necessary and service management can be entirely
# disabled.
#
# @summary Optionally manages the dovecot service by any name.
#
# @example Default; service is managed and always running
#  ---
#  classes:
#    - dovecot
#
# @example Disable service management (e.g.:  for containers)
#  ---
#  classes:
#    - dovecot
#  dovecot::service_managed: false
#
# @example Stop the service
#  ---
#  classes:
#    - dovecot
#  dovecot::service_ensure: stopped
#
class dovecot::service {
  if $dovecot::service_managed
    and ! ($dovecot::package_ensure in ['absent', 'purged'])
  {
    service { 'dovecot':
      ensure    => $dovecot::service_ensure,
      name      => $dovecot::service_name,
      enable    => $dovecot::service_enable,
      subscribe => [ Package['dovecot'], ],
    }

    # Ensure that changes to plugins also trigger service restarts
    Package <| tag == 'dovecot-plugin' |> ~> Service['dovecot']
  }
}
# vim: syntax=puppet:tabstop=2:softtabstop=2:shiftwidth=2:expandtab:ai
