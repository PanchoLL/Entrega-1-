-- VISTAS --


-- Vista Mantenimientos ultimo mes: Esta vista permite ver un listado de todos los mantenimientos que se han realizado el ultimo mes
CREATE VIEW Mantenientos_ultimo_mes AS
SELECT*FROM Mantenimiento
WHERE Fecha_Mantenimiento BETWEEN "2024-05-01" AND "2024-05-31";

SELECT * FROM Mantenientos_ultimo_mes;

-- Vista Manteniento mas caros: Esta lista muestra los mantenimientos mas caros que se han realizado.
CREATE VIEW mantenimientos_Costosos AS
SELECT 
    Mantenimiento.ID_Mantenimiento,
    Mantenimiento.Fecha_Mantenimiento,
    Maquina.Nombre AS Maquina,
    SUM(DetalleMantenimiento.Cantidad_Usada * Repuesto.Precio) AS Costo_Total
FROM 
    DetalleMantenimiento
JOIN 
    Repuesto ON DetalleMantenimiento.ID_Repuesto = Repuesto.ID_Repuesto
JOIN 
    Mantenimiento ON DetalleMantenimiento.ID_Mantenimiento = Mantenimiento.ID_Mantenimiento
JOIN 
    Maquina ON Mantenimiento.ID_Maquina = Maquina.ID_Maquina
GROUP BY 
    Mantenimiento.ID_Mantenimiento, Mantenimiento.Fecha_Mantenimiento, Maquina.Nombre
ORDER BY 
    Costo_Total DESC;

SELECT * FROM mantenimientos_Costosos;

-- Vista 3: Visualizacion del stock de repuetos disponibles 

CREATE VIEW  Stock_Repuestos AS
SELECT Id_Repuesto, Nombre, Stock 
FROM Repuesto;

SELECT * FROM Stock_Repuestos
ORDER BY stock DESC;

-- Vista 4: Proveedores a los cuales se les ha comnprado la mayor cantidad de repuestos 

CREATE VIEW Proveedores_Mayor_Volumen AS
SELECT 
    Proveedor.ID_Proveedor, 
    Proveedor.Nombre, 
    SUM(DetallePedido.Cantidad) AS Total_Repuestos
FROM DetallePedido
INNER JOIN Pedido ON DetallePedido.ID_Pedido = Pedido.ID_Pedido
INNER JOIN Proveedor ON Pedido.ID_Proveedor = Proveedor.ID_Proveedor
GROUP BY Proveedor.ID_Proveedor, Proveedor.Nombre
ORDER BY Total_Repuestos DESC;

SELECT * FROM Proveedores_Mayor_Volumen;

-- Vista 5:  Permite ver las maquinas en las cuales se ha gastado mas por mantenimiento

CREATE VIEW Costo_de_Mantenimiento_x_Maquina AS
SELECT 
    Maquina.ID_Maquina, 
    Maquina.Nombre, 
    SUM(DetalleMantenimiento.Cantidad_Usada * Repuesto.Precio) AS Costo_Total_Mantenimiento
FROM Mantenimiento
INNER JOIN Maquina ON Mantenimiento.ID_Maquina = Maquina.ID_Maquina
INNER JOIN DetalleMantenimiento ON Mantenimiento.ID_Mantenimiento = DetalleMantenimiento.ID_Mantenimiento
INNER JOIN Repuesto ON DetalleMantenimiento.ID_Repuesto = Repuesto.ID_Repuesto
GROUP BY Maquina.ID_Maquina, Maquina.Nombre
ORDER BY Costo_Total_Mantenimiento DESC;

SELECT * FROM Costo_de_Mantenimiento_x_Maquina;

-- Vista 6:  Permite ver los pedidos que estan pendientes de recepcion

CREATE VIEW Pedidos_Pendientes AS
SELECT 
    Pedido.ID_Pedido, 
    Proveedor.Nombre AS Nombre_Proveedor, 
    Pedido.Fecha_Pedido, 
    DATEDIFF(CURDATE(), Pedido.Fecha_Pedido) AS Dias_Desde_Pedido
FROM Pedido
INNER JOIN Proveedor ON Pedido.ID_Proveedor = Proveedor.ID_Proveedor
WHERE Pedido.Fecha_Recepcion IS NULL
ORDER BY Dias_Desde_Pedido DESC;

SELECT * FROM Pedidos_Pendientes;
