CREATE DATABASE IF NOT EXISTS reservas CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE reservas;

DROP TABLE IF EXISTS reserva_evento;
DROP TABLE IF EXISTS reserva;

-- creamos la BBDD

CREATE TABLE reserva (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_huesped VARCHAR(100) NOT NULL,
    email_huesped VARCHAR(100) NOT NULL,
    nombre_alojamiento VARCHAR(100) NOT NULL,
    fecha_entrada DATE NOT NULL,
    fecha_salida DATE NOT NULL,
    estado ENUM('pendiente', 'confirmada', 'cancelada') NOT NULL DEFAULT 'pendiente',
    importe DECIMAL(10, 2) NOT NULL,
    notas TEXT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_estado (estado),
    INDEX idx_fechas (fecha_entrada, fecha_salida),
    INDEX idx_nombre (nombre_huesped),
    CONSTRAINT chk_fecha CHECK (fecha_entrada < fecha_salida),
    CONSTRAINT chk_importe CHECK (importe >= 0)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- El estado ENUM siempre debe tener un valor por defecto, en este caso 'pendiente', para evitar errores al insertar registros sin especificar el estado.

CREATE TABLE reserva_evento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reserva_id INT NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_evento_reserva (reserva_id, fecha_creacion),
    CONSTRAINT fk_evento_reserva FOREIGN KEY (reserva_id) REFERENCES reserva(id) ON DELETE CASCADE
    )
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- Datos de ejemplo
-- ============================================================

-- Reservas (ids explícitos para poder referenciarlas desde los eventos)
INSERT INTO reserva
    (id, nombre_huesped, email_huesped, nombre_alojamiento, fecha_entrada, fecha_salida, estado, importe, notas, fecha_creacion)
VALUES
    (1,  'Lucía García Martín',   'lucia.garcia@example.com',        'Hotel Mirador de la Alhambra',    '2026-09-04', '2026-09-08', 'confirmada', 520.00,  NULL,                                          '2026-08-12 10:15:00'),
    (2,  'Javier Núñez Peña',     'javier.nunez@example.com',        'Apartamentos Playa de la Concha', '2026-09-12', '2026-09-19', 'confirmada', 910.50,  'Solicita cuna en la habitación',          '2026-08-20 18:42:00'),
    (3,  'María José García',     'mariajose.garcia@example.com',    'Casa Rural El Roble',             '2026-09-20', '2026-09-22', 'cancelada',  240.00,  'Cancelada por enfermedad',                 '2026-08-30 09:05:00'),
    (4,  'Íñigo Ibarra',          'inigo.ibarra@example.com',        'Hotel Gran Vía Madrid',           '2026-10-09', '2026-10-12', 'confirmada', 468.00,  NULL,                                          '2026-09-15 12:30:00'),
    (5,  'Carmen Ruiz Soto',      'carmen.ruiz@example.com',         'Parador de Ronda',                '2026-10-18', '2026-10-21', 'confirmada', 615.75,  'Late check-out solicitado',               '2026-09-25 17:00:00'),
    (6,  'Pablo Fernández',       'pablo.fernandez@example.com',     'Apartamentos Playa de la Concha', '2026-10-22', '2026-10-25', 'pendiente',  330.00,  NULL,                                          '2026-10-08 20:15:00'),
    (7,  'Nuria Castañeda',       'nuria.castaneda@example.com',     'Hostal Plaza Mayor',              '2026-10-30', '2026-11-02', 'pendiente',  285.00,  'Llegada tarde <b>después de las 23h</b>',  '2026-10-10 22:40:00'),
    (8,  'Andrés García López',   'andres.garcia@example.com',       'Hotel Mirador de la Alhambra',    '2026-11-05', '2026-11-08', 'confirmada', 645.90,  NULL,                                          '2026-10-01 11:05:00'),
    (9,  'Elena Vidal',           'elena.vidal@example.com',         'Casa Rural El Roble',             '2026-11-14', '2026-11-16', 'cancelada',  260.00,  NULL,                                          '2026-09-28 13:20:00'),
    (10, 'Sergio Moreno Gil',     'sergio.moreno@example.com',       'Hotel Costa Brava Sunset',        '2026-11-20', '2026-11-27', 'pendiente',  1180.00, 'Viaje con dos niños',                      '2026-10-13 19:30:00'),
    (11, 'Ainhoa Etxeberria',     'ainhoa.etxeberria@example.com',   'Hotel Gran Vía Madrid',           '2026-12-04', '2026-12-07', 'pendiente',  540.00,  NULL,                                          '2026-10-14 08:50:00'),
    (12, 'Raúl Domínguez',        'raul.dominguez@example.com',      'Parador de Ronda',                '2026-12-26', '2027-01-02', 'confirmada', 1890.00, 'Cena de Nochevieja incluida',              '2026-10-03 16:10:00'),
    (13, 'Beatriz Salvà',         'beatriz.salva@example.com',       'Hotel Costa Brava Sunset',        '2027-03-12', '2027-03-15', 'pendiente',  420.00,  NULL,                                          '2026-10-14 21:05:00'),
    (14, 'Tomás Álvarez',         'tomas.alvarez@example.com',       'Hostal Plaza Mayor',              '2027-04-02', '2027-04-06', 'cancelada',  380.00,  NULL,                                          '2026-10-05 10:25:00'),
    (15, 'Marta Sánchez García',  'marta.sanchez@example.com',       'Apartamentos Playa de la Concha', '2027-07-10', '2027-07-24', 'pendiente',  1750.25, NULL,                                          '2026-10-15 07:55:00');

