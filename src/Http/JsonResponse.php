<?php

declare(strict_types=1);

namespace App\Http;

final class JsonResponse
{
    public function __construct(
        private mixed $data,
        private int $status = 200,
        private array $headers = [],
    ) {}

    public function send(): void
    {
        http_response_code($this->status);
        header('Content-Type: application/json; charset=utf-8');

        foreach ($this->headers as $nombre => $valor) {
            header("$nombre: $valor");
        }

        echo json_encode(
            $this->data,
            JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_THROW_ON_ERROR
        ); // flags para que no escape caracteres unicode ni slashes y lance excepcion en caso de error
    }
    
}

