<?php
// $Id$

/**
 * Implementation of hook_profile_details().
 */
function openoutreach_profile_details() {
  return array(
    'name' => 'Open Outreach',
    'description' => 'Open Outreach provides a highly usable and feature rich website suited to small non-profits and community organizations.'
  );
}

/**
 * Implementation of hook_profile_modules().
 */
function openoutreach_profile_modules() {
    global $install_locale;
  $modules = array(
  // Drupal core.
    'block',
    'book',
    'comment',
    'contact',
    'dblog',
    'filter',
    'help',
    'menu',
    'node',
    'path',
    'search',
    'system',
    'taxonomy',
    'update',
    'user',
  // Drupal contrib + external.
    'admin',
    'ctools',
    'boxes',
    'content',
    'optionwidgets',
    'text',
    'context',
    'context_ui',
    'date_api',
    'date_timezone',
    'date',
    'date_popup',
    'designkit',
    'extractor',
    'features',
    'feeds',
    'feeds_ui',
    'imageapi',
    'imageapi_gd',
    'imagecache',
    'jquery_ui',
    'libraries',
    'mark',
    'markdown',
    'porterstemmer',
    'purl',
    'spaces',
    'spaces_dashboard',
    'tagging',
    'views',
    'views_ui',
    'views_rss',
    'views_modes',
    'votingapi',
    'seed',
    'strongarm',
  );
  return $modules;
}

/**
 * Perform any final installation tasks for this profile.
 *
 * @param $task
 * The current $task of the install system. When hook_profile_tasks()
 * is first called, this is 'profile'.
 * @param $url
 * Complete URL to be used for a link or form action on a custom page,
 * if providing any, to allow the user to proceed with the installation.
 *
 * @return
 * An optional HTML string to display to the user. Only used if you
 * modify the $task, otherwise discarded.
 */
function openoutreach_profile_tasks(&$task, $url) {
  // This is where features are usually being enabled.
  $features = array(
    'debut',
    'debut_audio',
    'debut_event',
    'debut_image',
    'debut_video',
  );
  drupal_install_modules($features);

  // Rebuild key tables/caches.
  drupal_flush_all_caches();

  // Enabe rubik as default theme.
  openoutreach_enable_theme('rubik');
}

/**
 * Alter some forms implementing hooks in system module namespace
 * This is a trick for hooks to get called; otherwise we cannot alter forms.
 */

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

/**
 * Implementation of hook_form_alter().
 *
 * Can use openoutreach rather than system since we now have an install profile selected.
 */
function openoutreach_form_install_configure_form_alter(&$form, $form_state, $form_id) {
  $form['site_information']['site_name']['#default_value'] = 'Open Outreach';
  $form['site_information']['site_mail']['#default_value'] = 'admin@'. $_SERVER['HTTP_HOST'];
  $form['admin_account']['account']['name']['#default_value'] = 'admin';
  $form['admin_account']['account']['mail']['#default_value'] = 'admin@'. $_SERVER['HTTP_HOST'];
  if (function_exists('date_timezone_names') && function_exists('date_timezone_update_site')) {
    $form['server_settings']['date_default_timezone']['#access'] = FALSE;
    $form['server_settings']['#element_validate'] = array('date_timezone_update_site');
    $form['server_settings']['date_default_timezone_name'] = array(
      '#type' => 'select',
      '#title' => t('Default time zone'),
      '#default_value' => NULL,
      '#options' => date_timezone_names(FALSE, TRUE),
      '#description' => t('Select the default site time zone. If in doubt, choose the timezone that is closest to your location which has the same rules for daylight saving time.'),
      '#required' => TRUE,
    );
  }
}

/**
 * Enable a theme that lives in a profile.
 *
 * @param $theme_name
 *   The name of the theme to be enabled.
 * @param $profile_name
 *   The name of the profile that contains the theme.
 */
