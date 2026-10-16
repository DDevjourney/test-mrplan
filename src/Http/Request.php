<?php

declare(strict_types=1);

namespace App\Http;

final class Request
{
    public function __construct(
        private string $method,
        private string $path,
        private array $query,
        private array $server,
    ) {
    }

    public static function fromGlobals(): self
    {
        $path = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH);

        return new self(
            method: strtoupper($_SERVER['REQUEST_METHOD'] ?? 'GET'),
            path: is_string($path) ? $path : '/',
            query: $_GET,
            server: $_SERVER
        );
    }

    public function method(): string
    {
        return $this->method;
    }

    public function path(): string
    {
        $ruta = rtrim($this->path, '/');

        if ($ruta === '') {
            return '/';
        }
        return $ruta;
    }

    public function query(string $clave): ?string
    {
        if (!array_key_exists($clave, $this->query)) {
            return null;
        }

        if (!is_string($this->query[$clave])) {
            return null;
        }

        return $this->query[$clave];
    }

    public function header(string $nombre): ?string
    {
        $clave = strtoupper(str_replace('-', '_', $nombre));

        if ($clave !== 'CONTENT_TYPE' && $clave !== 'CONTENT_LENGTH') {
            $clave = 'HTTP_' . $clave;
        }

        $valor = $this->server[$clave] ?? null;

        return is_string($valor) ? $valor : null;
    }
}