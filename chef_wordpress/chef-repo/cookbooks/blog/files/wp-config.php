<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wpuser' );

/** MySQL database password */
define( 'DB_PASSWORD', 'wppass' );

/** MySQL hostname */
define( 'DB_HOST', '127.0.0.1' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define('FS_METHOD', 'direct');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '^etlNht{uPHdAPX6j|.LYC6Oxa6f @)4R*O:-Rw0D1NJ6;?1pS^tHQ1,0wC.cPq|');
define('SECURE_AUTH_KEY',  '=+;nt+r8HWLugl ]l_~k;zR7j$Y%SaJ>nhY`*D^djW%-;JLWK<{ee.[]n^Vkd}5^');
define('LOGGED_IN_KEY',    'YE^db2f>*u%kK4.@/+%C =>tYBZ}Y.aw@v0g8{zGaehdkyJyd[1VNUu.*puf3Q>O');
define('NONCE_KEY',        'Yv<#?p&_Hv2tPQI8|62X7gfuN*fD0^q&ac-C/3#r/A>$PE7Y2l%CyH_6iEXWh4(U');
define('AUTH_SALT',        'Tb:Kb!{cARnOCiDq40P)/N-n|{QBt8?]+k@Ax$m-oHZu7+Y|^|@Dv@!5nEYu9iZ~');
define('SECURE_AUTH_SALT', '+,.X6$BZ:|_ic}88u|y:2DjO{XH(cprg54xOJ_rj#+;KN$bG{O3BO)o?<o80+AJ>');
define('LOGGED_IN_SALT',   '`< 8143QLH*g pX44(<c{/=phhnMU{O#77HH+*)A4%A|_cJp69t@ZMPxp+zwen.B');
define('NONCE_SALT',       'FUiHI|3_c0-.t*8<7($%[u4-3*oC0zn]6!mGC8O+4#}c%-2w_h>1~8-<65Z/<1r:');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';
/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';