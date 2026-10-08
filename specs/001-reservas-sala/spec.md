# Feature Specification: Reservas de sala

**Feature Branch**: `001-reservas-sala`
**Created**: 2026-10-01
**Status**: Draft

## User Scenarios & Testing

### User Story 1 — Reservar una sala (Priority: P1)

Como estudiante autenticado, quiero reservar una sala de estudio por un intervalo de tiempo
para tener dónde trabajar con mi grupo.

**Why this priority**: sin reservas, la app no tiene propósito.

**Independent Test**: se puede probar creando una reserva y comprobando que queda registrada.

**Acceptance Scenarios**:

1. **Dado** que la sala A está libre, **Cuando** la reservo de 09:00 a 10:00, **Entonces** la
   reserva queda registrada a mi nombre.
2. **Dado** que elijo como inicio las 10:00 y como fin las 09:00, **Cuando** intento reservar,
   **Entonces** la reserva se rechaza con el mensaje "La hora de fin debe ser posterior a la de inicio".
3. **Dado** que la sala A tiene una reserva de 09:00 a 10:00, **Cuando** intento reservarla de
   09:30 a 10:30, **Entonces** la solicitud se rechaza con el mensaje
   "La sala ya está reservada en ese horario".
4. **Dado** que la sala A tiene una reserva de 09:00 a 12:00, **Cuando** intento reservarla de
   10:00 a 11:00, **Entonces** la solicitud se rechaza con el mensaje
   "La sala ya está reservada en ese horario".
5. **Dado** que la sala A tiene una reserva de 10:00 a 11:00, **Cuando** intento reservarla de
   09:00 a 12:00, **Entonces** la solicitud se rechaza con el mensaje
   "La sala ya está reservada en ese horario".
6. **Dado** que la sala A tiene una reserva de 09:00 a 10:00, **Cuando** intento reservarla de
   10:00 a 11:00, **Entonces** la nueva reserva queda registrada porque los intervalos son
   consecutivos.
7. **Dado** que la sala A tiene una reserva de 09:00 a 10:00, **Cuando** intento reservar la sala B
   de 09:30 a 10:30, **Entonces** la nueva reserva queda registrada porque el solapamiento ocurre
   en otra sala.

### Edge Cases

- Los intervalos de una reserva incluyen la hora de inicio y excluyen la hora de fin: `[inicio, fin)`.
- La hora de fin debe ser posterior a la hora de inicio.
- Dos reservas de la misma sala se solapan cuando comparten algún instante dentro de sus intervalos.

## Requirements

### Functional Requirements

- **FR-001**: El estudiante puede solicitar una reserva indicando una sala y las horas de inicio y
  fin.
- **FR-002**: La hora de fin debe ser posterior a la hora de inicio; cada intervalo incluye el
  inicio y excluye el fin.
- **FR-003**: El sistema rechaza una solicitud cuyo intervalo se solape con una reserva existente
  de la misma sala.
- **FR-004**: Al rechazar una solicitud por solapamiento, el sistema muestra el mensaje
  "La sala ya está reservada en ese horario".
- **FR-005**: Los intervalos consecutivos de una misma sala no se consideran solapados.
- **FR-006**: Las reservas de salas distintas no se consideran solapadas entre sí.
- **FR-007**: Una solicitud aceptada queda registrada a nombre del estudiante para la sala y el
  intervalo indicados.

### Key Entities

- **Reserva**: sala, estudiante, inicio y fin.
- **Sala**: identificada por su nombre (Sala A, Sala B, Sala C).

## Success Criteria

- **SC-001**: Un estudiante completa una reserva en menos de 30 segundos.
