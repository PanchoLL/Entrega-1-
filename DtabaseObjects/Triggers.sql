-- TRIGGERS


-- Trigger 1: Actualiza el stock de un repuesto cuando se inserta un nuevo detalle de mantenimiento 

DELIMITER //

CREATE TRIGGER Actualizar_Stock_X_DetalleMantenimiento
AFTER INSERT ON DetalleMantenimiento
FOR EACH ROW
BEGIN
    UPDATE Repuesto
    SET Stock = Stock - NEW.Cantidad_Usada
    WHERE ID_Repuesto = NEW.ID_Repuesto;
END //

DELIMITER ;


-- Trigger 2: Este Trigger permite dar un aviso si no hay repuestos para hacer un mantenimiento.

DELIMITER //

CREATE TRIGGER Validar_Stock_Mantenimiento
BEFORE INSERT ON DetalleMantenimiento
FOR EACH ROW
BEGIN
    DECLARE StockActual INT;
    SELECT Stock INTO StockActual
    FROM Repuesto
    WHERE ID_Repuesto = NEW.ID_Repuesto;
    
    IF StockActual < NEW.Cantidad_Usada THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay repuesto para realizar este mantenimiento. Favor geenerar orden de compra';
    END IF;
END //

DELIMITER ;

-- Trigger 3: Verificador de fechas de pedido

DELIMITER //

CREATE TRIGGER Verificadr_Fechas
BEFORE INSERT ON Pedido
FOR EACH ROW
BEGIN
    IF NEW.Fecha_Recepcion < NEW.Fecha_Pedido THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La fecha de reposición no puede ser anterior a la fecha de pedido';
    END IF;
END //

DELIMITER ;
