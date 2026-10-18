<?php

declare(strict_types=1);

namespace App\Http;

use App\Exception\MethodNotAllowedException;
use App\Exception\NotFoundException;

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

    public function dispatch(Request $request): mixed
    {
        $permitidos = [];

        foreach ($this->routes as $route) {
            if (!preg_match($route['regex'], $request->path(), $matches)) {
                continue;
            }

            // la ruta existe: apuntamos su método por si hay que responder 405
            $permitidos[] = $route['metodo'];

            if ($route['metodo'] === $request->method()) {
                // solo los parámetros con nombre (id), sin los índices numéricos
                $params = array_filter($matches, 'is_string', ARRAY_FILTER_USE_KEY);

                return $route['handler']($request, $params);
            }
        }

        if ($permitidos !== []) {
            throw new MethodNotAllowedException(array_values(array_unique($permitidos)));
        }

        throw new NotFoundException();
    }
}