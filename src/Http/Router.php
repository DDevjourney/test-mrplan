<?php

declare(strict_types=1);

namespace App\Http;

final class Router
{
    private array $routes = [];

    public function add(string $metodo, string $patron, callable $handler): void
    {
        $regex = '#^' . preg_replace('#\{(\w+)\}#', '(?P<$1>\d+)', $patron) . '$#';

        $this->routes[] = [
            'metodo' => $metodo,
            'regex' => $regex,
            'handler' => $handler,
        ];
    }
}