<?php

/**
 * @file
 * Provides functionality to be used at install time.
 */

/**
 * Generate an install task to install apps.
 *
 * Adapted from panopoly_install_tasks().
 */
function openoutreach_install_tasks($install_state) {

  if (module_exists('subprofiles')) {
    $tasks = _subprofiles_install_tasks($install_state);
  }
  else {
    $tasks = array();
  }

  // Set up the theme selection task.
  $tasks['openoutreach_theme_form'] = array(
    'display_name' => t('Choose a theme'),
    'type' => 'form',
  );

  // Set up the prepare task to close it out.
  $tasks['openoutreach_prepare'] = array(
    'display_name' => t('Prepare site'),
    'type' => 'form',
  );

  return $tasks;
}

/**
 * Implements hook_install_tasks_alter()
 */
function openoutreach_install_tasks_alter(&$tasks, $install_state) {
  // Magically go one level deeper in solving years of dependency problems.
  require_once(drupal_get_path('module', 'panopoly_core') . '/panopoly_core.profile.inc');
  $tasks['install_load_profile']['function'] = 'panopoly_core_install_load_profile';

  // Create a more informative finished page.
  $tasks['install_finished']['function'] = 'openoutreach_finished';
  $tasks['install_finished']['display_name'] = t('Finished!');
  $tasks['install_finished']['type'] = 'form';
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
  // Hide update notifications.
  $form['update_notifications']['#access'] = FALSE;
}

/**
 * Pseudo implementation of hook_user_default_permissions().
 *
 * @see openoutreach_install_permissions().
 */
function openoutreach_install_user_default_permissions() {
  $permissions = array();

  // Exported permission: access contextual links
  $permissions['access contextual links'] = array(
    'name' => 'access contextual links',
    'roles' => array(
      0 => 'administrator',
      1 => 'editor',
    ),
    'module' => 'contextual',
  );

  // Exported permission: search content
  $permissions['search content'] = array(
    'name' => 'search content',
    'roles' => array(
      0 => 'administrator',
      1 => 'anonymous user',
      2 => 'authenticated user',
    ),
    'module' => 'search',
  );

  // Exported permission: use advanced search
  $permissions['use advanced search'] = array(
    'name' => 'use advanced search',
    'roles' => array(
      0 => 'administrator',
      1 => 'anonymous user',
      2 => 'authenticated user',
    ),
    'module' => 'search',
  );

  // Exported permission: view advanced help index
  $permissions['view advanced help index'] = array(
    'name' => 'view advanced help index',
    'roles' => array(
      0 => 'administrator',
    ),
    'module' => 'advanced_help',
  );

  // Exported permission: view advanced help popup
  $permissions['view advanced help popup'] = array(
    'name' => 'view advanced help popup',
    'roles' => array(
      0 => 'administrator',
    ),
    'module' => 'advanced_help',
  );

  // Exported permission: view advanced help topic
  $permissions['view advanced help topic'] = array(
    'name' => 'view advanced help topic',
    'roles' => array(
      0 => 'administrator',
    ),
    'module' => 'advanced_help',
  );

  return $permissions;
}

/**
 * Install permissions for optional modules.
 *
 * Optional modules - identified by the "recommends" array in
 * openoutreach.info - cannot have their permissions in features; recommended
 * modules are enabled after features permissions are implemented, and in any
 * case such features would break if the optional module was disabled.
 *
 * Take advantage of existing support in the Features module for processing
 * default user permissions. Use a pseudo module name, 'openoutreach_install'.
 */
function openoutreach_install_permissions() {
  features_include();
  module_load_include('inc', 'features', 'features.export');
  user_permission_features_rebuild('openoutreach_install');
}

/**
 * Form to choose the starting theme from list of available options.
 */
function openoutreach_theme_form($form, &$form_state) {

  // Declare a white list of themes offered for selection along with data used
  // to determine what modules should be enabled and what blocks configured.
  $form_state['theme dependencies'] = array(
    'outreach' => array('superfish'),
    'sky' => array('superfish'),
    'bartik' => array(),
  );

  // Create list of theme options.
  $theme_data = array_intersect_key(system_rebuild_theme_data(), $form_state['theme dependencies']);
  $themes = array();
  foreach($theme_data as $theme) {
    $themes[$theme->name] = theme('image', array('path' => $theme->info['screenshot'])) . '<strong>' . $theme->info['name'] . '</strong><br><p><em>' . strip_tags($theme->info['description']) . '</em></p><p class="clearfix"></p>';
  }

  // Move Bartik to last.
  $bartik = $themes['bartik'];
  unset($themes['bartik']);
  $themes['bartik'] = $bartik;

  $form['theme'] = array(
    '#title' => t('Starting Theme'),
    '#type' => 'radios',
    '#options' => $themes,
    '#default_value' => 'outreach',
  );

  $form['submit'] = array(
    '#type' => 'submit',
    '#value' => t('Choose theme'),
  );

  $form['#attached']['css'] = array(
    drupal_get_path('profile', 'openoutreach') . '/openoutreach.install.css',
  );

  return $form;
}

