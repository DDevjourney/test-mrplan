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

        if (str_starts_with($linea, '#')) {
            continue; // saltar linea #
        }

        [$clave, $valor] = explode('=', $linea, 2); // separamos el string con explode a partir de = y después, trim
        $clave = trim($clave);
        $valor = trim($valor); 

        // Solo definimos la variable si no existe ya en el entorno: así las variables reales
        // del sistema (p. ej. las de Render en producción) tienen prioridad sobre el .env.
        // Se compara con === false porque una variable definida pero vacía (DB_PASS=) devuelve "".
        if (getenv($clave) === false) {
            putenv("$clave=$valor");
        }   
    }
}