; $Id$

; Drupal version
core = 6.x

projects[] = drupal

; Contrib modules
projects[admin][subdir] = contrib
projects[adminrole][subdir] = contrib
projects[advanced_help][subdir] = contrib
projects[backup_migrate][subdir] = contrib
projects[better_formats][subdir] = contrib
projects[boxes][subdir] = contrib
projects[calendar][subdir] = contrib
; Need dev version for install profile support, see http://drupal.org/node/704110.
projects[captcha][subdir] = contrib
projects[captcha][version] = 2.x-dev
projects[cck][subdir] = contrib
projects[content_profile][subdir] = contrib
projects[context][subdir] = contrib
projects[context][version] = 3.0-beta5
projects[ctools][subdir] = contrib
projects[date][subdir] = contrib
projects[debut][subdir] = contrib
; Not sure why version is needed here.
projects[debut][version] = 1.x-dev
projects[debut_audio][subdir] = contrib
projects[debut_event][subdir] = contrib
projects[debut_image][subdir] = contrib
projects[debut_video][subdir] = contrib
projects[designkit][subdir] = contrib
projects[diff][subdir] = contrib
projects[email][subdir] = contrib
projects[emfield][subdir] = contrib
projects[extlink][subdir] = contrib
projects[extractor][subdir] = contrib
projects[features][subdir] = contrib
projects[feeds][subdir] = contrib
projects[filefield][subdir] = contrib
projects[fivestar][subdir] = contrib
projects[imageapi][subdir] = contrib
projects[imagecache][subdir] = contrib
projects[image_caption][subdir] = contrib
projects[imagefield][subdir] = contrib
projects[imagefield_crop][subdir] = contrib
projects[jcarousel][subdir] = contrib
projects[jcarousel][version] = 1.x-dev
projects[jquery_ui][subdir] = contrib
projects[jquery_update][subdir] = contrib
projects[jquery_update][version] = 2.0-alpha1
projects[libraries][subdir] = contrib
projects[link][subdir] = contrib
projects[linkit][subdir] = contrib
projects[mark][subdir] = contrib
projects[markdown][subdir] = contrib
projects[media_archive][subdir] = contrib
projects[menutrails][subdir] = contrib
projects[menu_block][subdir] = contrib
projects[modalframe][subdir] = contrib
projects[nodereference_views][subdir] = contrib
projects[noderelationships][subdir] = contrib
; Evaluating. May be too complex for most users.
;projects[nodewords][subdir] = contrib
; Not yet produced.
;projects[openoutreach_features][subdir] = contrib
projects[pathauto][subdir] = contrib
projects[pathfilter][subdir] = contrib
projects[porterstemmer][subdir] = contrib
projects[poormanscron][subdir] = contrib
projects[purl][subdir] = contrib
projects[spaces][subdir] = contrib
projects[strongarm][subdir] = contrib
projects[tagging][subdir] = contrib
projects[token][subdir] = contrib
projects[transliteration][subdir] = contrib
projects[views][subdir] = contrib
projects[views_attach][subdir] = contrib
projects[views_bulk_operations][subdir] = contrib
; No stable release available yet.
projects[viewscarousel][subdir] = contrib
projects[viewscarousel][version] = 2.x-dev
projects[views_rss][subdir] = contrib
projects[views_slideshow][subdir] = contrib
projects[vote_up_down][subdir] = contrib
projects[votingapi][subdir] = contrib
projects[wysiwyg][subdir] = contrib
; Support for wysiwyg in features. See http://drupal.org/node/624018.
projects[wysiwyg][patch][] = http://drupal.org/files/issues/wysiwyg-624018-with-ui-3.patch

; External modules
projects[seed][subdir] = external
projects[seed][location] = http://code.developmentseed.org/fserver
projects[simpleshare][subdir] = external
projects[simpleshare][location] = http://code.developmentseed.org/fserver
projects[stored_views][subdir] = external
projects[stored_views][location] = http://code.developmentseed.org/fserver
projects[views_modes][subdir] = external
projects[views_modes][location] = http://code.developmentseed.org/fserver

; External themes
projects[tao][location] = http://code.developmentseed.org/fserver
projects[tao][subdir] = external
projects[rubik][location] = http://code.developmentseed.org/fserver
projects[rubik][subdir] = external

; External libraries

; jQuery UI
libraries[jquery_ui][download][type] = "get"
libraries[jquery_ui][download][url] = "http://jquery-ui.googlecode.com/files/jquery-ui-1.7.3.zip"
libraries[jquery_ui][directory_name] = "jquery.ui"
libraries[jquery_ui][destination] = "modules/contrib/jquery_ui"

; TBD: use ckeditor instead?
; TinyMCE
libraries[tinymce][download][type] = "get"
libraries[tinymce][download][url] = "http://downloads.sourceforge.net/project/tinymce/TinyMCE/3.2.7/tinymce_3_2_7.zip"
libraries[tinymce][directory_name] = "tinymce"
