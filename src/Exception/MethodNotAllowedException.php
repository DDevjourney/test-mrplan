<?php

declare(strict_types=1);

namespace App\Exception;

final class MethodNotAllowedException extends HttpException
{
    public function __construct(private array $permitidos)
    {
        parent::__construct('Método no permitido', 405, 'method_not_allowed');
    }

    public function permitidos(): array
    {
        return $this->permitidos;
    }
}