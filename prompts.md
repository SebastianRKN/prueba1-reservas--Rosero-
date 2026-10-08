# Prompts de la prueba

Transcripcion literal del campo "My request" de los mensajes del usuario, en orden, incluida la respuesta a la aclaracion. Se conservan errores de escritura y solicitudes repetidas. El contexto automatico del IDE y los mensajes tecnicos se conservan en los archivos de sesion del ZIP.

## 1. Prompt

````text
clona este repositorio en abrelo en vs code [https://github.com/SebastianRKN/prueba1-reservas--Rosero-.git](https://github.com/SebastianRKN/prueba1-reservas--Rosero-.git)

````

## 2. Prompt

````text
crea una rama llamada prueba/solapamiento, vamos a trabajar sobre spec.md sin embargo las decisciones van a ser mias, puedes leer plan.md y constitution.md pero estas no se van a modificar son la referencia.- No cambies la firma de `CrearReserva`. Recibe un `ReservasRepository`.
- No cambies la interfaz `ReservasRepository`.
- Las pruebas no usan red ni Supabase.
- No necesitas ejecutar la app (`flutter run`): todo se comprueba con `flutter test`.
- Antes de empezar, `flutter test` está en verde. Si no lo está, levanta la mano.
- Trabajas en tu propio repositorio, en la rama `prueba/solapamiento`.
- Fuera de alcance: cancelaciones, pantallas nuevas, despliegue y un refactor de toda la arquitectura.

````

## 3. Prompt

````text
Lee el repositorio y analiza constitution.md, spec.md, plan.md, CrearReserva, ReservasRepository, las pruebas existentes, el repositorio No modifiques ningún archivo, no hagas commits y no ejecutes comandos de Spec Kit.

  Explica cómo funciona actualmente CrearReserva, qué falta para impedir reservas solapadas y qué riesgos observas. Identifica las rutas relevantes. Espera mis instrucciones antes de editar.

````

## 4. Prompt

````text
Modifica únicamente specs/001-reservas, conserva los dos escenarios originales y añade al menos cuatro escenarios nuevos en formato Dado/Cuando/Entonces para la regla de solapamiento. incluye solapamiento parcial, inclusión total, reservas consecutivas y reservas en salas distintas. define los intervalos (inicio y fin) y el mensaje  de rechazo: "La sala ya está reservada en ese horario".El documento debe describir únicamente el QUÉ, sin widgets, setstate, paquetes ni rutas de implementación. no modifiques plan ni constitution, no escribas pruebas ni código de producción y no hagas commits. Al terminar, muéstrame los cambios.  

````

## 5. Prompt

````text
has un comit con el nombre " spec reglas de solapamiento ", asegurate antes de hacerlo que de que solo se haya modificado lo mencionado anteriormente y nada mas 

````

## 6. Prompt

````text
implemente unicamente las reglas de solapamiento, en el archivo test/crear_reserva_test.dart, hazlo usando el repositorio de memoria no uses supabase ni alguna red,. comprueba los solapamientos que puedan haber en ambas direcciones, horarios identicos, reservas consecutivas, salas diferentes,  asegurate de que las pruebas de rechazo den el mensaje "La sala ya esta reservada en este horario", no modifiques las interfaces ni la produccion que hemos llevado  hasta ahora, ejectua flutter test y asegurate que las pruebas compilen pero fallen por aserciones, OJO estos fallos no deben ser por compilacion, no arregles los errores que te den, ni hagas commits

````

## 7. Prompt

````text
implemente la regla de solapamiento en lib/domain/crear_reserva.dart, asegurate de respetar la constitucion que hemos llevado hasta ahora, junto con el spec y el plan,manten la firma de crear reserva,  y laa interfaz. Consulta las reservas existentes por resrevasdesala, y rechaza las solicitudes que cumplan con Nuevoinicio<existenciafin && existenteInicio < nuevoFin para la misma sala. Usa el mismo mensaje "La sala ya está reservada en ese horario". Conserva la validación previa de horas. no cambies las aserciones ni los escenarios de test, no agregues red ni Supabase y evita refactors fuera de alcance. Ejecuta flutter test hasta lograr que todas las pruebas pasen. No hagas commits. Muéstrame las modificaciones y los resultados.

````

## 8. Prompt

````text
implemente la regla de solapamiento en lib/domain/crear_reserva.dart, asegurate de respetar la constitucion que hemos llevado hasta ahora, junto con el spec y el plan,manten la firma de crear reserva,  y laa interfaz. Consulta las reservas existentes por resrevasdesala, y rechaza las solicitudes que cumplan con Nuevoinicio<existenciafin && existenteInicio < nuevoFin para la misma sala. Usa el mismo mensaje "La sala ya está reservada en ese horario". Conserva la validación previa de horas. no cambies las aserciones ni los escenarios de test, no agregues red ni Supabase y evita refactors fuera de alcance. Ejecuta flutter test hasta lograr que todas las pruebas pasen. No hagas commits. Muéstrame las modificaciones y los resultados.

````

## 9. Prompt

````text
implemente la regla de solapamiento en lib/domain/crear_reserva.dart, asegurate de respetar la constitucion que hemos llevado hasta ahora, junto con el spec y el plan,manten la firma de crear reserva,  y laa interfaz. Consulta las reservas existentes por resrevasdesala, y rechaza las solicitudes que cumplan con Nuevoinicio<existenciafin && existenteInicio < nuevoFin para la misma sala. Usa el mismo mensaje "La sala ya está reservada en ese horario". Conserva la validación previa de horas. no cambies las aserciones ni los escenarios de test, no agregues red ni Supabase y evita refactors fuera de alcance. Ejecuta flutter test hasta lograr que todas las pruebas pasen. No hagas commits. Muéstrame las modificaciones y los resultados.

````

## 10. Respuesta a aclaracion

````text
Texto de la spec; autorizar cambiar solo esa aserción
````

## 11. Prompt

````text
ahora has un commit con este nombre "feat: validar solapamiento GREEN"

````

## 12. Prompt

````text
continua desde donde te quedaste 

````

## 13. Prompt

````text
aahora has \`RESPUESTAS.md\`, en la raíz del repositorio (lo creas tú) | Tres secciones con estos títulos exactos: \`## Escenarios que elegí y por qué\`, \`## Riesgo más grave del repositorio\`, \`## ¿La regla protege la app real?\`. Cada afirmación cita la evidencia como \`ruta:línea\` (por ejemplo, \`lib/domain/crear_reserva.dart:12\`) y explica qué muestra esa línea. Extensión recomendada: hasta **\*\*400 palabras\*\*** en total. junto con prompts.md\`, en la raíz del repositorio (lo creas tú), y \`sesion-\<apellido>.zip\`, **\*\*fuera\*\*** del repositorio | En \`prompts.md\`, los prompts que le diste al agente, en orden, copiados tal cual. El \`.zip\` tiene los archivos de sesión de Codex de la prueba (ver abajo). **\*\*El \`.zip\` no se sube a GitHub\*\***: solo al aula virtual. |

````
