<?php

declare(strict_types=1);

$config['config_split.config_split.local']['status'] = FALSE;
$config['config_split.config_split.stage']['status'] = TRUE;
$config['config_split.config_split.prod']['status'] = FALSE;

$config['stage_file_proxy.settings']['origin'] = getenv('STAGE_FILE_PROXY_ORIGIN') ?: '';
$config['stage_file_proxy.settings']['hotlink'] = TRUE;
$config['stage_file_proxy.settings']['verify'] = TRUE;
