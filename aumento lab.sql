create database InventarioRepuestosVOLVO;
go
use InventarioRepuestosVOLVO;
go

-- Proveedores
CREATE TABLE Proveedores (
    IdProveedor INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(20),
    Direccion NVARCHAR(150),
    Email NVARCHAR(100)
);

-- Productos (solo repuestos Volvo)
CREATE TABLE Productos (
    IdProducto INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,   
    Modelo NVARCHAR(50),             
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL DEFAULT 0,
    IdProveedor INT,
    FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor)
);

-- Clientes
CREATE TABLE Clientes (
    IdCliente INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(20),
    Direccion NVARCHAR(150)
);

-- Ventas
CREATE TABLE Ventas (
    IdVenta INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATETIME DEFAULT GETDATE(),
    IdCliente INT,
    FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
);

-- Detalle de Ventas
CREATE TABLE DetalleVenta (
    IdDetalle INT IDENTITY(1,1) PRIMARY KEY,
    IdVenta INT,
    IdProducto INT,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (IdVenta) REFERENCES Ventas(IdVenta),
    FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);

-- Compras (entradas de inventario)
CREATE TABLE Compras (
    IdCompra INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATETIME DEFAULT GETDATE(),
    IdProveedor INT,
    FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor)
);

-- Detalle de Compras
CREATE TABLE DetalleCompra (
    IdDetalle INT IDENTITY(1,1) PRIMARY KEY,
    IdCompra INT,
    IdProducto INT,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (IdCompra) REFERENCES Compras(IdCompra),
    FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);

-- Proveedores
INSERT INTO Proveedores (Nombre, Telefono, Direccion, Email)
VALUES ('MyMREPUESTOSYSERVICIOS', '999888777', 'Av. Industrial 123 - Lima', 'MyMREPUESTOSYSERVICIOS@GMAIL.COM'),
       ('DITERSA', '988776655', 'Calle Comercio 456 - Trujillo', 'DITERSA@GMAIL.COM'),
	   ('Volvo Parts Lima', '999888111', 'Av. Industrial 101 - Lima', 'ventas@volvolima.pe'),
		('Repuestos Volvo Norte', '999888112', 'Av. Mansiche 202 - Trujillo', 'contacto@volvonorte.pe'),
		('Volvo Sur Arequipa', '999888113', 'Av. Ejército 303 - Arequipa', 'info@volvosur.pe'),
		('Distribuidora Camiones Volvo', '999888114', 'Av. Panamericana 404 - Chiclayo', 'ventas@districamvolvo.pe'),
		('Volvo Cusco Repuestos', '999888115', 'Av. Cultura 505 - Cusco', 'contacto@volvocusco.pe'),
		('Autopartes Volvo Callao', '999888116', 'Av. Argentina 1200 - Callao', 'ventas@volvocallao.pe'),
		('Repuestos Volvo Piura', '999888117', 'Av. Grau 302 - Piura', 'info@volvopiura.pe'),
		('Volvo Junín', '999888118', 'Jr. Huancayo 203 - Huancayo', 'contacto@volvojunin.pe'),
		('Volvo Parts Tacna', '999888119', 'Av. Bolognesi 450 - Tacna', 'ventas@volvotacna.pe'),
		('Mega Repuestos Volvo', '999888120', 'Av. Principal 600 - Iquitos', 'info@megavolvo.pe'),
		('Volvo Puno Repuestos', '999888121', 'Av. Costanera 700 - Puno', 'contacto@volvopuno.pe'),
		('Repuestos Volvo Amazonas', '999888122', 'Av. Amazonas 300 - Chachapoyas', 'ventas@volvoamazonas.pe'),
		('Volvo Ayacucho', '999888123', 'Av. Libertadores 150 - Ayacucho', 'info@volvoayacucho.pe'),
		('Distribuidora Oficial Volvo', '999888124', 'Av. Central 400 - Lima', 'ventas@distrioficialvolvo.pe'),
		('Volvo Ancash', '999888125', 'Av. Huaraz 800 - Huaraz', 'contacto@volvoancash.pe');

