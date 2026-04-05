# Sistema-BANCARIO
# CONSULTA N°1
```
Para iniciar, se crea la base de datos y se selecciona para su uso:
-CREATE DATABASE Sistema_bancario1;
-USE Sistema_bancario1;
Esto permite almacenar todas las tablas dentro de un mismo entorno.
```
# CONSULTA N°2 (Creación de las tablas)

# 1. TABLA CLIENTES:
```
Esta tabla almacena la información principal de los clientes.

id: identificador único (clave primaria)
nombre, apellido: datos personales
telefono, direccion: información de contacto

Es la tabla principal del sistema.
```
# 2. TABLA CUENTAS:
```
Almacena las cuentas bancarias de los clientes.

cliente_id: referencia al cliente
tipo: ahorro o corriente
numero: número de cuenta
saldo: dinero disponible

Se relaciona con la tabla clientes mediante una clave foránea.
```
# 3. TABLA TRANSACCIONES:
```

Registra los movimientos de cada cuenta.

cuenta_id: referencia a la cuenta
fecha: momento de la transacción
tipo: depósito, retiro o transferencia
cantidad: monto

Permite llevar control de todas las operaciones realizadas.
```
# 4. TABLA TRANSFERENCIAS:
```
Almacena transferencias entre cuentas.

cuenta_origen: cuenta que envía dinero
cuenta_destino: cuenta que recibe
fecha: momento de la operación
cantidad: monto transferido

Tiene dos claves foráneas hacia la tabla cuentas.
```
# 5. TABLA TARJETAS:
```
Contiene las tarjetas asociadas a los clientes.

tipo: crédito o débito
cliente_id: relación con cliente
numero: número de tarjeta
limite: límite de crédito
```
# 6. TABLA PRESTAMOS:
```
Registra los préstamos otorgados.

cliente_id: cliente que recibe el préstamo
cantidad: monto prestado
tasa: interés
fecha_termino: fecha de pago
estado: activo o pagado
```
# 7. TABLA INVERSIONES:
```
Almacena las inversiones realizadas por los clientes.

cliente_id: referencia al cliente
tipo: acciones, bonos o fondos
cantidad: dinero invertido
fecha: fecha de inversión
valor_actual: valor actualizado
```
# CONSULTA N°3 RELACIONES ENTRE TABLAS Y IMPORTANCIA DE LAS CLAVES
```
La base de datos está estructurada de la siguiente manera:

Un cliente puede tener múltiples cuentas, tarjetas, préstamos e inversiones.
Una cuenta puede tener múltiples transacciones.
Las transferencias conectan cuentas entre sí.

Estas relaciones se establecen mediante claves foráneas, lo que asegura la integridad de los datos como por ejemplo:
Clave primaria (PRIMARY KEY): identifica de manera única cada registro.
Clave foránea (FOREIGN KEY): conecta tablas y mantiene la relación entre los datos.

Esto evita errores como registros sin relación o datos inconsistentes.
```
# CONSULTA N°4 DATOS INSERTADOS
# 1. TABLA CLIENTES:
```
Se registraron cinco clientes con sus datos personales:

Flavio Rojas (Supe)
Mañuen Cabrera (Sayan)
Franklin Salvador (Huaura)
Johan Mendoza (Huacho)
Leonel Padilla (Chasquitambo)

Estos registros representan a los usuarios del sistema y son la base para relacionar las demás tablas.
```
# 2. TABLA CUENTAS:
```
Cada cliente tiene una cuenta bancaria asociada:

Cliente 1: cuenta de ahorro con saldo 15000
Cliente 2: cuenta de ahorro con saldo 5000
Cliente 3: cuenta corriente con saldo 20000
Cliente 4: cuenta corriente con saldo 3000
Cliente 5: cuenta de ahorro con saldo 8000

Esto permite identificar el dinero disponible de cada cliente en el sistema.
```
# 3. TABLA TARJETAS:
```
Se asignaron tarjetas a algunos clientes:

Cliente 1: tarjeta de crédito con límite 10000
Cliente 2: tarjeta de débito
Cliente 3: tarjeta de crédito con límite 5000

No todos los clientes poseen tarjeta, lo cual permite realizar consultas como “clientes sin tarjetas”.
```
# 4. TABLA TRANSACCIONES:
```
Se registraron diferentes movimientos en las cuentas:

Depósitos (ingreso de dinero)
Retiros (salida de dinero)
Transferencias

Ejemplo:

La cuenta 1 tiene un depósito de 2000 y un retiro de 500
La cuenta 5 tiene dos retiros

Esto permite analizar la actividad de cada cuenta.
```
# 5. TABLA TRANSFERENCIAS:
```
Se registraron transferencias entre cuentas:

La cuenta 1 realiza varias transferencias a otras cuentas
La cuenta 2 también realiza una transferencia

Esto permite identificar el flujo de dinero entre clientes y detectar comportamientos como múltiples transferencias en un mismo día.
```
# 6. TABLA PRESTAMOS:
```
Se asignaron préstamos a tres clientes:

Cliente 1: préstamo activo de 10000
Cliente 2: préstamo pagado de 5000
Cliente 3: préstamo activo de 7000

Esto permite comparar deudas con el saldo disponible.
```
# 7. TABLA INVERSIONES:
```
Se registraron inversiones de cuatro clientes:

Cliente 1: 6000 en acciones (valor actual 8000)
Cliente 2: 3000 en bonos (valor actual 3500)
Cliente 3: 7000 en fondos (valor actual 9000)
Cliente 4: 2000 en acciones (valor actual 2500)

Esto permite calcular ganancias o crecimiento de inversión.
```
# CONSULTA N°5 EXPLICACION DE LAS CONSULTAS
# 1. Clientes con al menos una cuenta
```
Se utiliza INNER JOIN para unir las tablas clientes y cuentas mediante el campo id y cliente_id.
Esto permite mostrar únicamente los clientes que tienen al menos una cuenta registrada.

SELECT clientes.id, clientes.nombre, clientes.apellido
FROM clientes
INNER JOIN cuentas
ON clientes.id = cuentas.cliente_id;
```
# 2. Saldo total por cliente
```
Se combinan las tablas clientes y cuentas, luego se agrupan los datos por cliente (GROUP BY) y se utiliza SUM para calcular el saldo total de todas sus cuentas.

SELECT clientes.id, clientes.nombre, SUM(cuentas.saldo) AS saldo_total
FROM clientes
INNER JOIN cuentas
ON clientes.id = cuentas.cliente_id
GROUP BY clientes.id, clientes.nombre;
```
# 3. Transacciones de un cliente específico
```
Se unen las tablas transacciones y cuentas para obtener las transacciones.
Luego se filtra por cliente_id = 1 para mostrar solo las transacciones de ese cliente.

SELECT transacciones.id, transacciones.cuenta_id, transacciones.cantidad, transacciones.fecha
FROM transacciones
INNER JOIN cuentas
ON transacciones.cuenta_id = cuentas.id
WHERE cuentas.cliente_id = 1;
```
# 4. Cuentas con saldo mayor a 10000
```
Se utiliza WHERE para filtrar las cuentas cuyo saldo sea mayor a 10000.

SELECT cuentas.id, cuentas.cliente_id, cuentas.saldo
FROM cuentas
WHERE cuentas.saldo > 10000;
```
# 5. Clientes con tarjetas
```
Se usa INNER JOIN entre clientes y tarjetas para mostrar únicamente los clientes que poseen al menos una tarjeta.

SELECT clientes.id, clientes.nombre
FROM clientes
INNER JOIN tarjetas
ON clientes.id = tarjetas.cliente_id;
```
# 6. Número de cuentas por cliente
```
Se agrupan las cuentas por cliente y se utiliza COUNT para contar cuántas cuentas tiene cada uno.

SELECT cuentas.cliente_id, COUNT(cuentas.id) AS numero_de_cuentas
FROM cuentas
GROUP BY cuentas.cliente_id;
```
# 7. Préstamos activos
```
Se filtran los registros de la tabla prestamos donde el estado es 'activo'.

SELECT prestamos.id, prestamos.cliente_id, prestamos.cantidad, prestamos.estado
FROM prestamos
WHERE prestamos.estado = 'activo';
```
# 8. Total transferido por cuenta
```
Se agrupan las transferencias por cuenta de origen y se utiliza SUM para calcular el total enviado.

SELECT transferencias.cuenta_origen, SUM(transferencias.cantidad) AS total_transferido
FROM transferencias
GROUP BY transferencias.cuenta_origen;
```
# 9. Transacciones del último mes
```
Se utiliza DATE_SUB junto con CURDATE() para obtener las transacciones realizadas en el último mes.

SELECT transacciones.id, transacciones.cuenta_id, transacciones.cantidad, transacciones.fecha
FROM transacciones
WHERE transacciones.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
```
# 10. Clientes con inversiones mayores a 5000
```
Se unen clientes e inversiones y se filtran aquellos donde la cantidad invertida es mayor a 5000.

SELECT clientes.id, clientes.nombre
FROM clientes
INNER JOIN inversiones
ON clientes.id = inversiones.cliente_id
WHERE inversiones.cantidad > 5000;
```
# 11. Nombre, cuenta y saldo
```
Se realiza un INNER JOIN entre clientes y cuentas para mostrar datos combinados de ambas tablas.

SELECT clientes.nombre, cuentas.numero, cuentas.saldo
FROM clientes
INNER JOIN cuentas
ON clientes.id = cuentas.cliente_id;
```
# 12. Total de transacciones por cuenta
```
Se agrupan las transacciones por cuenta y se utiliza COUNT para saber cuántas tiene cada una.

SELECT transacciones.cuenta_id, COUNT(transacciones.id) AS total_transacciones
FROM transacciones
GROUP BY transacciones.cuenta_id;
```
# 13. Clientes sin cuentas
```
Se usa LEFT JOIN para incluir todos los clientes y luego se filtran aquellos que no tienen cuentas (IS NULL).

SELECT clientes.id, clientes.nombre
FROM clientes
LEFT JOIN cuentas
ON clientes.id = cuentas.cliente_id
WHERE cuentas.id IS NULL;
```
# 14. Cliente con más cuentas
```
Se cuentan las cuentas por cliente, se ordena de mayor a menor (ORDER BY DESC) y se limita a uno (LIMIT 1).

SELECT cuentas.cliente_id, COUNT(cuentas.id) AS total_cuentas
FROM cuentas
GROUP BY cuentas.cliente_id
ORDER BY total_cuentas DESC
LIMIT 1;
```
# 15. Total de préstamos por cliente
```
Se agrupan los préstamos por cliente y se suman los montos usando SUM.

SELECT prestamos.cliente_id, SUM(prestamos.cantidad) AS total_prestamos
FROM prestamos
GROUP BY prestamos.cliente_id;
```
# 16. Total invertido por cliente
```
Se agrupan las inversiones por cliente y se calcula el total invertido con SUM.

SELECT inversiones.cliente_id, SUM(inversiones.cantidad) AS total_invertido
FROM inversiones
GROUP BY inversiones.cliente_id;
```
# 17. Cuentas sin transacciones
```
Se usa LEFT JOIN entre cuentas y transacciones, filtrando aquellas cuentas que no tienen registros asociados.

SELECT cuentas.id, cuentas.numero, cuentas.saldo
FROM cuentas
LEFT JOIN transacciones
ON cuentas.id = transacciones.cuenta_id
WHERE transacciones.id IS NULL;

```
# 18. Promedio por transacción
```
Se utiliza la función AVG para calcular el promedio del monto de todas las transacciones.

SELECT AVG(transacciones.cantidad) AS promedio_monto
FROM transacciones;
```
# 19. Top 5 clientes con mayor saldo
```
Se suman los saldos por cliente, se ordenan de mayor a menor y se limita a los 5 primeros resultados.

SELECT clientes.id, clientes.nombre, SUM(cuentas.saldo) AS saldo_total
FROM clientes
INNER JOIN cuentas
ON clientes.id = cuentas.cliente_id
GROUP BY clientes.id, clientes.nombre
ORDER BY saldo_total DESC
LIMIT 5;
```
# 20. Clientes con cuentas y préstamos
```
Se unen las tablas clientes, cuentas y préstamos para mostrar clientes que tienen ambas cosas.

SELECT clientes.id, clientes.nombre
FROM clientes
INNER JOIN cuentas
ON clientes.id = cuentas.cliente_id
INNER JOIN prestamos
ON clientes.id = prestamos.cliente_id;
```
# 21. Cliente con más transacciones
```
Se cuentan las transacciones por cliente, se ordenan de mayor a menor y se muestra el primero.

SELECT cuentas.cliente_id, COUNT(transacciones.id) AS total_transacciones
FROM transacciones
INNER JOIN cuentas
ON transacciones.cuenta_id = cuentas.id
GROUP BY cuentas.cliente_id
ORDER BY total_transacciones DESC
LIMIT 1;

```
# 22. Transferencias sospechosas
``` 
Se agrupan las transferencias por cuenta y fecha, y se usa HAVING para filtrar aquellas con más de 3 transferencias en un día.

SELECT transferencias.cuenta_origen, transferencias.fecha, COUNT(transferencias.id) AS cantidad
FROM transferencias
GROUP BY transferencias.cuenta_origen, transferencias.fecha
HAVING COUNT(transferencias.id) > 3;
```
# 23. Clientes con más deuda que saldo
```
Se suman los saldos y los préstamos por cliente y se comparan usando HAVING.

SELECT clientes.id, clientes.nombre
FROM clientes
INNER JOIN cuentas
ON clientes.id = cuentas.cliente_id
INNER JOIN prestamos
ON clientes.id = prestamos.cliente_id
GROUP BY clientes.id
HAVING SUM(cuentas.saldo) < SUM(prestamos.cantidad);
```
# 24. Ranking de clientes por inversiones 
```
Se agrupan las inversiones por cliente, se suman y se usa RANK() para asignar una posición según el monto invertido.

SELECT inversiones.cliente_id,
SUM(inversiones.cantidad) AS total_inversion,
RANK() OVER (ORDER BY SUM(inversiones.cantidad) DESC) AS ranking
FROM inversiones
GROUP BY inversiones.cliente_id;
```
# 25. Crecimiento de inversiones
```
Se calcula la ganancia restando cantidad a valor_actual y se suma por cliente.

SELECT inversiones.cliente_id,
SUM(inversiones.valor_actual - inversiones.cantidad) AS crecimiento
FROM inversiones
GROUP BY inversiones.cliente_id;
```

SELECT inversiones.cliente_id,
SUM(inversiones.valor_actual - inversiones.cantidad) AS crecimiento
FROM inversiones
GROUP BY inversiones.cliente_id;