/**
 * Form submit handler to select the theme.
 */
function openoutreach_theme_form_submit($form, &$form_state) {
  // Enable and set the theme of choice.
  $theme = $form_state['values']['theme'];
  theme_enable(array($theme));
  variable_set('theme_default', $theme);
  // Enable and set the theme of choice.
  $dependencies = $form_state['theme dependencies'];

  if (!empty($dependencies[$theme])) {
    module_enable($dependencies[$theme]);
  }

  // Assign regions for the theme.
  $regions = system_region_list($theme);
  $blocks = array();

  $assignments = array();
  $assignments['system'] = array(
    'main' => 'content',
    'help' => 'help',
  );

  if (module_exists('superfish')) {
    $assignments['superfish'] = array(
      // 'menu_bar' is the region used by adaptivetheme subthemes.
      'superfish_1' => 'menu_bar',
    );
  }

  foreach ($assignments as $module => $module_blocks) {
    foreach ($module_blocks as $delta => $region) {
      if (isset($regions[$region])) {
        $blocks[] = array(
          'module' => $module,
          'delta' => $delta,
          'theme' => $theme,
          'status' => 1,
          'weight' => 0,
          'region' => $region,
          'pages' => '',
          'cache' => -1,
        );
      }
    }
  }
  if ($blocks) {
    foreach ($blocks as $record) {
      $query = db_merge('block')
        ->key(array('theme' => $record['theme'], 'module' => $record['module'], 'delta' => $record['delta']))
        ->fields($record)
        ->execute();
    }
  }

  // Flush theme caches so things are right.
  system_rebuild_theme_data();
  drupal_theme_rebuild();
}

/**
 * Form to talk about preparing the site for prime time.
 */
function openoutreach_prepare($form, &$form_state) {
  $form = array();

  $form['opening'] = array(
    '#markup' => '<h1>' . t('Prepare Site') . '</h1>',
  );

  $form['openingtext'] = array(
    '#markup' => '<h2>' . t('Open Outreach now needs to do a bit more to get everything set up.') . '</h2><p>' . t('This step may take a few minutes.') . '</p>',
  );

  $form['submit'] = array(
    '#type' => 'submit',
    '#value' => t('Prepare your site'),
  );

  return $form;
}

/**
 * Submit form to prepare site for prime time.
 */
function openoutreach_prepare_submit($form, &$form_state) {
  openoutreach_install_permissions();

  // Try to allocate enough time to rebuild features.
  drupal_set_time_limit(240);

  // Flush all caches to ensure that any full bootstraps during the installer
  // do not leave stale cached data, and that any content types or other items
  // registered by the install profile are registered correctly. Flushing also
  // triggers features component rebuilding.
  drupal_flush_all_caches();

  // Remember the profile which was used.
  variable_set('install_profile', drupal_get_profile());

  // Install profiles are always loaded last.
  db_update('system')
    ->fields(array('weight' => 1000))
    ->condition('type', 'module')
    ->condition('name', drupal_get_profile())
    ->execute();

  // Cache a fully-built schema.
  drupal_get_schema(NULL, TRUE);

  // Run cron to populate update status tables (if available) so that users
  // will be warned if they've installed an out of date Drupal version.
  // Will also trigger indexing of profile-supplied content or feeds.
  drupal_cron_run();
}

/**
 * Form to finish it all out and send us on our way.
 */
function openoutreach_finished($form, &$form_state) {
  $form = array();

  $form['opening'] = array(
    '#markup' => '<h1>' . t('Finished!') . '</h1>',
  );

  $form['openingtext'] = array(
    '#markup' => '<h2>' . t('Congratulations, you just installed Open Outreach!') . '</h2>',
  );

  $form['openoutreach_logo'] = array(
    '#markup' => theme('image', array('path' => drupal_get_path('profile', 'openoutreach') . '/images/openoutreach_logo.png')),
  );

  $form['submit'] = array(
    '#type' => 'submit',
    '#value' => t('Visit your new site'),
  );

  return $form;
}

/**
 * Submit form to finish it out and send us on our way!
 */
function openoutreach_finished_submit($form, &$form_state) {
  // Once more for good measure.
  drupal_flush_all_caches();

  unset($_SESSION['openoutreach_features']);

  // And away we go.
  // $form_state['redirect'] won't work here since we are still in the
  // installer, so use drupal_goto() (for interactive installs only) instead.
  $install_state = $form_state['build_info']['args'][0];
  if ($install_state['interactive']) {
    drupal_goto('<front>');
  }
}
