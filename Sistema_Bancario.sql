CREATE database Sistema_bancario1;

use Sistema_bancario1;


/* TABLAS */
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    telefono VARCHAR(20),
    direccion VARCHAR(200)
);

CREATE TABLE cuentas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    tipo ENUM('ahorro', 'corriente'),
    numero BIGINT,
    saldo DECIMAL(10,2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE transacciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cuenta_id INT,
    fecha DATETIME,
    tipo ENUM('deposito', 'retiro', 'transferencia'),
    cantidad DECIMAL(10,2),
    FOREIGN KEY (cuenta_id) REFERENCES cuentas(id)
);

CREATE TABLE transferencias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cuenta_origen INT,
    cuenta_destino INT,
    fecha DATETIME,
    cantidad DECIMAL(10,2),
    FOREIGN KEY (cuenta_origen) REFERENCES cuentas(id),
    FOREIGN KEY (cuenta_destino) REFERENCES cuentas(id)
);

CREATE TABLE tarjetas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('credito', 'debito'),
    cliente_id INT,
    numero BIGINT,
    limite DECIMAL(10,2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE prestamos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    cantidad DECIMAL(10,2),
    tasa DECIMAL(5,2),
    fecha_termino DATE,
    estado ENUM('activo', 'pagado'),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE inversiones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    tipo ENUM('acciones', 'bonos', 'fondos'),
    cantidad DECIMAL(10,2),
    fecha DATE,
    valor_actual DECIMAL(10,2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

/* PROBLEMAS */

/* 1_Listar todos los clientes con al menos una cuenta  */
SELECT clientes.id, clientes.nombre, clientes.apellido
FROM clientes
INNER JOIN cuentas
ON clientes.id = cuentas.cliente_id;

/*2_Mostrar el saldo total por cliente*/
SELECT clientes.id, clientes.nombre, SUM(cuentas.saldo) AS saldo_total
FROM clientes
INNER JOIN cuentas
ON clientes.id = cuentas.cliente_id
GROUP BY clientes.id, clientes.nombre;

/*3_Obtener todas las transacciones de un cliente específico*/
SELECT transacciones.id, transacciones.cuenta_id, transacciones.cantidad, transacciones.fecha
FROM transacciones
INNER JOIN cuentas
ON transacciones.cuenta_id = cuentas.id
WHERE cuentas.cliente_id = 1;

/*4_Listar cuentas con saldo mayor a 10000*/
SELECT cuentas.id, cuentas.cliente_id, cuentas.saldo
FROM cuentas
WHERE cuentas.saldo > 10000;

/*5_Mostrar los clientes que tienen tarjetas*/
SELECT clientes.id, clientes.nombre
FROM clientes
INNER JOIN tarjetas
ON clientes.id = tarjetas.cliente_id;

/*6_Obtener el número de cuentas por cliente*/
SELECT cuentas.cliente_id, COUNT(cuentas.id) AS numero_de_cuentas
FROM cuentas
GROUP BY cuentas.cliente_id;

/*7_Listar los préstamos activos*/
SELECT prestamos.id, prestamos.cliente_id, prestamos.cantidad, prestamos.estado
FROM prestamos
WHERE prestamos.estado = 'activo';

/*8_Mostrar el monto total transferido desde cada cuenta*/
SELECT transferencias.cuenta_origen, SUM(transferencias.cantidad) AS total_transferido
FROM transferencias
GROUP BY transferencias.cuenta_origen;

/*9_Obtener las transacciones del último mes*/
SELECT transacciones.id, transacciones.cuenta_id, transacciones.cantidad, transacciones.fecha
FROM transacciones
WHERE transacciones.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

/*10_Mostrar clientes con inversiones mayores a 5000*/
SELECT clientes.id, clientes.nombre
FROM clientes
INNER JOIN inversiones
ON clientes.id = inversiones.cliente_id
WHERE inversiones.cantidad > 5000;

/*11_Mostrar nombre del cliente, número de cuenta y saldo*/
SELECT clientes.nombre, cuentas.numero, cuentas.saldo
FROM clientes
INNER JOIN cuentas
ON clientes.id = cuentas.cliente_id;

/*12_Obtener el total de transacciones por cuenta*/
SELECT transacciones.cuenta_id, COUNT(transacciones.id) AS total_transacciones
FROM transacciones
GROUP BY transacciones.cuenta_id;

/*13_Listar clientes sin cuentas*/
SELECT clientes.id, clientes.nombre
FROM clientes
LEFT JOIN cuentas
ON clientes.id = cuentas.cliente_id
WHERE cuentas.id IS NULL;

/*14_Mostrar el cliente con más cuentas*/
SELECT cuentas.cliente_id, COUNT(cuentas.id) AS total_cuentas
FROM cuentas
GROUP BY cuentas.cliente_id
ORDER BY total_cuentas DESC
LIMIT 1;

/*15_Obtener el total de préstamos por cliente*/
SELECT prestamos.cliente_id, SUM(prestamos.cantidad) AS total_prestamos
FROM prestamos
GROUP BY prestamos.cliente_id;

/*16_Mostrar el total invertido por cliente*/
SELECT inversiones.cliente_id, SUM(inversiones.cantidad) AS total_invertido
FROM inversiones
GROUP BY inversiones.cliente_id;

/*17_Listar cuentas que nunca han tenido transacciones*/
SELECT cuentas.id, cuentas.numero, cuentas.saldo
FROM cuentas
LEFT JOIN transacciones
ON cuentas.id = transacciones.cuenta_id
WHERE transacciones.id IS NULL;

/*18_Obtener el promedio de monto por transacción*/
SELECT AVG(transacciones.cantidad) AS promedio_monto
FROM transacciones;

/*19_Mostrar los 5 clientes con mayor saldo total*/
SELECT clientes.id, clientes.nombre, SUM(cuentas.saldo) AS saldo_total
FROM clientes
INNER JOIN cuentas
ON clientes.id = cuentas.cliente_id
GROUP BY clientes.id, clientes.nombre
ORDER BY saldo_total DESC
LIMIT 5;

/*20_Listar clientes que tienen cuentas y préstamos*/
SELECT clientes.id, clientes.nombre
FROM clientes
INNER JOIN cuentas
ON clientes.id = cuentas.cliente_id
INNER JOIN prestamos
ON clientes.id = prestamos.cliente_id;

/*21_Obtener el cliente con mayor actividad (más transacciones)*/
SELECT cuentas.cliente_id, COUNT(transacciones.id) AS total_transacciones
FROM transacciones
INNER JOIN cuentas
ON transacciones.cuenta_id = cuentas.id
GROUP BY cuentas.cliente_id
ORDER BY total_transacciones DESC
LIMIT 1;

/*22_Detectar cuentas con más de 3 transferencias en un día*/
SELECT transferencias.cuenta_origen, transferencias.fecha, COUNT(transferencias.id) AS cantidad
FROM transferencias
GROUP BY transferencias.cuenta_origen, transferencias.fecha
HAVING COUNT(transferencias.id) > 3;

/*23_Clientes cuyo saldo total es menor que sus préstamos*/
SELECT clientes.id, clientes.nombre
FROM clientes
INNER JOIN cuentas
ON clientes.id = cuentas.cliente_id
INNER JOIN prestamos
ON clientes.id = prestamos.cliente_id
GROUP BY clientes.id
HAVING SUM(cuentas.saldo) < SUM(prestamos.cantidad);

/*24_Ranking de clientes por inversiones*/
SELECT inversiones.cliente_id,
SUM(inversiones.cantidad) AS total_inversion,
RANK() OVER (ORDER BY SUM(inversiones.cantidad) DESC) AS ranking
FROM inversiones
GROUP BY inversiones.cliente_id;

/*25_Crecimiento de inversiones*/
SELECT inversiones.cliente_id,
SUM(inversiones.valor_actual - inversiones.cantidad) AS crecimiento
FROM inversiones
GROUP BY inversiones.cliente_id;

/* DATOS */

INSERT INTO clientes (nombre, apellido, telefono, direccion) VALUES
('Flavio', 'Rojas', '924601058', 'Supe'),
('Mañuen', 'Cabrera', '987456123', 'Sayan'),
('Franklin', 'Salvador', '987456789', 'Huaura'),
('Johan', 'Mendoza', '987654123', 'Huacho'),
('Leonel', 'Padilla', '966587441', 'Chasquitambo');

INSERT INTO cuentas (cliente_id, tipo, numero, saldo) VALUES
(1, 'ahorro', 10001, 15000),
(2, 'ahorro', 10002, 5000),
(3, 'corriente', 10003, 20000),
(4, 'corriente', 10004, 3000),
(5, 'ahorro', 10005, 8000);

INSERT INTO tarjetas (tipo, cliente_id, numero, limite) VALUES
('credito', 1, 400001, 10000),
('debito', 2, 400002, 0),
('credito', 3, 400003, 5000);

INSERT INTO transacciones (cuenta_id, fecha, tipo, cantidad) VALUES
(1, NOW(), 'deposito', 2000),
(1, NOW(), 'retiro', 500),
(2, NOW(), 'transferencia', 1000),
(3, NOW(), 'deposito', 3000),
(5, NOW(), 'retiro', 1000),
(5, NOW(), 'retiro', 500),
(3, NOW(), 'retiro', 200),
(4, NOW(), 'deposito', 1500);

INSERT INTO transferencias (cuenta_origen, cuenta_destino, fecha, cantidad) VALUES
(1, 2, NOW(), 500),
(1, 3, NOW(), 700),
(1, 4, NOW(), 800),
(1, 5, NOW(), 900),
(2, 1, NOW(), 300);

INSERT INTO prestamos (cliente_id, cantidad, tasa, fecha_termino, estado) VALUES
(1, 10000, 5.5, '2026-12-31', 'activo'),
(2, 5000, 4.5, '2025-10-10', 'pagado'),
(3, 7000, 6.0, '2026-05-20', 'activo');

INSERT INTO inversiones (cliente_id, tipo, cantidad, fecha, valor_actual) VALUES
(1, 'acciones', 6000, '2025-01-01', 8000),
(2, 'bonos', 3000, '2025-02-01', 3500),
(3, 'fondos', 7000, '2025-03-01', 9000),
(4, 'acciones', 2000, '2025-04-01', 2500);


SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE transacciones;
TRUNCATE TABLE transferencias;
TRUNCATE TABLE tarjetas;
TRUNCATE TABLE prestamos;
TRUNCATE TABLE inversiones;
TRUNCATE TABLE cuentas;
TRUNCATE TABLE clientes;

SET FOREIGN_KEY_CHECKS = 1;