function openoutreach_enable_theme($theme_name, $profile_name = 'openoutreach') {
  // Set default theme. This must happen after drupal_flush_all_caches(), which
  // will run system_theme_data() without detecting themes in the install
  // profile directory.
  _openoutreach_system_theme_data($profile_name);
  db_query("UPDATE {blocks} SET status = 0, region = ''"); // disable all DB blocks
  db_query("UPDATE {system} SET status = 0 WHERE type = 'theme' and name ='%s'", 'garland');
  db_query("UPDATE {system} SET status = 1 WHERE type = 'theme' and name ='%s'", $theme_name);
  variable_set('theme_default', $theme_name);
}

/**
 * Reimplementation of system_theme_data().
 *
 * The core function's static cache is populated during install prior to active
 * install profile awareness. This workaround makes enabling themes in
 * profiles/[profile]/themes possible.
 */
function _openoutreach_system_theme_data($profile_name) {
  global $profile;
  $profile = $profile_name;

  $themes = drupal_system_listing('\.info$', 'themes');
  $engines = drupal_system_listing('\.engine$', 'themes/engines');

  $defaults = system_theme_default();

  $sub_themes = array();
  foreach ($themes as $key => $theme) {
    $themes[$key]->info = drupal_parse_info_file($theme->filename) + $defaults;

    if (!empty($themes[$key]->info['base theme'])) {
      $sub_themes[] = $key;
    }

    if (isset($themes[$key]->info['engine'])) {
      $engine = $themes[$key]->info['engine'];
      if (isset($engines[$engine])) {
        $themes[$key]->owner = $engines[$engine]->filename;
        $themes[$key]->prefix = $engines[$engine]->name;
        $themes[$key]->template = TRUE;
      }
    }

    // Give the stylesheets proper path information.
    $pathed_stylesheets = array();
    foreach ($themes[$key]->info['stylesheets'] as $media => $stylesheets) {
      foreach ($stylesheets as $stylesheet) {
        $pathed_stylesheets[$media][$stylesheet] = dirname($themes[$key]->filename) .'/'. $stylesheet;
      }
    }
    $themes[$key]->info['stylesheets'] = $pathed_stylesheets;

    // Give the scripts proper path information.
    $scripts = array();
    foreach ($themes[$key]->info['scripts'] as $script) {
      $scripts[$script] = dirname($themes[$key]->filename) .'/'. $script;
    }
    $themes[$key]->info['scripts'] = $scripts;

    // Give the screenshot proper path information.
    if (!empty($themes[$key]->info['screenshot'])) {
      $themes[$key]->info['screenshot'] = dirname($themes[$key]->filename) .'/'. $themes[$key]->info['screenshot'];
    }
  }

  foreach ($sub_themes as $key) {
    $themes[$key]->base_themes = system_find_base_themes($themes, $key);
    // Don't proceed if there was a problem with the root base theme.
    if (!current($themes[$key]->base_themes)) {
      continue;
    }
    $base_key = key($themes[$key]->base_themes);
    foreach (array_keys($themes[$key]->base_themes) as $base_theme) {
      $themes[$base_theme]->sub_themes[$key] = $themes[$key]->info['name'];
    }
    // Copy the 'owner' and 'engine' over if the top level theme uses a
    // theme engine.
    if (isset($themes[$base_key]->owner)) {
      if (isset($themes[$base_key]->info['engine'])) {
        $themes[$key]->info['engine'] = $themes[$base_key]->info['engine'];
        $themes[$key]->owner = $themes[$base_key]->owner;
        $themes[$key]->prefix = $themes[$base_key]->prefix;
      }
      else {
        $themes[$key]->prefix = $key;
      }
    }
  }

  // Extract current files from database.
  system_get_files_database($themes, 'theme');
  db_query("DELETE FROM {system} WHERE type = 'theme'");
  foreach ($themes as $theme) {
    $theme->owner = !isset($theme->owner) ? '' : $theme->owner;
    db_query("INSERT INTO {system} (name, owner, info, type, filename, status, throttle, bootstrap) VALUES ('%s', '%s', '%s', '%s', '%s', %d, %d, %d)", $theme->name, $theme->owner, serialize($theme->info), 'theme', $theme->filename, isset($theme->status) ? $theme->status : 0, 0, 0);
  }
}

