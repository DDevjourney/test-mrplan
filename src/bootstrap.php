<?php

declare(strict_types=1);

require __DIR__ . '/../vendor/autoload.php';
cargarEnv(__DIR__ . '/../.env');
$config = new App\Config();
date_default_timezone_set('Europe/Madrid');
error_reporting(E_ALL);
ini_set('display_errors', $config->isDev() ? '1' : '0');
return $config;
function cargarEnv(string $ruta): void
{
    if (!is_file($ruta)) {
        return;
    }

    foreach (file($ruta, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $linea) {
        // 1. saltar las líneas que empiecen por '#'
        // 2. partir por el PRIMER '=' con explode('=', $linea, 2) y hacer trim a clave y valor
        // 3. si getenv($clave) === false, hacer putenv("$clave=$valor")

        if (str_starts_with($linea, '#')) {
            continue;
        }

        [$clave, $valor] = explode('=', $linea, 2);
        $clave = trim($clave);
        $valor = trim($valor);

        if (getenv($clave) === false) {
            putenv("$clave=$valor");
        }   
    }
}