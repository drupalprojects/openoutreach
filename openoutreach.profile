<?php
// $Id$

include_once('openoutreach.features.inc');

/**
 * Implements hook_form_FORM_ID_alter().
 *
 * Allows the profile to alter the site configuration form.
 */
function openoutreach_form_install_configure_form_alter(&$form, $form_state) {
  // Pre-populate the site name with the server name.
  $form['site_information']['site_name']['#default_value'] = $_SERVER['SERVER_NAME'];
}

/**
 * Check that other install profiles are not present to ensure we don't collide with a
 * similar form alter in their profile.
 *
 * Set Open Outreach as default install profile.
 */
if (!function_exists('system_form_install_select_profile_form_alter')) {
  function system_form_install_select_profile_form_alter(&$form, $form_state) {
    foreach($form['profile'] as $key => $element) {
      $form['profile'][$key]['#value'] = 'openoutreach';
    }
  }
}

