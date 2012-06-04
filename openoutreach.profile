<?php

/**
 * @file
 * Installation profile for the Open Outreach distribution.
 */

include_once('openoutreach.features.inc');
// Include only when in install mode. MAINTENANCE_MODE is defined in
// install.php and in drush_core_site_install().
if (defined('MAINTENANCE_MODE') && MAINTENANCE_MODE == 'install') {
  include_once('openoutreach.install.inc');
}

/**
 * Implements hook_modules_installed().
 *
 * When a module is installed, enable the modules it recommends if they are
 * present. For Open Outreach, also install permissions.
 */
function openoutreach_modules_installed($modules) {
  module_load_include('inc', 'openoutreach', 'openoutreach.module_batch');
  openoutreach_module_batch($modules);
}

/**
 * Check that other install profiles are not present to ensure we don't collide with a
 * similar form alter in their profile.
 *
 * Set Open Outreach as default install profile.
 */
if (!function_exists('system_form_install_select_profile_form_alter')) {
  function system_form_install_select_profile_form_alter(&$form, $form_state) {
    // Only set the value if Open Outreach is the only profile.
    if (count($form['profile']) == 1) {
      foreach($form['profile'] as $key => $element) {
        $form['profile'][$key]['#value'] = 'openoutreach';
      }
    }
  }
}

/**
 * Implements hook_install_configure_form_alter().
 */
function openoutreach_form_install_configure_form_alter(&$form, &$form_state) {
  // Set some reasonable defaults for site configuration form.
  $form['site_information']['site_name']['#default_value'] = 'Open Outreach';
  $form['admin_account']['account']['name']['#default_value'] = 'admin';
  // Don't set the email address to "admin@localhost" as that will fail D7's
  // email address validation.
  if ($_SERVER['HTTP_HOST'] != 'localhost') {
    $form['site_information']['site_mail']['#default_value'] = 'admin@'. $_SERVER['HTTP_HOST'];
    $form['admin_account']['account']['mail']['#default_value'] = 'admin@'. $_SERVER['HTTP_HOST'];
  }
}

/**
 * Implements hook_context_default_contexts_alter().
 *
 * If the debut_blogger module is enabled, display the shortcut block to users
 * with the blogger role.
 */
function openoutreach_context_default_contexts_alter(&$contexts) {
  if (isset($contexts['shortcut']) && module_exists('debut_blog') && !openoutreach_is_recreating('openoutreach')) {
    $contexts['shortcut']->conditions['user']['values']['blogger'] = 'blogger';
  }
}

/**
 * Implements hook_admin_menu_output_build().
 *
 * Add links to the admin_menu shortcuts menu.
 */
function openoutreach_admin_menu_output_build(&$content) {
  $content['shortcuts']['shortcuts']['admin-structure-taxonomy'] = array(
    '#title' => t('Add terms'),
    '#href' => 'admin/structure/taxonomy',
    '#access' => user_access('administer taxonomy'),
  );
  $content['shortcuts']['shortcuts']['user'] = array(
    '#title' => t('My account'),
    '#href' => 'user',
  );
}

/**
 * Determine whether a feature is being recreated.
 */
function openoutreach_is_recreating($feature = NULL) {
  // Test for Drush usage.
  if (function_exists('drush_get_command') && $command = drush_get_command()) {
    switch($command['command']) {
      case 'features-update-all':
        return TRUE;
      case 'features-update':
        // If a specific feature was requested, test for it. If not, return
        // true for any feature recreation.
        return is_null($feature) || in_array($feature, $command['arguments']);
    }
  }

  // Test for admin UI usage.
  $feature = is_null($feature) ? arg(3) : $feature;
  if ($_GET['q'] == "admin/structure/features/{$feature}/recreate") {
    return TRUE;
  }
  return FALSE;
}


/**
 * Implements hook_apps_servers_info().
 */
function openoutreach_apps_servers_info() {
  $info =  drupal_parse_info_file(dirname(__file__) . '/openoutreach.info');
  return array(
    'debut' => array(
      'title' => 'Debut',
      'description' => "Apps in the Debut se",
      'manifest' => 'http://appserver.openoutreach.com/app/query',
      'profile' => 'openoutreach',
      'profile_version' => isset($info['version']) ? $info['version'] : '7.x-1.x',
      'server_name' => $_SERVER['SERVER_NAME'],
      'server_ip' => $_SERVER['SERVER_ADDR'],
    ),
  );
}

