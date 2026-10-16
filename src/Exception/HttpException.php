<?php
abstract class HttpException extends \RuntimeException
{
    public function __construct(
        string $message,
        private int $statusCode,
        private string $errorCode,
    ) {
        parent::__construct($message);
    }

    public function statusCode(): int { return $this->statusCode; }
    public function errorCode(): string { return $this->errorCode; }
}