-- Productos 
INSERT INTO Productos (Nombre, Modelo, Precio, Stock, IdProveedor)
VALUES ('Filtro de aceite', 'FH', 50.00, 20, 1),
       ('Batería 200Ah', 'FMX', 1200.00, 10, 2),
       ('Pastillas de freno', 'FM', 450.00, 15, 1),
       ('Filtro de aire', 'FH', 300.00, 12, 1),
       ('Amortiguador delantero', 'FMX', 800.00, 8, 2),
	   ('Filtro de aceite Volvo', 'FH', 180.00, 50, 1),
		('Filtro de aire Volvo', 'FH', 400.00, 35, 2),
		('Filtro de combustible Volvo', 'FMX', 250.00, 40, 3),
		('Batería 200Ah Volvo', 'FM', 1200.00, 20, 4),
		('Amortiguador delantero Volvo', 'FH', 800.00, 15, 5),
		('Amortiguador trasero Volvo', 'FMX', 850.00, 15, 6),
		('Pastillas de freno delanteras Volvo', 'FM', 650.00, 30, 7),
		('Pastillas de freno traseras Volvo', 'FH', 600.00, 25, 8),
		('Disco de freno Volvo', 'FM', 950.00, 18, 9),
		('Tambor de freno Volvo', 'FH', 1800.00, 12, 10),
		('Radiador Volvo', 'FMX', 2500.00, 10, 11),
		('Compresor de aire Volvo', 'FM', 3100.00, 8, 12),
		('Bomba de combustible Volvo', 'FH', 2200.00, 5, 13),
		('Bomba de agua Volvo', 'FMX', 1500.00, 6, 14),
		('Turbo Volvo', 'FH', 3800.00, 7, 15),
		('Caja de cambios Volvo', 'FM', 12000.00, 3, 1),
		('Embrague Volvo', 'FH', 1450.00, 12, 2),
		('Eje delantero Volvo', 'FMX', 7500.00, 4, 3),
		('Eje trasero Volvo', 'FH', 8900.00, 2, 4),
		('Correa de distribución Volvo', 'FM', 500.00, 20, 5),
		('Bujía de encendido Volvo', 'FMX', 120.00, 60, 6),
		('Inyector Volvo', 'FH', 2200.00, 7, 7),
		('Sensor ABS Volvo', 'FM', 750.00, 15, 8),
		('Alternador Volvo', 'FMX', 1800.00, 9, 9),
		('Motor de arranque Volvo', 'FH', 2300.00, 5, 10),
		('Parachoques delantero Volvo', 'FM', 3500.00, 2, 11),
		('Parachoques trasero Volvo', 'FMX', 3300.00, 3, 12),
		('Espejo retrovisor Volvo', 'FH', 450.00, 20, 13),
		('Faros delanteros Volvo', 'FMX', 950.00, 12, 14),
		('Faros traseros Volvo', 'FH', 800.00, 15, 15),
		('Kit de embrague Volvo', 'FM', 1650.00, 8, 5),
		('Filtro hidráulico Volvo', 'FMX', 350.00, 18, 6),
		('Radiador aceite Volvo', 'FH', 2750.00, 5, 7),
		('Palanca de cambios Volvo', 'FM', 420.00, 10, 8),
		('Cilindro maestro de frenos Volvo', 'FMX', 1300.00, 6, 9),
		('Cilindro esclavo de embrague Volvo', 'FH', 1150.00, 7, 10),
		('Manguera de radiador Volvo', 'FMX', 180.00, 25, 11),
		('Termostato Volvo', 'FH', 220.00, 30, 12),
		('Filtro de cabina Volvo', 'FM', 150.00, 50, 13),
		('Sensor de oxígeno Volvo', 'FMX', 800.00, 12, 14),
		('ECU Volvo', 'FH', 12500.00, 2, 15),
		('Sensor de presión de aceite Volvo', 'FMX', 600.00, 15, 1),
		('Volante Volvo', 'FH', 1500.00, 5, 2),
		('Tapacubos Volvo', 'FM', 250.00, 20, 3),
		('Vidrio parabrisas Volvo', 'FMX', 3200.00, 3, 4),
		('Puerta delantera Volvo', 'FH', 5000.00, 2, 5),
		('Puerta trasera Volvo', 'FM', 4800.00, 2, 6),
		('Capó Volvo', 'FMX', 6500.00, 1, 7),
		('Guardafango Volvo', 'FH', 1200.00, 4, 8),
		('Filtro separador de agua Volvo', 'FM', 300.00, 25, 9),
		('Resorte de suspensión Volvo', 'FMX', 1100.00, 6, 10),
		('Bomba hidráulica Volvo', 'FH', 4200.00, 2, 11),
		('Módulo ABS Volvo', 'FM', 3500.00, 3, 12),
		('Radiador de calefacción Volvo', 'FMX', 1800.00, 4, 13),
		('Tanque de combustible Volvo', 'FH', 5400.00, 2, 14),
		('Silenciador Volvo', 'FM', 2300.00, 5, 15),
		('Tubería de escape Volvo', 'FMX', 1500.00, 7, 1),
		('Claxon Volvo', 'FH', 250.00, 30, 2),
		('Cojinete de rueda Volvo', 'FM', 850.00, 12, 3),
		('Bomba de dirección Volvo', 'FMX', 3700.00, 2, 4),
		('Cremallera de dirección Volvo', 'FH', 4200.00, 1, 5),
		('Sensor de temperatura Volvo', 'FM', 450.00, 10, 6),
		('Sensor de velocidad Volvo', 'FMX', 600.00, 8, 7),
		('Switch de encendido Volvo', 'FH', 700.00, 5, 8),
		('Interruptor de luces Volvo', 'FM', 400.00, 9, 9),
		('Unidad de control de luces Volvo', 'FMX', 1500.00, 3, 10),
		('Kit de frenos Volvo', 'FH', 2500.00, 4, 11),
		('Juego de válvulas Volvo', 'FM', 1200.00, 6, 12),
		('Cilindro de freno Volvo', 'FMX', 800.00, 10, 13),
		('Kit de reparación de embrague Volvo', 'FH', 950.00, 8, 14),
		('Panel de instrumentos Volvo', 'FM', 6000.00, 2, 15),
		('Asiento del conductor Volvo', 'FMX', 7500.00, 1, 1),
		('Asiento del copiloto Volvo', 'FH', 7200.00, 1, 2),
		('Caja de fusibles Volvo', 'FM', 1800.00, 4, 3),
		('Cámara de retroceso Volvo', 'FMX', 2500.00, 2, 4),
		('Sensor de proximidad Volvo', 'FH', 1400.00, 5, 5),
		('Limpiaparabrisas Volvo', 'FM', 300.00, 20, 6),
		('Motor limpiaparabrisas Volvo', 'FMX', 1500.00, 3, 7),
		('Depósito de refrigerante Volvo', 'FH', 900.00, 6, 8),
		('Ventilador de motor Volvo', 'FM', 1700.00, 3, 9),
		('Cinturón de seguridad Volvo', 'FMX', 450.00, 15, 10),
		('Caja de dirección Volvo', 'FH', 9200.00, 1, 11),
		('Palanca de freno Volvo', 'FM', 1300.00, 4, 12),
		('Módulo de control de motor Volvo', 'FMX', 13500.00, 1, 13),
		('Kit de rodamientos Volvo', 'FH', 2400.00, 5, 14),
		('Bomba de vacío Volvo', 'FM', 2800.00, 2, 15),
		('Tensor de correa Volvo', 'FMX', 950.00, 7, 1),
		('Soporte de motor Volvo', 'FH', 2200.00, 3, 2),
		('Carcasa de termostato Volvo', 'FM', 1100.00, 4, 3),
		('Filtro separador Volvo', 'FMX', 350.00, 8, 4),
		('Interruptor de freno Volvo', 'FH', 400.00, 10, 5),
		('Sensor de combustible Volvo', 'FM', 1250.00, 3, 6),
		('Unidad de control ABS Volvo', 'FMX', 3600.00, 2, 7),
		('Kit de suspensión Volvo', 'FH', 4800.00, 2, 8),
		('Soporte de caja Volvo', 'FM', 2100.00, 3, 9),
		('Pistón Volvo', 'FMX', 1800.00, 6, 10),
		('Anillo de pistón Volvo', 'FH', 700.00, 12, 11),
		('Culata Volvo', 'FM', 9500.00, 1, 12),
		('Bloque motor Volvo', 'FMX', 18000.00, 1, 13),
		('Kit de juntas Volvo', 'FH', 1500.00, 7, 14),
		('Cárter de aceite Volvo', 'FM', 3500.00, 3, 15);
