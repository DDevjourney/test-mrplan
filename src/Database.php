<?php

declare(strict_types=1);

namespace App;

use PDO;

final class Database
{
    public static function connect(Config $config): PDO
    {
        $dsn = sprintf(
            'mysql:host=%s;port=%d;dbname=%s;charset=utf8mb4',
            $config->dbHost(),
            $config->dbPort(),
            $config->dbName()
        );
        $opciones = [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ];
        if ($config->dbSslCa() !== null) {
            $opciones[\Pdo\Mysql::ATTR_SSL_CA] = $config->dbSslCa();
        }
        $pdo = new PDO($dsn, $config->dbUser(), $config->dbPass(), $opciones);

        $desfase = (new \DateTimeImmutable())->format('P'); // por ejemplo '+02:00'
        $pdo->prepare('SET time_zone = ?')->execute([$desfase]);

        return $pdo;

    }
}