-- Historial de eventos (coherente con el estado de cada reserva)
INSERT INTO reserva_evento
    (id, reserva_id, tipo, descripcion, fecha_creacion)
VALUES
    (1,  1,  'creada',     'Reserva creada para Lucía García Martín en Hotel Mirador de la Alhambra',      '2026-08-12 10:15:00'),
    (2,  1,  'confirmada', 'Estado cambiado de pendiente a confirmada',                                    '2026-08-12 16:40:00'),
    (3,  2,  'creada',     'Reserva creada para Javier Núñez Peña en Apartamentos Playa de la Concha',     '2026-08-20 18:42:00'),
    (4,  2,  'confirmada', 'Estado cambiado de pendiente a confirmada',                                    '2026-08-21 09:10:00'),
    (5,  3,  'creada',     'Reserva creada para María José García en Casa Rural El Roble',                 '2026-08-30 09:05:00'),
    (6,  3,  'confirmada', 'Estado cambiado de pendiente a confirmada',                                    '2026-08-31 10:00:00'),
    (7,  3,  'cancelada',  'Estado cambiado de confirmada a cancelada',                                    '2026-09-10 11:20:00'),
    (8,  4,  'creada',     'Reserva creada para Íñigo Ibarra en Hotel Gran Vía Madrid',                    '2026-09-15 12:30:00'),
    (9,  4,  'confirmada', 'Estado cambiado de pendiente a confirmada',                                    '2026-09-16 08:55:00'),
    (10, 5,  'creada',     'Reserva creada para Carmen Ruiz Soto en Parador de Ronda',                     '2026-09-25 17:00:00'),
    (11, 5,  'confirmada', 'Estado cambiado de pendiente a confirmada',                                    '2026-09-26 10:30:00'),
    (12, 6,  'creada',     'Reserva creada para Pablo Fernández en Apartamentos Playa de la Concha',       '2026-10-08 20:15:00'),
    (13, 7,  'creada',     'Reserva creada para Nuria Castañeda en Hostal Plaza Mayor',                    '2026-10-10 22:40:00'),
    (14, 8,  'creada',     'Reserva creada para Andrés García López en Hotel Mirador de la Alhambra',      '2026-10-01 11:05:00'),
    (15, 8,  'confirmada', 'Estado cambiado de pendiente a confirmada',                                    '2026-10-02 09:00:00'),
    (16, 9,  'creada',     'Reserva creada para Elena Vidal en Casa Rural El Roble',                       '2026-09-28 13:20:00'),
    (17, 9,  'confirmada', 'Estado cambiado de pendiente a confirmada',                                    '2026-09-29 10:00:00'),
    (18, 9,  'cancelada',  'Estado cambiado de confirmada a cancelada',                                    '2026-10-12 15:45:00'),
    (19, 10, 'creada',     'Reserva creada para Sergio Moreno Gil en Hotel Costa Brava Sunset',            '2026-10-13 19:30:00'),
    (20, 11, 'creada',     'Reserva creada para Ainhoa Etxeberria en Hotel Gran Vía Madrid',               '2026-10-14 08:50:00'),
    (21, 12, 'creada',     'Reserva creada para Raúl Domínguez en Parador de Ronda',                       '2026-10-03 16:10:00'),
    (22, 12, 'confirmada', 'Estado cambiado de pendiente a confirmada',                                    '2026-10-04 12:00:00'),
    (23, 13, 'creada',     'Reserva creada para Beatriz Salvà en Hotel Costa Brava Sunset',                '2026-10-14 21:05:00'),
    (24, 14, 'creada',     'Reserva creada para Tomás Álvarez en Hostal Plaza Mayor',                      '2026-10-05 10:25:00'),
    (25, 14, 'cancelada',  'Estado cambiado de pendiente a cancelada',                                     '2026-10-06 09:40:00'),
    (26, 15, 'creada',     'Reserva creada para Marta Sánchez García en Apartamentos Playa de la Concha',  '2026-10-15 07:55:00');

-- Historial de mis fallos: sobre todo, síntaxis ("," o ";").