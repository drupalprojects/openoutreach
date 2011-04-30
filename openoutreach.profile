<?php

include_once('openoutreach.features.inc');
// Include only when in install mode. MAINTENANCE_MODE is defined in install.php.
if (defined('MAINTENANCE_MODE') && MAINTENANCE_MODE == 'install') {
  include_once('openoutreach.install.inc');
}

/**
 * Return an array of data about subprofiles of openoutreach.
 */
function openoutreach_get_subprofiles($profile = 'openoutreach') {
  include_once DRUPAL_ROOT . '/includes/install.inc';
  $info = install_profile_info($profile);
  return $info['subprofiles'];
}

/**
 * Return an array of data about a specified subprofile of openoutreach.
 */
function openoutreach_get_subprofile($profile = 'openoutreach', $subprofile = 'openoutreach_standard') {
  $subprofiles = openoutreach_get_sub_profiles($profile);
  return isset($subprofiles[$subprofile]) ? $subprofiles[$subprofile] : FALSE;
}

/**
 * Implements hook_modules_installed().
 */
function openoutreach_modules_installed($modules) {
  module_load_include('inc', 'openoutreach', 'openoutreach.module_batch');
  openoutreach_module_batch($modules);
}
