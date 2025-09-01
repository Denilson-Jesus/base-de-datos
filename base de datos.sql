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
       ('DITERSA', '988776655', 'Calle Comercio 456 - Trujillo', 'DITERSA@GMAIL.COM');

-- Productos 
INSERT INTO Productos (Nombre, Modelo, Precio, Stock, IdProveedor)
VALUES ('Filtro de aceite', 'FH', 50.00, 20, 1),
       ('Batería 200Ah', 'FMX', 1200.00, 10, 2),
       ('Pastillas de freno', 'FM', 450.00, 15, 1),
       ('Filtro de aire', 'FH', 300.00, 12, 1),
       ('Amortiguador delantero', 'FMX', 800.00, 8, 2);

SELect* from Productos
select * from Proveedores