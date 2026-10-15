# Reservas MisterPlan

Aplicación web para gestionar reservas de alojamiento, desarrollada como prueba técnica para MisterPlan. Está construida con PHP nativo (sin framework): una API JSON, páginas renderizadas en servidor con Twig y una interfaz con JavaScript que consume esa API sin recargar la página.

## Qué hace la aplicación

- **Listar reservas** con filtros combinables: por estado, por rango de fechas y por nombre del huésped.
- **Ver el detalle** de una reserva junto con su historial de eventos (timeline).
- **Crear reservas** con validación en el cliente y en el servidor, mostrando los errores que devuelva la API.
- **Confirmar o cancelar** una reserva (la cancelación pide confirmación).
- **Registrar un historial**: cada creación o cambio de estado añade un evento a la reserva.
- **Dar feedback** al usuario: estado de carga y avisos de éxito o error, incluidos los fallos de red.

Una reserva puede estar `pendiente`, `confirmada` o `cancelada`.

## Tecnologías

| Capa | Tecnología |
|---|---|
| Backend | PHP 8.4 nativo, sin framework |
| Base de datos | MySQL / MariaDB, accedida con PDO |
| Entorno local | WAMP (Apache, PHP y MySQL en Windows) |
| Vistas | Twig |
| Frontend | HTML semántico, CSS responsive y JavaScript vanilla |
| Tests | PHPUnit (quizás) |
| Dependencias | Composer (Twig, PHPUnit y autoload PSR-4) |
| Despliegue | Aún por determinar |

## Pruebas realizadas

### Base de datos (importación de `database/schema.sql`)

Tras importar el esquema y los datos de ejemplo, comprobé estas consultas en phpMyAdmin. Todas dieron el resultado esperado.

| Consulta | Resultado esperado | Resultado |
|---|---|---|
| `SELECT estado, COUNT(*) FROM reserva GROUP BY estado;` | 6 pendientes, 6 confirmadas y 3 canceladas | Correcto |
| `SELECT COUNT(*) FROM reserva_evento;` | 26 eventos | Correcto |
| `SELECT * FROM reserva WHERE nombre_huesped LIKE '%garcia%';` | 4 filas (la colación ignora los acentos) | Correcto |

## Estado

En desarrollo. El resto del README (instalación local, enlace al deploy, decisiones de diseño, mejoras pendientes y escalabilidad) se añadirá al terminar el proyecto.
