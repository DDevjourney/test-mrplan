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
| Vistas | Twig |
| Frontend | HTML semántico, CSS responsive y JavaScript vanilla |
| Tests | PHPUnit |
| Dependencias | Composer (Twig, PHPUnit y autoload PSR-4) |
| Despliegue | Docker en Render, con MySQL en Aiven |

## Estado

En desarrollo. El resto del README (instalación local, enlace al deploy, decisiones de diseño, mejoras pendientes y escalabilidad) se añadirá al terminar el proyecto.
