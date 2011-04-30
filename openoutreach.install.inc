<?php

/**
 * @file
 * Include file providing functionality to be used at install time.
 */

/**
 * Implements hook_install_tasks().
 *
 * Open Outreach supports "subprofiles"--variations of the install profile.
 * Subprofiles are defined in the profile's .info file in the following format:
 * <code>
 * subprofiles[standard][name] = Openoutreach standard
 * subprofiles[standard][description] = Install a full version of Open Outreach with all commonly needed features enabled.
 * subprofiles[standard][features][debut] = TRUE
 * subprofiles[standard][features][debut_article] = TRUE
 * subprofiles[standard][features][debut_blog] = TRUE
 * </code>
 *
 * For interactive installs, the subprofile can be selected on the site
 * information page. For automated installs, the subprofile can be passed in
 * as a parameter along with the profile. If no subprofile is specified,
 * the 'standard' one is used.
 */
function openoutreach_install_tasks($install_state) {
  $tasks = array(
    'openoutreach_install_profile_features' => array(
      'display_name' => st('Install Open Outreach features'),
      'type' => 'batch',
    ),
  );
  return $tasks;
}

/**
 * Installation task; install profile features via a batch process.
 *
 * @param $install_state
 *   An array of information about the current installation state.
 *
 * @return
 *   The batch definition.
 */
function openoutreach_install_profile_features(&$install_state) {
  // If the installer was run interactively, specific features may have been selected.
  $modules = variable_get('openoutreach_install_profile_features', array());
  variable_del('openoutreach_install_profile_features');

  // If the install wasn't interactive, use the default features of the
  // subprofile.
  if (!count($modules)) {
    // Determine whether a subprofile was specified via a parameter. If not,
    // default to 'standard'.
    $subprofile = openoutreach_get_subprofile('openoutreach', !empty($install_state['parameters']['subprofile']) ? $install_state['parameters']['subprofile'] : 'standard');
    // Filter so that we have only the features set to be enabled by default.
    $modules = array_keys(array_filter($subprofile['features']));
  }
  module_load_include('inc', 'openoutreach', 'openoutreach.module_batch');
  return openoutreach_get_module_batch($modules);
}

/**
 * Implements hook_form_FORM_ID_alter().
 *
 * Alter the site configuration form to enable selecting of an Open Outreach
 * subprofile and specific subprofile features to be enabled.
 */
function openoutreach_form_install_configure_form_alter(&$form, $form_state) {
  // Pre-populate the site name with the server name.
  $form['site_information']['site_name']['#default_value'] = $_SERVER['SERVER_NAME'];

  $subprofiles = openoutreach_get_subprofiles();
  $form['subprofile'] = array(
    '#type' => 'fieldset',
    '#title' => st('Open Outreach flavours'),
    '#description' => st('Select the flavour of Open Outreach you wish to install.'),
    '#weight' => -1,
  );
  // Extract features checkboxes from the features admin form.
  module_load_include('inc', 'features', 'features.admin');
  $features_admin_form = features_admin_form(array(), array());
  $features = $features_admin_form['features']['status'];
  foreach ($subprofiles as $subprofile_name => $subprofile) {
    $title = $subprofile['name'];
    $form['subprofile'][$title] = array(
      '#type' => 'radio',
      '#default_value' => 'standard',
      '#return_value' => $subprofile_name,
      '#title' => $title,
      '#description' => isset($subprofile['description']) ? $subprofile['description'] : NULL,
      '#parents' => array('subprofile'),
    );
    $subprofile_features = $features;
    // Reduce selectable features to those specified in the selected subprofile
    // and set their default enabled status to that in the .info file.
    foreach (array_keys($subprofile_features) as $name) {
      if (!isset($subprofile['features'][$name])) {
        unset($subprofile_features[$name]);
      }
      else {
        $subprofile_features[$name]['#default_value'] = $subprofile['features'][$name];
      }
    }
    $form[$subprofile_name . '_features'] = array(
      '#type' => 'fieldset',
      '#title' => st('Customize !title features', array('!title' => $title)),
      '#description' => st('Select the features you wish to enable. You will also have a chance to enable or disable features after installing.'),
      '#weight' => -1,
      // Show the fieldset only when the corresponding subprofile is selected.
      '#states' => array(
        'visible' => array(
          ':input[name=subprofile]' => array('value' => $subprofile_name),
        ),
      ),
      '#tree' => TRUE,
    ) + $subprofile_features;
  }

  $form['#submit'][] = 'openoutreach_install_configure_form_submit';
}

/**
 * Submit handler for install_configure_form. Set a variable specifying the
 * features to be installed.
 */
function openoutreach_install_configure_form_submit($form, &$form_state) {
  $subprofile = $form_state['values']['subprofile'];
  $features = array_keys(array_filter($form_state['values'][$subprofile . '_features']));
  variable_set('openoutreach_install_profile_features', $features);
}

