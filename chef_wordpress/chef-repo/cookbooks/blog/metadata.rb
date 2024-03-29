name 'blog'
maintainer 'Grupo del Master DevOps'
maintainer_email 'maintainer@example.com'
license 'All Rights Reserved'
description 'Installs/Configures a wordpress blog with 2 posts'
version '0.1.0'
chef_version '>= 16.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/blog/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/blog'

depends 'apache2'
depends 'php'
depends 'mysql'
depends 'yum-mysql-community'