INSERT INTO Clientes (Nombre, Telefono, Direccion) VALUES
		('Transportes Rápidos del Norte', '988111222', 'Av. Panamericana Norte 1200 - Trujillo'),
		('Logística Andina SAC', '988111223', 'Av. Independencia 450 - Arequipa'),
		('Transporte Pesado del Sur', '988111224', 'Av. Circunvalación 780 - Cusco'),
		('Camiones y Carga EIRL', '988111225', 'Av. Metropolitana 560 - Lima'),
		('Transportes Santa Rosa', '988111226', 'Av. Los Próceres 300 - Chiclayo'),
		('Transportes El Chasqui', '988111227', 'Av. Colonial 1220 - Callao'),
		('Carga Pesada del Norte', '988111228', 'Av. América 340 - Trujillo'),
		('Transporte Andino', '988111229', 'Av. Ejército 455 - Arequipa'),
		('Logística Integral Cusco', '988111230', 'Av. La Cultura 890 - Cusco'),
		('Transporte Los Andes', '988111231', 'Av. Panamericana Sur 600 - Lima'),
		('Carga Express', '988111232', 'Av. Grau 720 - Piura'),
		('Transporte del Valle', '988111233', 'Av. Los Incas 560 - Ayacucho'),
		('Transporte Sol del Norte', '988111234', 'Av. Primavera 210 - Trujillo'),
		('Transportes Santa Cruz', '988111235', 'Av. Angamos 310 - Lima'),
		('Transporte Perú Cargo', '988111236', 'Av. Central 800 - Callao'),
		('Logística Global SAC', '988111237', 'Av. Universitaria 400 - Huancayo'),
		('Carga Segura SAC', '988111238', 'Av. Principal 950 - Puno'),
		('Transportes Surandino', '988111239', 'Av. Bolognesi 345 - Tacna'),
		('Transporte Express Carhuaz', '988111240', 'Av. Huaraz 100 - Ancash'),
		('Transporte del Oriente', '988111241', 'Av. San Juan 480 - Iquitos'),
		('Transporte Lurín Cargo', '988111242', 'Av. Industrial 220 - Lima'),
		('Logística Nacional SAC', '988111243', 'Av. República 670 - Arequipa'),
		('Transporte Panamericana', '988111244', 'Av. Panamericana 330 - Chiclayo'),
		('Camiones del Pacífico', '988111245', 'Av. Costanera 440 - Piura'),
		('Transportes Altiplano', '988111246', 'Av. Titicaca 120 - Puno'),
		('Carga Andina SAC', '988111247', 'Av. Inca Garcilaso 560 - Cusco'),
		('Transportes Global Express', '988111248', 'Av. Javier Prado 2000 - Lima'),
		('Transporte Sumaq Cargo', '988111249', 'Av. Central 123 - Arequipa'),
		('Transportes Torres SAC', '988111250', 'Av. Grau 400 - Trujillo'),
		('Transporte Perú Cargo Express', '988111251', 'Av. Metropolitana 900 - Lima');

SELect* from Productos
select * from Proveedores
select * from Clientes