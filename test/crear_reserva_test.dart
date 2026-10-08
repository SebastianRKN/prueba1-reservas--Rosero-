import 'package:flutter_test/flutter_test.dart';
import 'package:reservas_sala/domain/crear_reserva.dart';
import 'package:reservas_sala/domain/reserva.dart';

import 'support/reservas_en_memoria.dart';

DateTime hora(int h, [int m = 0]) => DateTime(2026, 10, 14, h, m);

void main() {
  late ReservasEnMemoria repositorio;
  late CrearReserva crearReserva;

  setUp(() {
    repositorio = ReservasEnMemoria();
    crearReserva = CrearReserva(repositorio);
  });

  Future<void> sembrarReserva(
      String salaId, DateTime inicio, DateTime fin) async {
    await repositorio.guardar(SolicitudReserva(
      salaId: salaId,
      usuarioId: 'u1',
      inicio: inicio,
      fin: fin,
    ));
  }

  Future<ResultadoReserva> solicitarReserva(
    String salaId,
    DateTime inicio,
    DateTime fin,
  ) {
    return crearReserva(SolicitudReserva(
      salaId: salaId,
      usuarioId: 'u1',
      inicio: inicio,
      fin: fin,
    ));
  }

  void esperarRechazoPorSolapamiento(ResultadoReserva resultado) {
    expect(resultado.mensaje, 'La sala ya está reservada en ese horario');
    expect(resultado.aceptada, isFalse);
  }

  test('acepta una reserva válida y la guarda', () async {
    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(9),
      fin: hora(10),
    ));

    expect(resultado.aceptada, isTrue);
    expect(repositorio.reservas, hasLength(1));
  });

  test('rechaza una reserva cuyo fin no es posterior al inicio', () async {
    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(10),
      fin: hora(9),
    ));

    expect(resultado.aceptada, isFalse);
    expect(resultado.mensaje, 'La hora de fin debe ser posterior a la de inicio');
    expect(repositorio.reservas, isEmpty);
  });

  group('reglas de solapamiento', () {
    test('rechaza el solapamiento parcial cuando la solicitud empieza dentro',
        () async {
      await sembrarReserva('Sala A', hora(9), hora(10));

      final resultado =
          await solicitarReserva('Sala A', hora(9, 30), hora(10, 30));

      esperarRechazoPorSolapamiento(resultado);
      expect(repositorio.reservas, hasLength(1));
    });

    test('rechaza el solapamiento parcial cuando la solicitud termina dentro',
        () async {
      await sembrarReserva('Sala A', hora(9, 30), hora(10, 30));

      final resultado = await solicitarReserva('Sala A', hora(9), hora(10));

      esperarRechazoPorSolapamiento(resultado);
      expect(repositorio.reservas, hasLength(1));
    });

    test('rechaza horarios idénticos', () async {
      await sembrarReserva('Sala A', hora(9), hora(10));

      final resultado = await solicitarReserva('Sala A', hora(9), hora(10));

      esperarRechazoPorSolapamiento(resultado);
      expect(repositorio.reservas, hasLength(1));
    });

    test('rechaza una solicitud contenida en la reserva existente', () async {
      await sembrarReserva('Sala A', hora(9), hora(12));

      final resultado = await solicitarReserva('Sala A', hora(10), hora(11));

      esperarRechazoPorSolapamiento(resultado);
      expect(repositorio.reservas, hasLength(1));
    });

    test('rechaza una solicitud que contiene la reserva existente', () async {
      await sembrarReserva('Sala A', hora(10), hora(11));

      final resultado = await solicitarReserva('Sala A', hora(9), hora(12));

      esperarRechazoPorSolapamiento(resultado);
      expect(repositorio.reservas, hasLength(1));
    });

    test(
        'acepta reservas consecutivas cuando la solicitud empieza al terminar la existente',
        () async {
      await sembrarReserva('Sala A', hora(9), hora(10));

      final resultado = await solicitarReserva('Sala A', hora(10), hora(11));

      expect(resultado.aceptada, isTrue);
      expect(repositorio.reservas, hasLength(2));
    });

    test(
        'acepta reservas consecutivas cuando la solicitud termina al empezar la existente',
        () async {
      await sembrarReserva('Sala A', hora(10), hora(11));

      final resultado = await solicitarReserva('Sala A', hora(9), hora(10));

      expect(resultado.aceptada, isTrue);
      expect(repositorio.reservas, hasLength(2));
    });

    test('acepta horarios solapados en salas diferentes', () async {
      await sembrarReserva('Sala A', hora(9), hora(10));

      final resultado =
          await solicitarReserva('Sala B', hora(9, 30), hora(10, 30));

      expect(resultado.aceptada, isTrue);
      expect(repositorio.reservas, hasLength(2));
    });
  });
}
