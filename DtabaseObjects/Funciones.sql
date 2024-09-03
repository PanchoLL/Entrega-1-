-- FUNCIONES

USE Pentrega2

-- FUNCION 1: RESTA Fecha_Pedido MENOS Fecha_Reepcion 

DELIMITER //

CREATE FUNCTION Fn_Fecha_Recepcion (Fecha_Pedido DATE, Fecha_Recepcion DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE Dias_Pedido INT;
    SET Dias_Pedido = DATEDIFF(Fecha_Recepcion, Fecha_Pedido);
    RETURN Dias_Pedido;
END //

DELIMITER ;

SELECT 
    ID_Pedido,
    Fecha_Pedido,
    Fecha_Recepcion,
    Fn_Fecha_Recepcion(Fecha_Pedido, Fecha_Recepcion) AS Dias_Entrega
FROM 
    Pedido;

    
 -- FUNCION 2: Busco Conocer cuanto dinero tengo actualmente en stock de cada repuesto
 
 DELIMITER //
CREATE FUNCTION Valor_Stock (Precio DECIMAL(10, 2), Stock INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC   
BEGIN
RETURN Precio * Stock;
END //

DELIMITER ;

SELECT
Id_Repuesto,
Nombre,
Precio,
stock,
Valor_Stock (Precio , Stock) AS Valor_Stock
FROM Repuesto
ORDER BY Valor_Stock DESC;


-- Funcion 3: Esta funcion entrega la cantidad total de repuestos que han sido usados en todos los mantenimientos que se han registrado en la tabla 

DELIMITER //

CREATE FUNCTION Total_Repuestos() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_repuestos INT;

    SELECT SUM(Cantidad_Usada) INTO total_repuestos
    FROM DetalleMantenimiento;

    RETURN total_repuestos;
END //

DELIMITER ;

SELECT Total_Repuestos() AS Repuestos_Usados_en_Mantenimientos ;
