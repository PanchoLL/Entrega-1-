-- PROCEDIMIENTOS ALMACENADOS

-- Procedimiento 1: Buscamos el valor total que tenemos en repuestos

DELIMITER //
CREATE PROCEDURE SP_Valor_Total_Stock()
BEGIN
    SELECT SUM(Precio * Stock) AS Valor_Stock_Total
    FROM Repuesto;
END //
DELIMITER ;

CALL SP_Valor_Total_Stock()


-- Procedimiento2: Mantenimientos por Maquina 

DELIMITER //
CREATE PROCEDURE Mantenimientos_Por_Maquina(IN maquinaID INT)
BEGIN
    SELECT 
        Mantenimiento.ID_Mantenimiento,
        Mantenimiento.Fecha_Mantenimiento,
        Maquina.Nombre,
        Maquina.Modelo,
        DetalleMantenimiento.ID_Detalle,
        DetalleMantenimiento.ID_Repuesto,
        Repuesto.Nombre,
        DetalleMantenimiento.Cantidad_Usada
    FROM 
        Mantenimiento
    JOIN 
        Maquina ON Mantenimiento.ID_Maquina = Maquina.ID_Maquina
    JOIN 
        DetalleMantenimiento ON Mantenimiento.ID_Mantenimiento = DetalleMantenimiento.ID_Mantenimiento
    JOIN 
        Repuesto ON DetalleMantenimiento.ID_Repuesto = Repuesto.ID_Repuesto
    WHERE 
        Maquina.ID_Maquina = maquinaID
    ORDER BY 
        Mantenimiento.Fecha_Mantenimiento DESC;
END //
DELIMITER ;

CALL Mantenimientos_Por_Maquina(4);

-- Procedimiento3: Este procedimiento permite revisar rapidamente que repuestos tienen stock bajo un numero determinado

DELIMITER //

CREATE PROCEDURE Repuestos_Poco_Stock(IN stock_minimo INT)
BEGIN
    SELECT *
    FROM Repuesto
    WHERE Stock < stock_minimo;
END //

DELIMITER ;

CALL Repuestos_Poco_Stock(30);
