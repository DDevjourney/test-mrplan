<?php

declare(strict_types=1);

namespace App;

use RuntimeException;

final class Config
{
    public static function get(string $clave, ?string $porDefecto = null): string
    {
        $valor = getenv($clave);

        if ($valor === false) {
            if ($porDefecto !== null) {
                return $porDefecto;
            }
            throw new RuntimeException("Falta la variable de entorno $clave");
        }
        return $valor;
        // recorre el env para que no haya fallos. Si por defecto es null,
    }

    public function dbHost(): string
    {
        return $this->get('DB_HOST');
    }
    public function dbPort(): int
    {
        return (int) $this->get('DB_PORT', '3306');
    }
    public function dbUser(): string
    {
        return $this->get('DB_USER');
    }
    public function dbName(): string
    {
        return $this->get('DB_NAME');
    }
    public function isDev(): bool
    {
        return $this->get('APP_ENV', 'prod') === 'dev';
    }
    public function dbPass(): string
    {
        return $this->get('DB_PASS');
    }
    public function dbSslCa(): ?string
    {
        $ruta = $this->get('DB_SSL_CA', '');

        return $ruta === '' ? null : $ruta;
    }
}