<?php

declare(strict_types=1);

/**
 * @file
 * Drupal settings for container-based multi-environment deployments.
 */

use Drupal\Core\Installer\InstallerKernel;

$databases['default']['default'] = [
  'database' => getenv('DB_NAME') ?: 'drupal',
  'username' => getenv('DB_USER') ?: 'drupal',
  'password' => getenv('DB_PASSWORD') ?: 'drupal',
  'prefix' => '',
  'host' => getenv('DB_HOST') ?: 'db',
  'port' => getenv('DB_PORT') ?: '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => getenv('DB_DRIVER') ?: 'mysql',
  'collation' => 'utf8mb4_general_ci',
];

$settings['hash_salt'] = getenv('DRUPAL_HASH_SALT') ?: 'replace-me';
$settings['config_sync_directory'] = dirname(__DIR__, 3) . '/config/sync';

// Keep split storage explicit and portable across local and PaaS containers.
$config['config_split.config_split.local']['folder'] = '../config/splits/local';
$config['config_split.config_split.stage']['folder'] = '../config/splits/stage';
$config['config_split.config_split.prod']['folder'] = '../config/splits/prod';

$settings['file_private_path'] = getenv('DRUPAL_FILES_PRIVATE_PATH') ?: '/var/www/private';
$settings['file_temp_path'] = getenv('DRUPAL_FILES_TEMP_PATH') ?: '/tmp';

$settings['skip_permissions_hardening'] = TRUE;

$trusted_hosts = getenv('TRUSTED_HOST_PATTERNS') ?: '^localhost$,^127\\.0\\.0\\.1$';
$settings['trusted_host_patterns'] = array_values(array_filter(array_map('trim', explode(',', $trusted_hosts))));

if (filter_var(getenv('REVERSE_PROXY') ?: false, FILTER_VALIDATE_BOOLEAN)) {
  $settings['reverse_proxy'] = TRUE;
  $settings['reverse_proxy_addresses'] = [
    '127.0.0.1',
    '::1',
    '172.16.0.0/12',
    '10.0.0.0/8',
  ];
  $settings['reverse_proxy_trusted_headers'] = \Symfony\Component\HttpFoundation\Request::HEADER_X_FORWARDED_FOR | \Symfony\Component\HttpFoundation\Request::HEADER_X_FORWARDED_HOST | \Symfony\Component\HttpFoundation\Request::HEADER_X_FORWARDED_PROTO | \Symfony\Component\HttpFoundation\Request::HEADER_X_FORWARDED_PORT;
}

if (
  getenv('REDIS_HOST')
  && extension_loaded('redis')
  && !InstallerKernel::installationAttempted()
  && file_exists(DRUPAL_ROOT . '/modules/contrib/redis/redis.services.yml')
) {
  $settings['redis.connection']['interface'] = 'PhpRedis';
  $settings['redis.connection']['host'] = getenv('REDIS_HOST');
  $settings['redis.connection']['port'] = (int) (getenv('REDIS_PORT') ?: 6379);
  $settings['cache']['default'] = 'cache.backend.redis';
  $settings['cache_prefix']['default'] = getenv('APP_NAME') ?: 'drupal_template';

  $settings['container_yamls'][] = DRUPAL_ROOT . '/modules/contrib/redis/example.services.yml';
  $settings['container_yamls'][] = DRUPAL_ROOT . '/modules/contrib/redis/redis.services.yml';

  $class_loader->addPsr4('Drupal\\redis\\', DRUPAL_ROOT . '/modules/contrib/redis/src');
}

$config['system.performance']['css']['preprocess'] = TRUE;
$config['system.performance']['js']['preprocess'] = TRUE;

$app_env = getenv('APP_ENV') ?: 'local';
$env_include = __DIR__ . '/settings/settings.' . $app_env . '.php';
if (file_exists($env_include)) {
  include $env_include;
}

if (file_exists(__DIR__ . '/settings.local.php')) {
  include __DIR__ . '/settings.local.php';
}
