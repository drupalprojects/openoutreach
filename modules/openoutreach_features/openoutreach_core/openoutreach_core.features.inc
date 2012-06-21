<?php
/**
 * @file
 * openoutreach_core.features.inc
 */

/**
 * Implementation of hook_ctools_plugin_api().
 */
function openoutreach_core_ctools_plugin_api() {
  list($module, $api) = func_get_args();
  if ($module == "context" && $api == "context") {
    return array("version" => "3");
  }
  if ($module == "strongarm" && $api == "strongarm") {
    return array("version" => 1);
  }
}