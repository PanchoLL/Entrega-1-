-- Codigo Estructura entrega final:

-- Crear y usar base de datos 

CREATE DATABASE IF NOT EXISTS RepuestosMaquinaria;
USE RepuestosMaquinaria;

-- Tabla Proveedor
CREATE TABLE Proveedor (
    ID_Proveedor INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Direccion VARCHAR(100),
    Telefono VARCHAR(20),
    Email VARCHAR(100)
);

-- Tabla Repuesto
CREATE TABLE Repuesto (
    ID_Repuesto INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Descripcion TEXT,
    Precio DECIMAL(10, 2),
    Stock INT
    );
    
-- Tabla Maquina
CREATE TABLE Maquina (
    ID_Maquina INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Modelo VARCHAR(100),
    Fabricante VARCHAR(100)
    );

-- Tabla Pedido
CREATE TABLE Pedido (
    ID_Pedido INT PRIMARY KEY AUTO_INCREMENT,
    Fecha_Pedido DATE,
    Fecha_Recepcion DATE,
    ID_Proveedor INT
    );

-- Tabla DetallePedido
CREATE TABLE DetallePedido (
    ID_Detalle INT PRIMARY KEY AUTO_INCREMENT,
    ID_Pedido INT,
    ID_Repuesto INT,
    Cantidad INT,
    Precio_Unitario DECIMAL(10, 2)
);

-- Repuesto Maquinaria (revisar pk)
CREATE TABLE RepuestoMaquina (
    ID_Repuesto INT,
    ID_Maquina INT,
    Cantidad_Necesaria INT,
    PRIMARY KEY (ID_Repuesto, ID_Maquina)
);

--  Tabla Mantenimiento 
CREATE TABLE Mantenimiento (
    ID_Mantenimiento INT PRIMARY KEY  AUTO_INCREMENT,
    Fecha_Mantenimiento DATE,
    Descripcion TEXT,
    ID_Maquina INT
);

-- Detalle Mantenimiento
CREATE TABLE DetalleMantenimiento (
    ID_Detalle INT PRIMARY KEY AUTO_INCREMENT,
    ID_Mantenimiento INT,
    ID_Repuesto INT,
    Cantidad_Usada INT
);

-- Definicion clave forranea:

-- Pedido / Proveedor
ALTER TABLE Pedido
   ADD CONSTRAINT fk_Pedido_Proveedor
   FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor (ID_Proveedor);
  
  -- Detallepedido / Pedido
ALTER TABLE DetallePedido
    ADD CONSTRAINT fk_Detallepedido_Pedido
	FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido);
  
    -- Detallepedido / Repuesto
ALTER TABLE DetallePedido
     ADD CONSTRAINT fk_Detallepedido_Repuesto
     FOREIGN KEY (ID_Repuesto) REFERENCES Repuesto(ID_Repuesto);
     
     -- RepuestoMaquina / Repuesto
ALTER TABLE RepuestoMaquina
     ADD CONSTRAINT fk_RepuestoMaquina_Repuesto
	 FOREIGN KEY (ID_Repuesto) REFERENCES Repuesto(ID_Repuesto);
     
	-- RepuestoMaquina / Maquina
ALTER TABLE RepuestoMaquina
     ADD CONSTRAINT fk_RepuestoMaquina_Maquina
     FOREIGN KEY (ID_Maquina) REFERENCES Maquina(ID_Maquina);
     
    -- Mantenimiento / Maquina 
 ALTER TABLE Mantenimiento
     ADD CONSTRAINT fk_Mantenimiento_Maquina    
	 FOREIGN KEY (ID_Maquina) REFERENCES Maquina(ID_Maquina);
     
    -- DetalleMantenimiento / Mantenimiento
 ALTER TABLE DetalleMantenimiento
     ADD CONSTRAINT fk_DetalleMantenimiento_Mantenimiento     
	 FOREIGN KEY (ID_Mantenimiento) REFERENCES Mantenimiento(ID_Mantenimiento);
         
   -- DetalleMantenimiento / Repuesto
ALTER TABLE DetalleMantenimiento
      ADD CONSTRAINT fk_DetalleMantenimiento_Repuesto 
      FOREIGN KEY (ID_Repuesto) REFERENCES Repuesto(ID_Repuesto);
