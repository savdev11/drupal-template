<?php

declare(strict_types=1);

namespace Drupal\site_starter\Drush\Commands;

use Drush\Commands\DrushCommands;

/**
 * Drush commands for baseline site operations.
 */
class SiteStarterCommands extends DrushCommands {

  /**
   * Prints environment information.
   *
   * @command site-starter:env
   * @aliases ss-env
   */
  public function env(): void {
    $env = getenv('APP_ENV') ?: 'unknown';
    $base = getenv('APP_BASE_URL') ?: 'undefined';
    $this->output()->writeln("APP_ENV: {$env}");
    $this->output()->writeln("APP_BASE_URL: {$base}");
  }

}
