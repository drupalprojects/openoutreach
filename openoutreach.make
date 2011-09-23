; Drupal version
core = 7.x
api = 2

; Debut features.
includes[debut] = "http://drupalcode.org/project/debut.git/blob_plain/refs/heads/7.x-1.x:/debut.make.inc"
includes[debut_article] = "http://drupalcode.org/project/debut_article.git/blob_plain/refs/heads/7.x-1.x:/debut_article.make.inc"
includes[debut_blog] = "http://drupalcode.org/project/debut_blog.git/blob_plain/refs/heads/7.x-1.x:/debut_blog.make.inc"
includes[debut_comment] = "http://drupalcode.org/project/debut_comment.git/blob_plain/refs/heads/7.x-1.x:/debut_comment.make.inc"
includes[debut_event] = "http://drupalcode.org/project/debut_event.git/blob_plain/refs/heads/7.x-1.x:/debut_event.make.inc"
includes[debut_forum] = "http://drupalcode.org/project/debut_forum.git/blob_plain/refs/heads/7.x-1.x:/debut_forum.make.inc"
includes[debut_link] = "http://drupalcode.org/project/debut_link.git/blob_plain/refs/heads/7.x-1.x:/debut_link.make.inc"
includes[debut_media] = "http://drupalcode.org/project/debut_media.git/blob_plain/refs/heads/7.x-1.x:/debut_media.make.inc"
includes[debut_section] = "http://drupalcode.org/project/debut_section.git/blob_plain/refs/heads/7.x-1.x:/debut_section.make.inc"
includes[debut_social] = "http://drupalcode.org/project/debut_social.git/blob_plain/refs/heads/7.x-1.x:/debut_social.make.inc"
includes[debut_wysiwyg] = "http://drupalcode.org/project/debut_wysiwyg.git/blob_plain/refs/heads/7.x-1.x:/debut_wysiwyg.make.inc"

; Drupal 6 version of Designkit with D7 upgrade patch.
projects[designkit][download][type] = "git"
projects[designkit][download][url] = "git://git.drupal.org/project/designkit.git"
projects[designkit][download][branch] = "6.x-1.x"
projects[designkit][subdir] = contrib
projects[designkit][patch][http://drupal.org/files/issues/d7-upgrade-1036386-9.patch] = http://drupal.org/files/issues/d7-upgrade-1036386-9.patch
projects[fusion][subdir] = contrib
projects[fusion][version] = 1.0-alpha2
projects[granada][subdir] = contrib
projects[granada][version] = 1.x-dev
projects[panels][subdir] = contrib
projects[panels][version] = 3.0-alpha3
projects[skinr][subdir] = contrib
projects[skinr][version] = 2.x-dev
projects[subprofiles][subdir] = contrib
projects[subprofiles][version] = 1.x-dev
