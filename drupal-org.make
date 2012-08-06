api = 2
core = 7.x

; Includes are not yet supported on drupal-org.make files.
; See http://drupal.org/node/1427752.

; Debut features.
; includes[debut] = "http://drupalcode.org/project/debut.git/blob_plain/refs/heads/7.x-1.x:/debut.make.inc"
; includes[debut_article] = "http://drupalcode.org/project/debut_article.git/blob_plain/refs/heads/7.x-1.x:/debut_article.make.inc"
; includes[debut_bio] = "http://drupalcode.org/project/debut_bio.git/blob_plain/refs/heads/7.x-1.x:/debut_bio.make.inc"
; includes[debut_blog] = "http://drupalcode.org/project/debut_blog.git/blob_plain/refs/heads/7.x-1.x:/debut_blog.make.inc"
; includes[debut_comment] = "http://drupalcode.org/project/debut_comment.git/blob_plain/refs/heads/7.x-1.x:/debut_comment.make.inc"
; includes[debut_event] = "http://drupalcode.org/project/debut_event.git/blob_plain/refs/heads/7.x-1.x:/debut_event.make.inc"
; includes[debut_forum] = "http://drupalcode.org/project/debut_forum.git/blob_plain/refs/heads/7.x-1.x:/debut_forum.make.inc"
; includes[debut_highlighted] = "http://drupalcode.org/project/debut_highlighted.git/blob_plain/refs/heads/7.x-1.x:/debut_highlighted.make.inc"
; includes[debut_link] = "http://drupalcode.org/project/debut_link.git/blob_plain/refs/heads/7.x-1.x:/debut_link.make.inc"
; includes[debut_media] = "http://drupalcode.org/project/debut_media.git/blob_plain/refs/heads/7.x-1.x:/debut_media.make.inc"
; includes[debut_member] = "http://drupalcode.org/project/debut_member.git/blob_plain/refs/heads/7.x-1.x:/debut_member.make.inc"
; includes[debut_section] = "http://drupalcode.org/project/debut_section.git/blob_plain/refs/heads/7.x-1.x:/debut_section.make.inc"
; includes[debut_seo] = "http://drupalcode.org/project/debut_seo.git/blob_plain/refs/heads/7.x-1.x:/debut_seo.make.inc"
; includes[debut_social] = "http://drupalcode.org/project/debut_social.git/blob_plain/refs/heads/7.x-1.x:/debut_social.make.inc"
; includes[debut_wysiwyg] = "http://drupalcode.org/project/debut_wysiwyg.git/blob_plain/refs/heads/7.x-1.x:/debut_wysiwyg.make.inc"

