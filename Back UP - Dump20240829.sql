CREATE DATABASE  IF NOT EXISTS `pentrega2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pentrega2`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: pentrega2
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `costo_de_mantenimiento_x_maquina`
--

DROP TABLE IF EXISTS `costo_de_mantenimiento_x_maquina`;
/*!50001 DROP VIEW IF EXISTS `costo_de_mantenimiento_x_maquina`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `costo_de_mantenimiento_x_maquina` AS SELECT 
 1 AS `ID_Maquina`,
 1 AS `Nombre`,
 1 AS `Costo_Total_Mantenimiento`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `detallemantenimiento`
--

DROP TABLE IF EXISTS `detallemantenimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detallemantenimiento` (
  `ID_Detalle` int NOT NULL AUTO_INCREMENT,
  `ID_Mantenimiento` int DEFAULT NULL,
  `ID_Repuesto` int DEFAULT NULL,
  `Cantidad_Usada` int DEFAULT NULL,
  PRIMARY KEY (`ID_Detalle`),
  KEY `fk_DetalleMantenimiento_Mantenimiento` (`ID_Mantenimiento`),
  KEY `fk_DetalleMantenimiento_Repuesto` (`ID_Repuesto`),
  CONSTRAINT `fk_DetalleMantenimiento_Mantenimiento` FOREIGN KEY (`ID_Mantenimiento`) REFERENCES `mantenimiento` (`ID_Mantenimiento`),
  CONSTRAINT `fk_DetalleMantenimiento_Repuesto` FOREIGN KEY (`ID_Repuesto`) REFERENCES `repuesto` (`ID_Repuesto`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detallemantenimiento`
--

LOCK TABLES `detallemantenimiento` WRITE;
/*!40000 ALTER TABLE `detallemantenimiento` DISABLE KEYS */;
INSERT INTO `detallemantenimiento` VALUES (1,1,1,2),(2,1,3,4),(3,2,2,1),(4,2,5,3),(5,3,4,2),(6,3,6,2),(7,4,7,1),(8,4,9,3),(9,5,8,2),(10,5,10,2),(11,6,11,1),(12,6,13,3),(13,7,12,2),(14,7,14,2),(15,8,15,1),(16,8,17,3),(17,9,16,2),(18,9,18,2),(19,10,19,1),(20,10,21,3),(21,11,20,2),(22,11,22,2),(23,12,23,1),(24,12,25,3),(25,13,24,2),(26,13,26,2),(27,14,27,1),(28,14,29,3),(29,15,28,2),(30,15,30,2);
/*!40000 ALTER TABLE `detallemantenimiento` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Validar_Stock_Mantenimiento` BEFORE INSERT ON `detallemantenimiento` FOR EACH ROW BEGIN
    DECLARE StockActual INT;
    SELECT Stock INTO StockActual
    FROM Repuesto
    WHERE ID_Repuesto = NEW.ID_Repuesto;
    
    IF StockActual < NEW.Cantidad_Usada THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay repuesto para realizar este mantenimiento. Favor geenerar orden de compra';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Actualizar_Stock_X_DetalleMantenimiento` AFTER INSERT ON `detallemantenimiento` FOR EACH ROW BEGIN
    UPDATE Repuesto
    SET Stock = Stock - NEW.Cantidad_Usada
    WHERE ID_Repuesto = NEW.ID_Repuesto;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `detallepedido`
--

DROP TABLE IF EXISTS `detallepedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detallepedido` (
  `ID_Detalle` int NOT NULL AUTO_INCREMENT,
  `ID_Pedido` int DEFAULT NULL,
  `ID_Repuesto` int DEFAULT NULL,
  `Cantidad` int DEFAULT NULL,
  `Precio_Unitario` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID_Detalle`),
  KEY `fk_detallepedido_pedido` (`ID_Pedido`),
  KEY `fk_detallepedido_repuesto` (`ID_Repuesto`),
  CONSTRAINT `fk_detallepedido_pedido` FOREIGN KEY (`ID_Pedido`) REFERENCES `pedido` (`ID_Pedido`),
  CONSTRAINT `fk_detallepedido_repuesto` FOREIGN KEY (`ID_Repuesto`) REFERENCES `repuesto` (`ID_Repuesto`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detallepedido`
--

LOCK TABLES `detallepedido` WRITE;
/*!40000 ALTER TABLE `detallepedido` DISABLE KEYS */;
INSERT INTO `detallepedido` VALUES (1,1,1,10,NULL),(2,1,2,20,NULL),(3,2,3,15,NULL),(4,2,4,5,NULL),(5,3,5,10,NULL),(6,3,6,8,NULL),(7,4,7,6,NULL),(8,4,8,4,NULL),(9,5,9,12,NULL),(10,5,10,7,NULL),(11,6,11,10,NULL),(12,6,12,20,NULL),(13,7,13,5,NULL),(14,7,14,3,NULL),(15,8,15,6,NULL),(16,8,16,4,NULL),(17,9,17,12,NULL),(18,9,18,10,NULL),(19,10,19,8,NULL),(20,10,20,6,NULL),(21,11,21,15,NULL),(22,11,22,10,NULL),(23,12,23,5,NULL),(24,12,24,3,NULL),(25,13,25,10,NULL),(26,13,26,7,NULL),(27,14,27,12,NULL),(28,14,28,5,NULL),(29,15,29,15,NULL),(30,15,30,10,NULL);
/*!40000 ALTER TABLE `detallepedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `mantenientos_ultimo_mes`
--

DROP TABLE IF EXISTS `mantenientos_ultimo_mes`;
/*!50001 DROP VIEW IF EXISTS `mantenientos_ultimo_mes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `mantenientos_ultimo_mes` AS SELECT 
 1 AS `ID_Mantenimiento`,
 1 AS `Fecha_Mantenimiento`,
 1 AS `Descripcion`,
 1 AS `ID_Maquina`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `mantenimiento`
--

DROP TABLE IF EXISTS `mantenimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mantenimiento` (
  `ID_Mantenimiento` int NOT NULL AUTO_INCREMENT,
  `Fecha_Mantenimiento` date DEFAULT NULL,
  `Descripcion` text,
  `ID_Maquina` int DEFAULT NULL,
  PRIMARY KEY (`ID_Mantenimiento`),
  KEY `fk_Mantenimiento_Maquina` (`ID_Maquina`),
  CONSTRAINT `fk_Mantenimiento_Maquina` FOREIGN KEY (`ID_Maquina`) REFERENCES `maquina` (`ID_Maquina`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mantenimiento`
--

LOCK TABLES `mantenimiento` WRITE;
/*!40000 ALTER TABLE `mantenimiento` DISABLE KEYS */;
INSERT INTO `mantenimiento` VALUES (1,'2024-01-05',NULL,1),(2,'2024-01-10',NULL,2),(3,'2024-01-15',NULL,3),(4,'2024-01-20',NULL,4),(5,'2024-01-25',NULL,5),(6,'2024-01-30',NULL,6),(7,'2024-02-04',NULL,7),(8,'2024-02-09',NULL,8),(9,'2024-02-14',NULL,9),(10,'2024-02-19',NULL,10),(11,'2024-02-24',NULL,11),(12,'2024-03-01',NULL,12),(13,'2024-03-06',NULL,13),(14,'2024-03-11',NULL,14),(15,'2024-03-16',NULL,15),(16,'2024-03-21',NULL,16),(17,'2024-03-26',NULL,17),(18,'2024-03-31',NULL,18),(19,'2024-04-05',NULL,19),(20,'2024-04-10',NULL,20),(21,'2024-04-15',NULL,21),(22,'2024-04-20',NULL,22),(23,'2024-04-25',NULL,23),(24,'2024-04-30',NULL,24),(25,'2024-05-05',NULL,25),(26,'2024-05-10',NULL,26),(27,'2024-05-15',NULL,27),(28,'2024-05-20',NULL,28),(29,'2024-05-25',NULL,29),(30,'2024-05-30',NULL,30);
/*!40000 ALTER TABLE `mantenimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `mantenimientos_costosos`
--

DROP TABLE IF EXISTS `mantenimientos_costosos`;
/*!50001 DROP VIEW IF EXISTS `mantenimientos_costosos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `mantenimientos_costosos` AS SELECT 
 1 AS `ID_Mantenimiento`,
 1 AS `Fecha_Mantenimiento`,
 1 AS `Maquina`,
 1 AS `Costo_Total`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `maquina`
--

DROP TABLE IF EXISTS `maquina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maquina` (
  `ID_Maquina` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) DEFAULT NULL,
  `Modelo` varchar(100) DEFAULT NULL,
  `Fabricante` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_Maquina`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maquina`
--

LOCK TABLES `maquina` WRITE;
/*!40000 ALTER TABLE `maquina` DISABLE KEYS */;
INSERT INTO `maquina` VALUES (1,'Excavadora','320D','Caterpillar'),(2,'Retroexcavadora','310SL','John Deere'),(3,'Bulldozer','D65EX','Komatsu'),(4,'Cargadora','L120H','Volvo'),(5,'Grúa','LTM 1100','Liebherr'),(6,'Compactadora','BW 213','Bomag'),(7,'Excavadora','ZX300','Hitachi'),(8,'Minicargadora','S650','Bobcat'),(9,'Pavimentadora','SUPER 1803','Vogele'),(10,'Excavadora','330F','Caterpillar'),(11,'Retroexcavadora','3CX','JCB'),(12,'Bulldozer','850K','John Deere'),(13,'Cargadora','WA380','Komatsu'),(14,'Grúa','Grove GMK','Manitowoc'),(15,'Compactadora','CA2500','Dynapac'),(16,'Excavadora','EC250','Volvo'),(17,'Minicargadora','TR310','Case'),(18,'Pavimentadora','AP555F','Caterpillar'),(19,'Excavadora','R220','Hyundai'),(20,'Retroexcavadora','KX057','Kubota'),(21,'Bulldozer','D85EX','Komatsu'),(22,'Cargadora','L150H','Volvo'),(23,'Grúa','LTM 1250','Liebherr'),(24,'Compactadora','BW 177','Bomag'),(25,'Excavadora','ZX350','Hitachi'),(26,'Minicargadora','S770','Bobcat'),(27,'Pavimentadora','SUPER 1900','Vogele'),(28,'Excavadora','336D','Caterpillar'),(29,'Retroexcavadora','4CX','JCB'),(30,'Bulldozer','750K','John Deere');
/*!40000 ALTER TABLE `maquina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `ID_Pedido` int NOT NULL AUTO_INCREMENT,
  `Fecha_Pedido` date DEFAULT NULL,
  `Fecha_Recepcion` date DEFAULT NULL,
  `ID_Proveedor` int DEFAULT NULL,
  PRIMARY KEY (`ID_Pedido`),
  KEY `fk_pedido_proveedor` (`ID_Proveedor`),
  CONSTRAINT `fk_pedido_proveedor` FOREIGN KEY (`ID_Proveedor`) REFERENCES `proveedor` (`ID_Proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,'2024-01-01','2024-01-05',1),(2,'2024-01-02','2024-01-06',2),(3,'2024-01-03','2024-01-07',3),(4,'2024-01-04','2024-01-08',4),(5,'2024-01-05','2024-01-09',5),(6,'2024-01-06','2024-01-10',6),(7,'2024-01-07','2024-01-11',7),(8,'2024-01-08','2024-01-12',8),(9,'2024-01-09','2024-01-13',9),(10,'2024-01-10','2024-01-14',10),(11,'2024-01-11','2024-01-15',11),(12,'2024-01-12','2024-01-16',12),(13,'2024-01-13','2024-01-17',13),(14,'2024-01-14','2024-01-18',14),(15,'2024-01-15','2024-01-19',15),(16,'2024-01-16','2024-01-20',16),(17,'2024-01-17','2024-01-21',17),(18,'2024-01-18','2024-01-22',18),(19,'2024-01-19','2024-01-23',19),(20,'2024-01-20','2024-01-24',20),(21,'2024-01-21','2024-01-25',21),(22,'2024-01-22','2024-01-26',22),(23,'2024-01-23','2024-01-27',23),(24,'2024-01-24','2024-01-28',24),(25,'2024-01-25','2024-01-29',25),(26,'2024-01-26','2024-01-30',26),(27,'2024-01-27','2024-01-31',27),(28,'2024-01-28','2024-02-01',28),(29,'2024-01-29','2024-02-02',29),(30,'2024-01-30','2024-02-03',30),(31,'2024-06-29',NULL,29),(32,'2024-06-30',NULL,30);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Verificadr_Fechas` BEFORE INSERT ON `pedido` FOR EACH ROW BEGIN
    IF NEW.Fecha_Recepcion < NEW.Fecha_Pedido THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La fecha de reposición no puede ser anterior a la fecha de pedido';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `pedidos_pendientes`
--

DROP TABLE IF EXISTS `pedidos_pendientes`;
/*!50001 DROP VIEW IF EXISTS `pedidos_pendientes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `pedidos_pendientes` AS SELECT 
 1 AS `ID_Pedido`,
 1 AS `Nombre_Proveedor`,
 1 AS `Fecha_Pedido`,
 1 AS `Dias_Desde_Pedido`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `ID_Proveedor` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) DEFAULT NULL,
  `Direccion` varchar(100) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_Proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'Komatsu','Calle 1, Ciudad Industrial','1234567890','contacto@komatsu.com'),(2,'Caterpillar','Calle 2, Ciudad Industrial','0987654321','contacto@caterpillar.com'),(3,'Hitachi','Calle 3, Ciudad Industrial','1122334455','contacto@hitachi.com'),(4,'John Deere','Calle 4, Ciudad Industrial','6677889900','contacto@johndeere.com'),(5,'Volvo','Calle 5, Ciudad Industrial','5566778899','contacto@volvo.com'),(6,'Liebherr','Calle 6, Ciudad Industrial','4433221100','contacto@liebherr.com'),(7,'JCB','Calle 7, Ciudad Industrial','9988776655','contacto@jcb.com'),(8,'Kubota','Calle 8, Ciudad Industrial','5544332211','contacto@kubota.com'),(9,'Doosan','Calle 9, Ciudad Industrial','6655443322','contacto@doosan.com'),(10,'Hyundai','Calle 10, Ciudad Industrial','7766554433','contacto@hyundai.com'),(11,'Bobcat','Calle 11, Ciudad Industrial','8877665544','contacto@bobcat.com'),(12,'Sany','Calle 12, Ciudad Industrial','9988665544','contacto@sany.com'),(13,'Terex','Calle 13, Ciudad Industrial','6677884455','contacto@terex.com'),(14,'XCMG','Calle 14, Ciudad Industrial','5566998877','contacto@xcmg.com'),(15,'Case','Calle 15, Ciudad Industrial','1122998855','contacto@case.com'),(16,'New Holland','Calle 16, Ciudad Industrial','3344556677','contacto@newholland.com'),(17,'Mahindra','Calle 17, Ciudad Industrial','4455667788','contacto@mahindra.com'),(18,'Sumitomo','Calle 18, Ciudad Industrial','9988771122','contacto@sumitomo.com'),(19,'Zoomlion','Calle 19, Ciudad Industrial','2233445566','contacto@zoomlion.com'),(20,'Kobelco','Calle 20, Ciudad Industrial','1122336655','contacto@kobelco.com'),(21,'LiuGong','Calle 21, Ciudad Industrial','9988772233','contacto@liugong.com'),(22,'Bell','Calle 22, Ciudad Industrial','3344557799','contacto@bell.com'),(23,'Fendt','Calle 23, Ciudad Industrial','4455668899','contacto@fendt.com'),(24,'Manitou','Calle 24, Ciudad Industrial','9988773344','contacto@manitou.com'),(25,'Massey Ferguson','Calle 25, Ciudad Industrial','2233446677','contacto@masseyferguson.com'),(26,'Grove','Calle 26, Ciudad Industrial','1122337788','contacto@grove.com'),(27,'Genie','Calle 27, Ciudad Industrial','9988774455','contacto@genie.com'),(28,'Terex','Calle 28, Ciudad Industrial','3344558899','contacto@terex.com'),(29,'Atlas Copco','Calle 29, Ciudad Industrial','4455669900','contacto@atlascopco.com'),(30,'Sandvik','Calle 30, Ciudad Industrial','9988775566','contacto@sandvik.com');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `proveedores_mayor_volumen`
--

DROP TABLE IF EXISTS `proveedores_mayor_volumen`;
/*!50001 DROP VIEW IF EXISTS `proveedores_mayor_volumen`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `proveedores_mayor_volumen` AS SELECT 
 1 AS `ID_Proveedor`,
 1 AS `Nombre`,
 1 AS `Total_Repuestos`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `repuesto`
--

DROP TABLE IF EXISTS `repuesto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repuesto` (
  `ID_Repuesto` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) DEFAULT NULL,
  `Descripcion` text,
  `Precio` decimal(10,2) DEFAULT NULL,
  `Stock` int DEFAULT NULL,
  PRIMARY KEY (`ID_Repuesto`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repuesto`
--

LOCK TABLES `repuesto` WRITE;
/*!40000 ALTER TABLE `repuesto` DISABLE KEYS */;
INSERT INTO `repuesto` VALUES (1,'Filtro de Aceite','Filtro de aceite para maquinaria pesada',25.50,100),(2,'Filtro de Aire','Filtro de aire de alta eficiencia',30.00,150),(3,'Bujía','Bujía estándar para motores diésel',15.75,200),(4,'Correa de Transmisión','Correa de transmisión de alta resistencia',45.00,75),(5,'Aceite Hidráulico','Aceite hidráulico sintético',60.00,50),(6,'Neumático','Neumático de alta tracción',120.00,60),(7,'Batería','Batería de larga duración',80.00,40),(8,'Radiador','Radiador de alto rendimiento',150.00,30),(9,'Filtro de Combustible','Filtro de combustible de alta capacidad',20.00,120),(10,'Amortiguador','Amortiguador de suspensión',100.00,35),(11,'Luz LED','Luz LED de alta intensidad',25.00,85),(12,'Palanca de Cambio','Palanca de cambio ergonómica',35.00,90),(13,'Embrague','Kit de embrague completo',200.00,20),(14,'Pastilla de Freno','Pastilla de freno de alta durabilidad',40.00,150),(15,'Cadena de Transmisión','Cadena de transmisión resistente',55.00,70),(16,'Motor de Arranque','Motor de arranque de alto rendimiento',250.00,25),(17,'Alternador','Alternador de alta capacidad',180.00,45),(18,'Sensor de Temperatura','Sensor de temperatura de precisión',15.00,110),(19,'Termostato','Termostato de control preciso',20.00,95),(20,'Ventilador','Ventilador de refrigeración',75.00,50),(21,'Manguera Hidráulica','Manguera hidráulica flexible',35.00,65),(22,'Junta de Cabeza','Junta de cabeza resistente a altas temperaturas',50.00,40),(23,'Turbocompresor','Turbocompresor de alta potencia',300.00,15),(24,'Bomba de Agua','Bomba de agua de alto flujo',90.00,55),(25,'Válvula','Válvula de control de flujo',20.00,130),(26,'Disco de Freno','Disco de freno de alta resistencia',60.00,75),(27,'Rodamiento','Rodamiento de rueda',40.00,80),(28,'Resorte de Suspensión','Resorte de suspensión de alta durabilidad',50.00,70),(29,'Filtro de Partículas','Filtro de partículas para diésel',35.00,90),(30,'Lubricante','Lubricante multiuso',10.00,200);
/*!40000 ALTER TABLE `repuesto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repuestomaquina`
--

DROP TABLE IF EXISTS `repuestomaquina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repuestomaquina` (
  `ID_Repuesto` int NOT NULL,
  `ID_Maquina` int NOT NULL,
  `Cantidad_Necesaria` int DEFAULT NULL,
  PRIMARY KEY (`ID_Repuesto`,`ID_Maquina`),
  KEY `fk_RepuestoMaquina_Maquina` (`ID_Maquina`),
  CONSTRAINT `fk_RepuestoMaquina_Maquina` FOREIGN KEY (`ID_Maquina`) REFERENCES `maquina` (`ID_Maquina`),
  CONSTRAINT `fk_RepuestoMaquina_Repuesto` FOREIGN KEY (`ID_Repuesto`) REFERENCES `repuesto` (`ID_Repuesto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repuestomaquina`
--

LOCK TABLES `repuestomaquina` WRITE;
/*!40000 ALTER TABLE `repuestomaquina` DISABLE KEYS */;
INSERT INTO `repuestomaquina` VALUES (1,1,2),(2,1,4),(3,2,6),(4,2,3),(5,3,5),(6,3,2),(7,4,4),(8,4,2),(9,5,3),(10,5,1),(11,6,2),(12,6,3),(13,7,4),(14,7,2),(15,8,1),(16,8,3),(17,9,2),(18,9,4),(19,10,3),(20,10,1),(21,11,4),(22,11,2),(23,12,5),(24,12,3),(25,13,4),(26,13,2),(27,14,1),(28,14,3),(29,15,2),(30,15,4);
/*!40000 ALTER TABLE `repuestomaquina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `stock_repuestos`
--

DROP TABLE IF EXISTS `stock_repuestos`;
/*!50001 DROP VIEW IF EXISTS `stock_repuestos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `stock_repuestos` AS SELECT 
 1 AS `Id_Repuesto`,
 1 AS `Nombre`,
 1 AS `Stock`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'pentrega2'
--

--
-- Dumping routines for database 'pentrega2'
--
/*!50003 DROP FUNCTION IF EXISTS `Fn_Fecha_Recepcion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `Fn_Fecha_Recepcion`(Fecha_Pedido DATE, Fecha_Recepcion DATE) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE Dias_Pedido INT;
    SET Dias_Pedido = DATEDIFF(Fecha_Recepcion, Fecha_Pedido);
    RETURN Dias_Pedido;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `Total_Repuestos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `Total_Repuestos`() RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE total_repuestos INT;

    SELECT SUM(Cantidad_Usada) INTO total_repuestos
    FROM DetalleMantenimiento;

    RETURN total_repuestos;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `Valor_Stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `Valor_Stock`(Precio DECIMAL(10, 2), Stock INT) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
RETURN Precio * Stock;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Mantenimientos_Por_Maquina` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Mantenimientos_Por_Maquina`(IN maquinaID INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Repuestos_Poco_Stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Repuestos_Poco_Stock`(IN stock_minimo INT)
BEGIN
    SELECT *
    FROM Repuesto
    WHERE Stock < stock_minimo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_Valor_Total_Stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Valor_Total_Stock`()
BEGIN
    SELECT SUM(Precio * Stock) AS Valor_Stock_Total
    FROM Repuesto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `costo_de_mantenimiento_x_maquina`
--

/*!50001 DROP VIEW IF EXISTS `costo_de_mantenimiento_x_maquina`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `costo_de_mantenimiento_x_maquina` AS select `maquina`.`ID_Maquina` AS `ID_Maquina`,`maquina`.`Nombre` AS `Nombre`,sum((`detallemantenimiento`.`Cantidad_Usada` * `repuesto`.`Precio`)) AS `Costo_Total_Mantenimiento` from (((`mantenimiento` join `maquina` on((`mantenimiento`.`ID_Maquina` = `maquina`.`ID_Maquina`))) join `detallemantenimiento` on((`mantenimiento`.`ID_Mantenimiento` = `detallemantenimiento`.`ID_Mantenimiento`))) join `repuesto` on((`detallemantenimiento`.`ID_Repuesto` = `repuesto`.`ID_Repuesto`))) group by `maquina`.`ID_Maquina`,`maquina`.`Nombre` order by `Costo_Total_Mantenimiento` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mantenientos_ultimo_mes`
--

/*!50001 DROP VIEW IF EXISTS `mantenientos_ultimo_mes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `mantenientos_ultimo_mes` AS select `mantenimiento`.`ID_Mantenimiento` AS `ID_Mantenimiento`,`mantenimiento`.`Fecha_Mantenimiento` AS `Fecha_Mantenimiento`,`mantenimiento`.`Descripcion` AS `Descripcion`,`mantenimiento`.`ID_Maquina` AS `ID_Maquina` from `mantenimiento` where (`mantenimiento`.`Fecha_Mantenimiento` between '2024-05-01' and '2024-05-31') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mantenimientos_costosos`
--

/*!50001 DROP VIEW IF EXISTS `mantenimientos_costosos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `mantenimientos_costosos` AS select `mantenimiento`.`ID_Mantenimiento` AS `ID_Mantenimiento`,`mantenimiento`.`Fecha_Mantenimiento` AS `Fecha_Mantenimiento`,`maquina`.`Nombre` AS `Maquina`,sum((`detallemantenimiento`.`Cantidad_Usada` * `repuesto`.`Precio`)) AS `Costo_Total` from (((`detallemantenimiento` join `repuesto` on((`detallemantenimiento`.`ID_Repuesto` = `repuesto`.`ID_Repuesto`))) join `mantenimiento` on((`detallemantenimiento`.`ID_Mantenimiento` = `mantenimiento`.`ID_Mantenimiento`))) join `maquina` on((`mantenimiento`.`ID_Maquina` = `maquina`.`ID_Maquina`))) group by `mantenimiento`.`ID_Mantenimiento`,`mantenimiento`.`Fecha_Mantenimiento`,`maquina`.`Nombre` order by `Costo_Total` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `pedidos_pendientes`
--

/*!50001 DROP VIEW IF EXISTS `pedidos_pendientes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `pedidos_pendientes` AS select `pedido`.`ID_Pedido` AS `ID_Pedido`,`proveedor`.`Nombre` AS `Nombre_Proveedor`,`pedido`.`Fecha_Pedido` AS `Fecha_Pedido`,(to_days(curdate()) - to_days(`pedido`.`Fecha_Pedido`)) AS `Dias_Desde_Pedido` from (`pedido` join `proveedor` on((`pedido`.`ID_Proveedor` = `proveedor`.`ID_Proveedor`))) where (`pedido`.`Fecha_Recepcion` is null) order by (to_days(curdate()) - to_days(`pedido`.`Fecha_Pedido`)) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `proveedores_mayor_volumen`
--

/*!50001 DROP VIEW IF EXISTS `proveedores_mayor_volumen`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `proveedores_mayor_volumen` AS select `proveedor`.`ID_Proveedor` AS `ID_Proveedor`,`proveedor`.`Nombre` AS `Nombre`,sum(`detallepedido`.`Cantidad`) AS `Total_Repuestos` from ((`detallepedido` join `pedido` on((`detallepedido`.`ID_Pedido` = `pedido`.`ID_Pedido`))) join `proveedor` on((`pedido`.`ID_Proveedor` = `proveedor`.`ID_Proveedor`))) group by `proveedor`.`ID_Proveedor`,`proveedor`.`Nombre` order by `Total_Repuestos` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `stock_repuestos`
--

/*!50001 DROP VIEW IF EXISTS `stock_repuestos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `stock_repuestos` AS select `repuesto`.`ID_Repuesto` AS `Id_Repuesto`,`repuesto`.`Nombre` AS `Nombre`,`repuesto`.`Stock` AS `Stock` from `repuesto` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-29 21:29:10
