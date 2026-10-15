<?php
declare(strict_types=1);

$config = require __DIR__ . '/../src/bootstrap.php';
$pdo = App\Database::connect($config);

echo $pdo->query('SELECT COUNT(*) FROM reserva')->fetchColumn();