; Projects specific to Open Outreach.
projects[admin_menu][subdir] = contrib
projects[admin_menu][version] = 3.0-rc3
projects[apps][subdir] = contrib
; Use the Dev version until app display issues are resolved in next stable
; release after 1.0-beta6.
projects[apps][version] = 1.x-dev
; Since this patch conflicts with one below, using a combined version.
; projects[apps][patch][http://drupal.org/files/1479164-apps-permissions-check-modules-not-conf-reroll.patch] = http://drupal.org/files/1479164-apps-permissions-check-modules-not-conf-reroll.patch
projects[apps][patch][http://drupal.org/files/skip-install-tasks-1714552-1+apps-permissions-check-1479164.patch] = http://drupal.org/files/skip-install-tasks-1714552-1+apps-permissions-check-1479164.patch
projects[apps][patch][http://drupal.org/files/profile-libraries-1623338-1.patch] = http://drupal.org/files/profile-libraries-1623338-1.patch
projects[apps_compatible][subdir] = contrib
projects[apps_compatible][version] = 1.x-dev
projects[designkit][subdir] = contrib
projects[designkit][version] = 1.0-beta1
projects[fusion][subdir] = contrib
projects[fusion][version] = 2.0-beta2
projects[fusion_accelerator][subdir] = contrib
projects[fusion_accelerator][version] = 2.0-beta1
projects[granada][subdir] = contrib
projects[granada][version] = 2.0-beta1
projects[mix_and_match][subdir] = contrib
projects[mix_and_match][version] = 1.0
projects[mix_and_match][patch][http://drupal.org/files/mix_and_match-fusion_apply-1372052-7.patch] = http://drupal.org/files/mix_and_match-fusion_apply-1372052-7.patch
projects[panels][subdir] = contrib
projects[panels][version] = 3.2


; TODO: delete everything below once http://drupal.org/node/1427752 is fixed.
projects[advanced_forum][subdir] = contrib
projects[advanced_forum][version] = 2.0
projects[advanced_help][subdir] = contrib
projects[calendar][subdir] = contrib
projects[calendar][version] = 3.4
projects[captcha][subdir] = contrib
projects[captcha][version] = 1.0-beta2
projects[comment_notify][subdir] = contrib
projects[comment_notify][version] = 1.1
projects[content_access][subdir] = contrib
projects[content_access][version] = 1.x-dev
projects[context][subdir] = contrib
projects[context][version] = 3.0-beta3
projects[ctools][subdir] = contrib
projects[ctools][version] = 1.0
projects[date][subdir] = contrib
projects[date][version] = 2.5
projects[debut_article][subdir] = contrib
projects[debut_article][version] = 1.0-rc1
projects[debut_bio][subdir] = contrib
projects[debut_bio][version] = 1.0-rc1
projects[debut_blog][subdir] = contrib
projects[debut_blog][version] = 1.0-rc1
projects[debut_comment][subdir] = contrib
projects[debut_comment][version] = 1.0-rc1
projects[debut_event][subdir] = contrib
projects[debut_event][version] = 1.0-rc1
projects[debut_forum][subdir] = contrib
projects[debut_forum][version] = 1.0-rc1
projects[debut_highlighted][subdir] = contrib
projects[debut_highlighted][version] = 1.0-rc1
projects[debut_link][subdir] = contrib
projects[debut_link][version] = 1.0-rc1
projects[debut_media][subdir] = contrib
projects[debut_media][version] = 1.0-rc1
projects[debut_member][subdir] = contrib
projects[debut_member][version] = 1.0-beta1
projects[debut_section][subdir] = contrib
projects[debut_section][version] = 1.0-rc1
projects[debut_seo][subdir] = contrib
projects[debut_seo][version] = 1.0-rc1
projects[debut_social][subdir] = contrib
projects[debut_social][version] = 1.0-rc1
projects[debut][subdir] = contrib
projects[debut][version] = 1.0-rc1
projects[debut_wysiwyg][subdir] = contrib
projects[debut_wysiwyg][version] = 1.0-rc1
projects[entity][subdir] = contrib
projects[entity][version] = 1.0-rc3
projects[eva][subdir] = contrib
projects[eva][version] = 1.x-dev
projects[features][subdir] = contrib
projects[features][version] = 1.0
projects[file_admin][subdir] = contrib
projects[file_admin][version] = 1.0-alpha1
projects[file_entity][subdir] = contrib
projects[file_entity][version] = 2.0-unstable6
projects[follow][subdir] = contrib
projects[follow][version] = 1.0-alpha1
projects[forward][subdir] = contrib
projects[forward][version] = 1.3
projects[globalredirect][subdir] = contrib
projects[globalredirect][version] = 1.5
projects[jcarousel][subdir] = contrib
projects[jcarousel][version] = 2.6
projects[libraries][subdir] = contrib
projects[libraries][version] = 1.0
projects[link][subdir] = contrib
projects[link][version] = 1.0
projects[logintoboggan][subdir] = contrib
projects[logintoboggan][version] = 1.3
projects[media_browser_plus][subdir] = contrib
projects[media_browser_plus][version] = 1.0-beta3
projects[media][subdir] = contrib
projects[media][version] = 2.0-unstable6
projects[media_vimeo][subdir] = contrib
projects[media_vimeo][version] = 1.0-beta5
projects[media_youtube][subdir] = contrib
projects[media_youtube][version] = 1.0-beta3
projects[metatag][subdir] = contrib
projects[metatag][version] = 1.0-alpha7
projects[multiform][subdir] = contrib
projects[multiform][version] = 1.0
projects[pathauto][subdir] = contrib
projects[pathauto][version] = 1.1
projects[profile2][subdir] = contrib
projects[profile2][version] = 1.2
projects[remote_stream_wrapper][subdir] = contrib
projects[remote_stream_wrapper][version] = 1.0-beta4
projects[service_links][subdir] = contrib
projects[service_links][version] = 2.1
projects[strongarm][subdir] = contrib
projects[strongarm][version] = 2.0
projects[styles][patch][http://drupal.org/files/issues/1186624-styles-media-fields.patch] = http://drupal.org/files/issues/1186624-styles-media-fields.patch
projects[styles][subdir] = contrib
projects[styles][version] = 2.0-alpha8
projects[token][subdir] = contrib
projects[token][version] = 1.1
projects[transliteration][subdir] = contrib
projects[transliteration][version] = 3.1
projects[views_slideshow][subdir] = contrib
projects[views_slideshow][version] = 3.0
projects[views][subdir] = contrib
projects[views][version] = 3.3
projects[wysiwyg][subdir] = contrib
projects[wysiwyg][version] = 2.x-dev
projects[xmlsitemap][subdir] = contrib
projects[xmlsitemap][version] = 2.0-rc1

libraries[ckeditor][directory_name] = "ckeditor"
libraries[ckeditor][download][type] = "get"
libraries[ckeditor][download][url] = "http://download.cksource.com/CKEditor/CKEditor/CKEditor%203.6.2/ckeditor_3.6.2.tar.gz"
libraries[colorbox][directory_name] = "colorbox"
libraries[colorbox][download][type] = "get"
libraries[colorbox][download][url] = "https://github.com/jackmoore/colorbox/zipball/v1.3.16"
libraries[jquery.cycle][download][type] = "get"
; Permissions wrong when specifying single file. See http://drupal.org/node/1459618.
; libraries[jquery.cycle][download][url] = "https://raw.github.com/malsup/cycle/master/jquery.cycle.all.js"
libraries[jquery.cycle][download][url] = "https://github.com/malsup/cycle/tarball/master"
; Optional so disabled for now pending a fix to http://drupal.org/node/1459618.
; libraries[json2][download][type] = "get"
; libraries[json2][download][url] = "https://github.com/douglascrockford/JSON-js/raw/master/json2.js"
