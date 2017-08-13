# Class: dovecot::service
#
# This subclass manages the dovecot service.
#
# @example
#  ---
#  classes:
#    - dovecot
#  dovecot::service_ensure: running
#  dovecot::service_enable: true
#  dovecot::service_managed: true
#
class dovecot::service {
  if $dovecot::service_managed {
    service { 'dovecot':
      ensure    => $dovecot::service_ensure,
      name      => $dovecot::service_name,
      enable    => $dovecot::service_enable,
      subscribe => [ Package['dovecot'], ],
    }

    # Ensure that changes to plugins also trigger service restarts
    File <| tag == 'dovecot-plugin' |> ~> Service['dovecot']
  }
}
# vim: tabstop=2:softtabstop=2:shiftwidth=2:expandtab:ai
