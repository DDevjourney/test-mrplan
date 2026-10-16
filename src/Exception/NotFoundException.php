<?php

declare(strict_types=1);

namespace App\Exception;

final class NotFoundException extends HttpException
{
    public function __construct()
    {
        parent::__construct('Recurso no encontrado', 404, 'not_found');
    }
}
