
# Lotería primitiva
Se trata de desarrollar una base de datos para gestionar el juego de la lotería primitiva.
Para simplificar el juego, consideramos las siguientes restricciones:
-	No se implementará el juego del jackpot
-	Cada boleto contendrá una sola apuesta, que puede ser simple o múltiple
-	Cada boleto participa en un único sorteo.

### Programación parte 1

- Implementa un procedimiento almacenado GrabaSencilla que grabe una apuesta simple. Datos de entrada: El sorteo y los seis números
- Implementa un procedimiento GrabaMuchasSencillas que genere n boletos con una apuesta sencilla utilizando el procedimiento GrabaSencilla. Datos de entrada: El sorteo y el valor de n
- Implementa un procedimiento almacenado GrabaMultiple que grabe una apuesta simple. Datos de entrada: El sorteo y entre 5 y 11 números

### Implementar restricciones

Mediante restricciones check y triggers, asegurate de que se cumplen las siguientes reglas
- No se puede insertar un boleto si queda menos de una hora para el sorteo. Tampoco para sorteos que ya hayan tenido lugar
-	Una vez insertado un boleto, no se pueden modificar sus números
-	Todos los números están comprendido entre 1 y 49
-	En las apuestas no se repiten números
-	Las apuestas sencillas tienen seis números
-	Las apuestas múltiples tienen 5, 7, 8, 9, 10 u 11 números

### Pruebas de rendimiento

Realiza inserciones de 10.000, 100.000, 500.000 y 1.000.000 de boletos y mide el tiempo y el tamaño de la base de datos
Anota los resultados en este formulario (uno por grupo)

### Premios

Modifica la base de datos para que, una vez realizado el sorteo, se pueda asignar a cada boleto la cantidad ganada. Para ello, crea un procedimiento AsignarPremios que calcule los premios de cada boleto y lo guarde en la base de datos.
Para saber cómo se asignan los premios, debes seguir las instrucciones de este documento, en especial el Capítulo V del Título I (págs 7, 8, 9 y 10) y la tabla de la instrucción 21.4 (pág 14).
