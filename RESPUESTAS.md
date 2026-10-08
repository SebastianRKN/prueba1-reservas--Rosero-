## Escenarios que elegí y por qué

- Elegí solapamientos parciales en ambos sentidos para comprobar que se rechaza tanto empezar dentro de una reserva como terminar dentro de ella: `test/crear_reserva_test.dart:77` solicita 09:30–10:30 sobre 09:00–10:00, y `test/crear_reserva_test.dart:87` solicita el intervalo inverso respecto de la reserva existente.
- Incluí horarios idénticos y contención en ambas direcciones: `test/crear_reserva_test.dart:96` repite 09:00–10:00; `test/crear_reserva_test.dart:105` solicita 10:00–11:00 dentro de 09:00–12:00; `test/crear_reserva_test.dart:114` solicita 09:00–12:00 alrededor de 10:00–11:00. Estos casos evitan limitar la detección a cruces parciales.
- Elegí reservas consecutivas para comprobar que compartir únicamente un extremo está permitido: `test/crear_reserva_test.dart:125` solicita empezar al terminar la existente y `test/crear_reserva_test.dart:136` solicita terminar cuando empieza la existente.
- Incluí salas distintas para evitar rechazos entre salas independientes: `test/crear_reserva_test.dart:143` registra en Sala A y `test/crear_reserva_test.dart:146` solicita un horario coincidente en Sala B.

## Riesgo más grave del repositorio

Considero más grave la posibilidad de atribuir reservas a otro usuario: `supabase/migracion.sql:24` permite insertar con `with check (true)`, sin exigir que el propietario coincida con la identidad autenticada. `lib/presentation/reserva_page.dart:89` conecta un campo editable al controlador del usuario y `lib/presentation/reserva_page.dart:62` envía ese valor como propietario. La referencia de `supabase/migracion.sql:7` exige un usuario existente, pero no comprueba que sea quien realiza la operación.

## ¿La regla protege la app real?

Protege las llamadas al caso de uso: `lib/domain/crear_reserva.dart:16` consulta reservas de la sala y `lib/domain/crear_reserva.dart:18` junto con `lib/domain/crear_reserva.dart:19` comparan estrictamente ambos extremos. Sin embargo, `lib/presentation/reserva_page.dart:60` inserta directamente en Supabase, omitiendo esa validación; por eso la pantalla actual puede crear solapamientos.

Además, `lib/domain/crear_reserva.dart:16` consulta y `lib/domain/crear_reserva.dart:26` guarda en operaciones separadas, lo que permite una carrera entre solicitudes simultáneas. `supabase/migracion.sql:11` solo comprueba que fin sea posterior a inicio: el esquema mostrado no impide solapamientos entre filas.
