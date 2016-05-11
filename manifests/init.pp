# cockpit - Used for managing installation and configuration
# of Cockpit (http://cockpit-project.org/)
#
# @example
#   include cockpit
#
# @example
#   class { 'cockpit':
#     manage_repo    => false,
#     package_name   => 'cockpit-custombuild',
#   }
#
# @author Peter Souter
#
# @param allowunencrypted [Boolean] If true, cockpit will accept unencrypted HTTP connections.
#   Otherwise, it redirects all HTTP connections to HTTPS.
#   Exceptions are connections from localhost and for certain URLs (like /ping).
#
# @param logintitle [String] Title to show on login screen for cockpit
#
# @param manage_package [Boolean] Whether to manage the cockpit package
#
# @param manage_repo [Boolean] Whether to manage the package repositroy
#
# @param maxstartups [String] Specifies the maximum number of concurrent login attempts allowed
#   Additional connections will be dropped until authentication succeeds or the connections are closed.
#
# @param package_name [String] Name of the cockpit package
#
# @param package_version [String] Version of the cockpit package to install
#
# @param service_name [String] Name of the cockpit service to manage
#
# @param service_ensure [String] What status the service should be enforced to
#
# @param yum_preview_repo [String] Whether to use the preview Yum repos to
#   install package. See https://copr.fedorainfracloud.org/coprs/g/cockpit/cockpit-preview/
#
class cockpit (
  $logintitle     = $::cockpit::params::logintitle,
  $manage_package  = $::cockpit::params::manage_package,
  $manage_repo     = $::cockpit::params::manage_repo,
  $package_name    = $::cockpit::params::package_name,
  $package_version = $::cockpit::params::package_version,
  $service_name    = $::cockpit::params::service_name,
  $service_ensure  = $::cockpit::params::service_ensure,
  $allowunencrypted = $::cockpit::params::allowunencrypted,
  $maxstartups      = $::cockpit::params::maxstartups,
  $yum_preview_repo = $::cockpit::params::yum_preview_repo,
) inherits ::cockpit::params {

  validate_string($logintitle)
  validate_bool($manage_package)
  validate_bool($manage_repo)
  validate_string($package_name)
  validate_string($package_version)
  validate_string($service_name)
  validate_string($service_ensure)

  class { '::cockpit::repo': } ->
  class { '::cockpit::install': } ->
  class { '::cockpit::config': } ~>
  class { '::cockpit::service': } ->
  Class['::cockpit']
}
