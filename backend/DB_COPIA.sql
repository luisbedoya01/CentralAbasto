-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: abastodb
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `abasto_cabecera_factura`
--

DROP TABLE IF EXISTS `abasto_cabecera_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_cabecera_factura` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigoFactura` varchar(25) DEFAULT NULL,
  `tipoIdCliente` char(1) DEFAULT NULL,
  `idCliente` varchar(45) DEFAULT NULL,
  `idPedido` int DEFAULT NULL,
  `nombreCliente` varchar(150) DEFAULT NULL,
  `apellidoCliente` varchar(150) DEFAULT NULL,
  `fechaEmision` datetime DEFAULT NULL,
  `telefonoCliente` varchar(10) DEFAULT NULL,
  `emailCliente` varchar(100) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `IVA` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `idEstado` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_cabecera_factura`
--

LOCK TABLES `abasto_cabecera_factura` WRITE;
/*!40000 ALTER TABLE `abasto_cabecera_factura` DISABLE KEYS */;
INSERT INTO `abasto_cabecera_factura` VALUES (47,'FACT-20251006-0001','C','123456789',41,'Cliente ','De Prueba','2025-10-06 15:38:11','0988293905','luisbedoya72@gmail.com',52.50,3.49,55.99,7),(48,'FACT-20251006-0002','C','123456789',41,'Cliente ','De Prueba','2025-10-06 15:38:11','0988293905','luisbedoya72@gmail.com',52.50,3.49,55.99,7);
/*!40000 ALTER TABLE `abasto_cabecera_factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_categorias`
--

DROP TABLE IF EXISTS `abasto_categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_categorias` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` text NOT NULL,
  `descripcion` text,
  `idEstado` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idCategoria` (`id`),
  KEY `fk_estado_categoria` (`idEstado`),
  CONSTRAINT `fk_estado_categoria` FOREIGN KEY (`idEstado`) REFERENCES `abasto_estados` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_categorias`
--

LOCK TABLES `abasto_categorias` WRITE;
/*!40000 ALTER TABLE `abasto_categorias` DISABLE KEYS */;
INSERT INTO `abasto_categorias` VALUES (1,'Frutas y Verduras','Productos frescos como frutas y verduras',1),(2,'Carnes y Aves','Productos cárnicos como carne de res, pollo, y cerdo',1),(3,'Lácteos','Productos derivados de la leche como queso, leche, y yogur',1),(4,'Panadería','Productos de panadería como pan, pasteles, y galletas',1),(5,'Bebidas','Bebidas alcohólicas y no alcohólicas como jugos, refrescos, y vinos',1),(6,'Enlatados y Conservas','Productos enlatados y conservas como frijoles, atún, y salsas',1),(7,'Limpieza y Hogar','Productos de limpieza y artículos para el hogar',1),(8,'Cuidado Personal','Productos de higiene personal como champú, jabón, y pasta de dientes',1),(9,'anakna','kankank',1),(10,'Categoria de prueba 2','prueba de inserción',1),(11,'Categoria de prueba 3','PRUEBA',1),(12,'Insumos médicos','null',1),(13,'Aceites vegetales','Aceites varios para uso comestible',1),(14,'Granos','Granos',1),(15,'Huevos ','null',1);
/*!40000 ALTER TABLE `abasto_categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_clientes`
--

DROP TABLE IF EXISTS `abasto_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_clientes` (
  `codIdentificacion` varchar(20) NOT NULL,
  `codTipoId` char(1) DEFAULT NULL,
  `nombres` varchar(150) DEFAULT NULL,
  `apellidos` varchar(150) DEFAULT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`codIdentificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_clientes`
--

LOCK TABLES `abasto_clientes` WRITE;
/*!40000 ALTER TABLE `abasto_clientes` DISABLE KEYS */;
INSERT INTO `abasto_clientes` VALUES ('1201815410','C','Luis','Bedoya Jaime','0988293905','luisbedoya72@gmail.com'),('1207935097','C','Alberto','Jaime','0993531894','albertojaime2001@gmail.com');
/*!40000 ALTER TABLE `abasto_clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_detalle_factura`
--

DROP TABLE IF EXISTS `abasto_detalle_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_detalle_factura` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigoFactura` varchar(25) DEFAULT NULL,
  `idFactura` int DEFAULT NULL,
  `idProducto` int DEFAULT NULL,
  `codigoProducto` varchar(50) DEFAULT NULL,
  `nombreProducto` varchar(255) DEFAULT NULL,
  `marca` varchar(100) DEFAULT NULL,
  `unidadMedida` varchar(50) DEFAULT NULL,
  `cantidadSeleccionada` decimal(10,2) DEFAULT NULL,
  `precioUnitario` decimal(10,2) DEFAULT NULL,
  `subTotal` decimal(10,2) DEFAULT NULL,
  `iva` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `impuestoProducto` char(1) DEFAULT NULL,
  `porcentajeIva` decimal(5,2) DEFAULT NULL,
  `idEstado` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_detalle_factura`
--

LOCK TABLES `abasto_detalle_factura` WRITE;
/*!40000 ALTER TABLE `abasto_detalle_factura` DISABLE KEYS */;
INSERT INTO `abasto_detalle_factura` VALUES (148,'FACT-20251006-0001',47,4,'PROD-4','Huevos medianos ALIADA','ALIADA','Cubeta',1.00,3.75,3.75,0.00,3.75,'N',15.00,7),(149,'FACT-20251006-0001',47,33,'PROD-1','Aceite de Girasol Omega 5','Rica Palma','Caja',2.00,12.75,25.50,0.00,25.50,'N',15.00,7),(150,'FACT-20251006-0001',47,34,'PROD-15','Arroz Caballo Verde','Patito','Libra',25.00,0.45,11.25,1.69,12.94,'S',15.00,7),(151,'FACT-20251006-0001',47,1,'PROD-1','Leche Entera Parmalat 1LT','Parmalat','Unidad',10.00,1.20,12.00,1.80,13.80,'S',15.00,7);
/*!40000 ALTER TABLE `abasto_detalle_factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_detalle_pedido`
--

DROP TABLE IF EXISTS `abasto_detalle_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_detalle_pedido` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigoPedido` varchar(25) DEFAULT NULL,
  `idPedido` int DEFAULT NULL,
  `idProducto` int DEFAULT NULL,
  `subTotal` decimal(10,2) DEFAULT NULL,
  `iva` decimal(10,2) DEFAULT NULL,
  `cantidadSeleccionada` decimal(10,2) DEFAULT NULL,
  `idUnidad` int DEFAULT NULL,
  `idEstado` int DEFAULT NULL,
  `CodigoProducto` varchar(50) DEFAULT NULL,
  `NombreProducto` varchar(255) DEFAULT NULL,
  `Marca` varchar(100) DEFAULT NULL,
  `PrecioUnitario` decimal(10,2) DEFAULT NULL,
  `UnidadMedida` varchar(50) DEFAULT NULL,
  `IdPrecioVenta` int DEFAULT NULL,
  `ImpuestoProducto` char(1) DEFAULT NULL,
  `PorcentajeIva` decimal(5,2) DEFAULT NULL,
  `Total` decimal(10,2) DEFAULT NULL,
  `NecesitaConversion` char(1) DEFAULT NULL,
  `FactorConversion` decimal(10,4) DEFAULT NULL,
  `IdConversionVenta` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_detalle_pedido`
--

LOCK TABLES `abasto_detalle_pedido` WRITE;
/*!40000 ALTER TABLE `abasto_detalle_pedido` DISABLE KEYS */;
INSERT INTO `abasto_detalle_pedido` VALUES (28,'PED-20250911-0001',37,4,7.50,0.00,2.00,11,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(29,'PED-20250911-0001',37,34,4.50,0.67,10.00,8,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(30,'PED-20250911-0002',38,34,11.25,1.69,25.00,8,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(31,'PED-20250911-0002',38,1,15.00,2.25,2.00,10,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(32,'PED-20250911-0002',38,33,25.50,0.00,2.00,9,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(35,'PED-20250918-0001',41,34,11.25,1.69,25.00,8,4,'PROD-15','Arroz Caballo Verde','Patito',0.45,'Libra',17,'S',15.00,12.94,'N',200.0000,14),(36,'PED-20250918-0001',41,33,25.50,0.00,2.00,9,4,'PROD-1','Aceite de Girasol Omega 5','Rica Palma',12.75,'Caja',20,'N',15.00,25.50,'S',20.0000,15),(37,'PED-20250918-0001',41,4,3.75,0.00,1.00,11,4,'PROD-4','Huevos medianos ALIADA','ALIADA',3.75,'Cubeta',23,'N',15.00,3.75,'S',30.0000,17),(38,'PED-20250918-0002',42,33,12.75,0.00,1.00,9,4,'PROD-1','Aceite de Girasol Omega 5','Rica Palma',12.75,'Caja',20,'N',15.00,12.75,'S',20.0000,15),(39,'PED-20250918-0002',42,1,22.50,3.38,3.00,10,4,'PROD-1','Leche Entera Parmalat 1LT','Parmalat',7.50,'Caja (6)',21,'S',15.00,25.87,'S',6.0000,16),(40,'PED-20250918-0002',42,4,2.25,0.00,15.00,7,4,'PROD-4','Huevos medianos ALIADA','ALIADA',0.15,'Unidad',22,'N',15.00,2.25,'N',30.0000,17),(43,'PED-20250918-0001',41,1,12.00,1.80,10.00,7,4,'PROD-1','Leche Entera Parmalat 1LT','Parmalat',1.20,'Unidad',11,'S',15.00,13.80,'N',6.0000,16),(44,'PED-20251003-0001',43,34,11.25,1.69,25.00,8,4,'PROD-15','Arroz Caballo Verde','Patito',0.45,'Libra',17,'S',15.00,12.94,'N',200.0000,14),(45,'PED-20251003-0001',43,1,22.50,3.38,3.00,10,4,'PROD-1','Leche Entera Parmalat 1LT','Parmalat',7.50,'Caja (6)',21,'S',15.00,25.87,'S',6.0000,16),(46,'PED-20251003-0001',43,33,25.50,0.00,2.00,9,4,'PROD-1','Aceite de Girasol Omega 5','Rica Palma',12.75,'Caja',20,'N',15.00,25.50,'S',20.0000,15),(47,'PED-20251003-0001',43,4,3.75,0.00,1.00,11,4,'PROD-4','Huevos medianos ALIADA','ALIADA',3.75,'Cubeta',23,'N',15.00,3.75,'S',30.0000,17),(48,'PED-20251006-0001',44,34,10.25,1.54,1.00,3,4,'PROD-15','Arroz Caballo Verde','Patito',10.25,'Quintal',16,'S',15.00,11.79,'S',200.0000,14),(49,'PED-20251006-0001',44,1,12.00,1.80,10.00,7,4,'PROD-1','Leche Entera Parmalat 1LT','Parmalat',1.20,'Unidad',11,'S',15.00,13.80,'N',6.0000,16),(50,'PED-20251006-0002',45,4,7.50,0.00,2.00,11,4,'PROD-4','Huevos medianos ALIADA','ALIADA',3.75,'Cubeta',23,'N',15.00,7.50,'S',30.0000,17),(51,'PED-20251006-0002',45,33,12.75,0.00,1.00,9,4,'PROD-1','Aceite de Girasol Omega 5','Rica Palma',12.75,'Caja',20,'N',15.00,12.75,'S',20.0000,15),(52,'PED-20251020-0001',46,1,30.00,4.50,4.00,10,3,'PROD-1','Leche Entera Parmalat 1LT','Parmalat',7.50,'Caja (6)',21,'S',15.00,34.50,'S',6.0000,16),(53,'PED-20251020-0001',46,4,2.25,0.00,15.00,7,3,'PROD-4','Huevos medianos ALIADA','ALIADA',0.15,'Unidad',22,'N',15.00,2.25,'N',30.0000,17),(54,'PED-20251020-0001',46,34,9.00,1.35,20.00,8,3,'PROD-15','Arroz Caballo Verde','Patito',0.45,'Libra',17,'S',15.00,10.35,'N',200.0000,14),(55,'PED-20251020-0002',47,34,6.75,1.01,15.00,8,3,'PROD-15','Arroz Caballo Verde','Patito',0.45,'Libra',17,'S',15.00,7.76,'N',200.0000,14),(56,'PED-20251020-0002',47,4,2.25,0.00,15.00,7,3,'PROD-4','Huevos medianos ALIADA','ALIADA',0.15,'Unidad',22,'N',15.00,2.25,'N',30.0000,17),(57,'PED-20251020-0002',47,1,30.00,4.50,4.00,10,3,'PROD-1','Leche Entera Parmalat 1LT','Parmalat',7.50,'Caja (6)',21,'S',15.00,34.50,'S',6.0000,16),(58,'PED-20251020-0003',48,34,6.75,1.01,15.00,8,4,'PROD-15','Arroz Caballo Verde','Patito',0.45,'Libra',17,'S',15.00,7.76,'N',200.0000,14),(59,'PED-20251020-0003',48,1,30.00,4.50,4.00,10,4,'PROD-1','Leche Entera Parmalat 1LT','Parmalat',7.50,'Caja (6)',21,'S',15.00,34.50,'S',6.0000,16),(60,'PED-20251020-0003',48,4,2.25,0.00,15.00,7,4,'PROD-4','Huevos medianos ALIADA','ALIADA',0.15,'Unidad',22,'N',15.00,2.25,'N',30.0000,17);
/*!40000 ALTER TABLE `abasto_detalle_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_estados`
--

DROP TABLE IF EXISTS `abasto_estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_estados` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` text NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_estados`
--

LOCK TABLES `abasto_estados` WRITE;
/*!40000 ALTER TABLE `abasto_estados` DISABLE KEYS */;
INSERT INTO `abasto_estados` VALUES (1,'Activo','Estado activo'),(2,'Inactivo','Estado inactivo'),(3,'Eliminado','Estado eliminado'),(4,'Pendiente por facturar','Pedido pendiente'),(5,'Despachado','Pedido despachado'),(6,'Cancelado','Pedido cancelado'),(7,'Facturado','Pedido facturado y factura creada');
/*!40000 ALTER TABLE `abasto_estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_inventario`
--

DROP TABLE IF EXISTS `abasto_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_inventario` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `idProducto` bigint DEFAULT NULL,
  `cantidadStock` decimal(5,2) NOT NULL,
  `idEstado` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idProducto` (`idProducto`),
  KEY `fk_estado_inventario` (`idEstado`),
  CONSTRAINT `abasto_inventario_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `abasto_productos` (`id`),
  CONSTRAINT `fk_estado_inventario` FOREIGN KEY (`idEstado`) REFERENCES `abasto_estados` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_inventario`
--

LOCK TABLES `abasto_inventario` WRITE;
/*!40000 ALTER TABLE `abasto_inventario` DISABLE KEYS */;
/*!40000 ALTER TABLE `abasto_inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_iva`
--

DROP TABLE IF EXISTS `abasto_iva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_iva` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_iva`
--

LOCK TABLES `abasto_iva` WRITE;
/*!40000 ALTER TABLE `abasto_iva` DISABLE KEYS */;
INSERT INTO `abasto_iva` VALUES (5,'Impuesto al Valor Agregado',15.00);
/*!40000 ALTER TABLE `abasto_iva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_marca`
--

DROP TABLE IF EXISTS `abasto_marca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_marca` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` text NOT NULL,
  `id_estado` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_marca`
--

LOCK TABLES `abasto_marca` WRITE;
/*!40000 ALTER TABLE `abasto_marca` DISABLE KEYS */;
INSERT INTO `abasto_marca` VALUES (1,'Marca de prueba 1',1),(2,'Marca de prueba',1),(3,'Toni',1),(4,'Patito',1),(5,'Rica Palma',1),(6,'Parmalat',1),(7,'ALIADA',1);
/*!40000 ALTER TABLE `abasto_marca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_medidas_conversion`
--

DROP TABLE IF EXISTS `abasto_medidas_conversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_medidas_conversion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idUnidadPrincipal` int DEFAULT NULL,
  `idUnidadConvertir` int DEFAULT NULL,
  `factorConversion` decimal(12,6) DEFAULT NULL,
  `idEstado` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_medidas_conversion`
--

LOCK TABLES `abasto_medidas_conversion` WRITE;
/*!40000 ALTER TABLE `abasto_medidas_conversion` DISABLE KEYS */;
INSERT INTO `abasto_medidas_conversion` VALUES (1,8,8,1.000000,3),(2,3,4,25.000000,3),(3,3,7,35.000000,3),(4,3,8,45.000000,3),(5,3,8,50.000000,3),(6,3,8,200.000000,3),(7,3,8,36.000000,3),(8,3,8,45.000000,3),(9,3,8,44.000000,3),(10,3,8,150.000000,3),(11,3,7,450.000000,3),(12,3,8,42.000000,3),(13,3,8,42.000000,3),(14,3,8,200.000000,1),(15,9,7,20.000000,1),(16,10,7,6.000000,1),(17,11,7,30.000000,1),(18,1,2,15.000000,1),(19,1,2,15.000000,1);
/*!40000 ALTER TABLE `abasto_medidas_conversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_movimientos`
--

DROP TABLE IF EXISTS `abasto_movimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_movimientos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `idProducto` bigint DEFAULT NULL,
  `tipo` enum('Entrada','Salida') NOT NULL,
  `cantidad` int NOT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `idEstado` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idProducto` (`idProducto`),
  KEY `fk_estado_movimiento` (`idEstado`),
  CONSTRAINT `abasto_movimientos_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `abasto_productos` (`id`),
  CONSTRAINT `fk_estado_movimiento` FOREIGN KEY (`idEstado`) REFERENCES `abasto_estados` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_movimientos`
--

LOCK TABLES `abasto_movimientos` WRITE;
/*!40000 ALTER TABLE `abasto_movimientos` DISABLE KEYS */;
/*!40000 ALTER TABLE `abasto_movimientos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_pedidos`
--

DROP TABLE IF EXISTS `abasto_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_pedidos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(25) DEFAULT NULL,
  `idCliente` varchar(45) DEFAULT NULL,
  `subTotal` decimal(10,2) DEFAULT NULL,
  `IVA` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `idEstado` int DEFAULT NULL,
  `fechaCreacion` datetime DEFAULT NULL,
  `fechaActualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_pedidos`
--

LOCK TABLES `abasto_pedidos` WRITE;
/*!40000 ALTER TABLE `abasto_pedidos` DISABLE KEYS */;
INSERT INTO `abasto_pedidos` VALUES (37,'PED-20250911-0001','Luis Bedoya',12.00,0.67,12.68,4,'2025-09-11 12:46:42',NULL),(38,'PED-20250911-0002','Alberto Jaime',51.75,3.94,55.69,4,'2025-09-11 12:47:24',NULL),(41,'PED-20250918-0001','Luis Bedoya',52.50,3.49,55.99,7,'2025-09-18 11:19:46','2025-10-06 15:38:11'),(42,'PED-20250918-0002','Prueba',37.50,3.38,40.88,4,'2025-09-18 11:23:25','2025-10-06 11:52:17'),(43,'PED-20251003-0001','Jaime Sandoval',63.00,5.07,68.07,4,'2025-10-03 09:52:23','2025-10-03 22:13:34'),(44,'PED-20251006-0001','Cliente de Prueba',22.25,3.34,25.59,4,'2025-10-06 11:07:45','2025-10-06 15:34:05'),(45,'PED-20251006-0002','Cliente Prueba 2',20.25,0.00,20.25,4,'2025-10-06 11:08:21',NULL),(46,'PED-20251020-0001','Alberto Jaime',41.25,5.85,47.10,6,'2025-10-20 12:20:53','2025-10-20 13:49:55'),(47,'PED-20251020-0002','Alberto Jaime',39.00,5.51,44.51,6,'2025-10-20 13:58:31','2025-10-20 14:18:00'),(48,'PED-20251020-0003','Alberto Jaime',39.00,5.51,44.51,4,'2025-10-20 14:28:01',NULL);
/*!40000 ALTER TABLE `abasto_pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_precios_venta`
--

DROP TABLE IF EXISTS `abasto_precios_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_precios_venta` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idProducto` bigint NOT NULL,
  `idUnidadMedida` int NOT NULL,
  `precioVenta` decimal(10,2) NOT NULL,
  `idEstado` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idProducto` (`idProducto`),
  KEY `idUnidadMedida` (`idUnidadMedida`),
  CONSTRAINT `abasto_precios_venta_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `abasto_productos` (`id`),
  CONSTRAINT `abasto_precios_venta_ibfk_2` FOREIGN KEY (`idUnidadMedida`) REFERENCES `abasto_unidades_medida` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_precios_venta`
--

LOCK TABLES `abasto_precios_venta` WRITE;
/*!40000 ALTER TABLE `abasto_precios_venta` DISABLE KEYS */;
INSERT INTO `abasto_precios_venta` VALUES (1,25,1,25.00,1),(2,25,1,20.00,1),(3,26,1,80.25,1),(4,26,1,48.00,1),(5,26,1,54.00,1),(6,26,1,25.00,1),(7,27,1,50.00,1),(8,27,1,78.00,1),(9,31,1,78.50,1),(10,1,1,1.20,3),(11,1,7,1.20,1),(12,3,2,17.50,1),(13,1,2,7.25,3),(14,1,3,22.00,3),(15,12,4,1.50,1),(16,34,3,10.25,1),(17,34,8,0.45,1),(18,33,7,1.50,1),(19,12,8,0.80,1),(20,33,9,12.75,1),(21,1,10,7.50,1),(22,4,7,0.15,1),(23,4,11,3.75,1);
/*!40000 ALTER TABLE `abasto_precios_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_productos`
--

DROP TABLE IF EXISTS `abasto_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_productos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `codigoProducto` varchar(20) DEFAULT NULL,
  `nombre` text NOT NULL,
  `precioCompra` decimal(10,2) NOT NULL,
  `idCategoria` bigint DEFAULT NULL,
  `idMarca` int DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `stockMaximo` int DEFAULT NULL,
  `stockMinimo` int DEFAULT NULL,
  `idProveedor` int DEFAULT NULL,
  `idEstado` bigint DEFAULT NULL,
  `porcentajeGanancia` decimal(5,2) DEFAULT '0.00',
  `impuestoProducto` char(1) DEFAULT NULL,
  `ventaGranel` char(1) DEFAULT NULL,
  `FechaVencimiento` date DEFAULT NULL,
  `esPerecible` char(1) DEFAULT NULL,
  `idUnidadConversionVenta` int DEFAULT NULL,
  `stockPedido` decimal(12,6) DEFAULT '0.000000',
  `nombreUnidadVenta` text,
  PRIMARY KEY (`id`),
  KEY `idCategoria` (`idCategoria`),
  KEY `fk_estado_producto` (`idEstado`),
  CONSTRAINT `abasto_productos_ibfk_1` FOREIGN KEY (`idCategoria`) REFERENCES `abasto_categorias` (`id`),
  CONSTRAINT `fk_estado_producto` FOREIGN KEY (`idEstado`) REFERENCES `abasto_estados` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_productos`
--

LOCK TABLES `abasto_productos` WRITE;
/*!40000 ALTER TABLE `abasto_productos` DISABLE KEYS */;
INSERT INTO `abasto_productos` VALUES (1,'PROD-1','Leche Entera Parmalat 1LT',45.80,3,6,240,100,10,6,1,0.00,'S','N','1999-12-31','N',16,0.000000,NULL),(2,'PROD-2','Producto de prueba',12.50,5,1,10,50,25,1,3,0.00,'N','N','1999-12-31','S',NULL,0.000000,NULL),(3,'PROD-3','Producto de prueba 2',22.00,7,1,5,25,15,1,3,0.00,'S','N','2025-04-26','N',NULL,0.000000,NULL),(4,'PROD-4','Huevos medianos ALIADA',22.00,15,7,90,50,35,7,1,0.00,'N','S','1999-12-31','N',17,0.000000,NULL),(5,'PROD-5','Producto para eliminar',250.00,4,1,12,25,15,1,3,0.00,'N','N','2025-04-03','N',NULL,0.000000,NULL),(6,'PROD-6','Producto nuevo (editado)',11.00,3,1,30,60,8,1,3,0.00,'N','N','2025-04-26','N',NULL,0.000000,NULL),(7,'PROD-7','Segunda prueba para eliminación',250.00,3,1,20,40,10,1,3,0.00,'S','S','2025-04-19','N',NULL,0.000000,NULL),(8,'PROD-8','Prueba de inserción de producto',12.00,5,1,0,100,75,1,3,0.00,'S','N','2025-04-17','S',NULL,0.000000,NULL),(9,'PROD-9','Prueba inserción 2',125.00,8,1,0,150,45,1,3,0.00,'S','S','2025-04-04','S',NULL,0.000000,NULL),(10,'RUB-01','Producto de prueba nuevo',50.00,2,1,25,100,10,1,3,15.00,'N','N','2025-04-16','S',NULL,0.000000,NULL),(11,'RUB-02','Producto de prueba nuevo 2',200.00,1,1,24,100,20,1,3,10.00,'N','N','2025-04-26','N',NULL,0.000000,NULL),(12,'ajajb','Prueba de edicion',20.00,2,1,4,6,2,1,3,5.00,'N','N','2025-04-27','S',NULL,0.000000,NULL),(13,'RUB-03','Producto de prueba nuevo 4',50.00,4,1,10,54,20,1,3,10.00,'N','N','2025-04-20','S',NULL,0.000000,NULL),(14,'RUB-04','Producto con id devuelto',20.00,3,1,20,30,15,1,3,5.00,'N','N','2025-04-03','N',NULL,0.000000,NULL),(15,'RUB-05','Producto con id devuelto 2',145.00,2,1,20,45,30,1,3,20.00,'N','N','2025-04-20','S',NULL,0.000000,NULL),(16,'RUB-05','Producto con id devuelto 2',145.00,2,1,20,45,30,1,3,20.00,'N','N','2025-04-20','N',NULL,0.000000,NULL),(17,'RUB-01','Segunda prueba para eliminación',250.00,2,1,14,200,20,1,3,5.00,'N','N','2025-04-23','N',NULL,0.000000,NULL),(18,'RUB-08','Producto id devuelto',20.00,3,1,15,200,20,1,3,2.00,'N','N','2025-04-16','N',NULL,0.000000,NULL),(19,'RUB-09','Producto id devuelto 2',52.00,2,1,25,10,8,1,3,4.00,'N','N','2025-04-19','N',NULL,0.000000,NULL),(20,'RUB-10','Producto con id devuelto 1',15.00,4,1,10,50,5,1,3,5.00,'N','N','2025-04-27','S',NULL,0.000000,NULL),(21,'RUB-11','ajnajn',24.00,2,1,10,25,14,1,3,10.00,'N','N','2025-04-17','S',NULL,0.000000,NULL),(22,'PROD-10','Producto perecible con impuesto',25.00,3,1,15,50,5,1,3,10.00,'S','S','2025-04-20','S',NULL,0.000000,NULL),(23,'PROD-11','Producto no perecible',2.50,6,1,15,75,20,1,3,10.00,'N','N','1999-12-31','N',NULL,0.000000,NULL),(24,'RUB-12','Producto ingreso id',25.00,5,1,12,50,10,1,3,12.00,'N','N','1999-12-31','N',NULL,0.000000,NULL),(25,'RUB-10','Producto con precios de venta',250.00,2,1,25,75,15,1,3,780.00,'N','N',NULL,'N',NULL,0.000000,NULL),(26,'RUB-04','Producto con precios de venta 2',15.00,1,1,48,70,15,1,3,7.00,'N','N','1999-12-31','N',NULL,0.000000,NULL),(27,'RUB-10','Producto precio venta',48.00,5,1,50,150,25,1,3,12.00,'N','N','1999-12-31','N',NULL,0.000000,NULL),(28,'PROD150','PRODUCTO PRECIO VENTA',50.00,2,1,78,120,48,1,3,2.50,'S','S','2025-04-20','S',NULL,0.000000,NULL),(29,'PROD-PREC1','PRECIO VENTA PRODUCTO',87.00,4,1,78,95,20,1,3,5.00,'N','N','1999-12-31','N',NULL,0.000000,NULL),(30,'RUB-04','PRECIO VENTA PRODUCTO2',50.00,6,1,50,150,25,1,3,12.00,'N','N',NULL,'N',NULL,0.000000,NULL),(31,'RUB-10','Producto nuevo (editado)',80.00,1,1,87,54151,5151,1,3,15.00,'N','N',NULL,'N',NULL,0.000000,NULL),(32,'RUB-10','productoprecioventa',150.00,2,1,78,90,45,1,3,12.00,'N','N',NULL,'N',NULL,0.000000,NULL),(33,'PROD-1','Aceite de Girasol Omega 5',85.00,13,5,210,85,60,1,1,10.00,'N','N','1999-12-31','N',15,10.000000,NULL),(34,'PROD-15','Arroz Caballo Verde',5.00,1,4,110,200,75,6,1,10.00,'S','S','1999-12-31','N',14,0.000000,NULL);
/*!40000 ALTER TABLE `abasto_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_proveedor`
--

DROP TABLE IF EXISTS `abasto_proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_proveedor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ruc` varchar(13) DEFAULT NULL,
  `nombre` text,
  `direccion` text,
  `telefono` varchar(45) DEFAULT NULL,
  `idEstado` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_proveedor`
--

LOCK TABLES `abasto_proveedor` WRITE;
/*!40000 ALTER TABLE `abasto_proveedor` DISABLE KEYS */;
INSERT INTO `abasto_proveedor` VALUES (1,'1207935097001','Luis Bedoya','Guayaquil','0988293905',1),(4,'1207935097001','Proveedor de prueba','Guayas','0988293905',1),(5,'1207935097001','Proveedor de prueba 2','LOS RIOS','0988293905',1),(6,'1207935097001','TONI S.A','Guayaquil','0988293905',1),(7,'0123456789101','TIA S.A','Guayaquil','0988293905',1);
/*!40000 ALTER TABLE `abasto_proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_rol_usuario`
--

DROP TABLE IF EXISTS `abasto_rol_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_rol_usuario` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_rol_usuario`
--

LOCK TABLES `abasto_rol_usuario` WRITE;
/*!40000 ALTER TABLE `abasto_rol_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `abasto_rol_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_rol_usuarios`
--

DROP TABLE IF EXISTS `abasto_rol_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_rol_usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_rol_usuarios`
--

LOCK TABLES `abasto_rol_usuarios` WRITE;
/*!40000 ALTER TABLE `abasto_rol_usuarios` DISABLE KEYS */;
INSERT INTO `abasto_rol_usuarios` VALUES (1,'Administrador'),(2,'Cajero'),(3,'Despachador');
/*!40000 ALTER TABLE `abasto_rol_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_stock`
--

DROP TABLE IF EXISTS `abasto_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_stock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idProducto` int DEFAULT NULL,
  `cantidadStock` decimal(5,2) DEFAULT '0.00',
  `fechaIngreso` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_stock`
--

LOCK TABLES `abasto_stock` WRITE;
/*!40000 ALTER TABLE `abasto_stock` DISABLE KEYS */;
INSERT INTO `abasto_stock` VALUES (1,1,120.00,'2025-09-04 00:00:00'),(2,1,120.00,'2025-09-04 00:00:00'),(3,1,120.00,'2025-09-04 00:00:00'),(4,1,240.00,'2025-09-04 00:00:00'),(5,33,150.00,'2025-09-04 17:28:35'),(6,1,250.00,'2025-09-05 11:55:59'),(7,34,200.00,'2025-09-05 11:59:08'),(8,4,150.00,'2025-09-05 12:02:03'),(9,4,40.00,'2025-09-05 12:05:53');
/*!40000 ALTER TABLE `abasto_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_unidades_medida`
--

DROP TABLE IF EXISTS `abasto_unidades_medida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_unidades_medida` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` text NOT NULL,
  `idEstado` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_unidades_medida`
--

LOCK TABLES `abasto_unidades_medida` WRITE;
/*!40000 ALTER TABLE `abasto_unidades_medida` DISABLE KEYS */;
INSERT INTO `abasto_unidades_medida` VALUES (1,'Unidad de prueba',1),(2,'Unidad de prueba 2',1),(3,'Quintal',1),(4,'Kilos',1),(5,'janjanja',1),(6,'litros',1),(7,'Unidad',1),(8,'Libra',1),(9,'Caja',1),(10,'Caja (6)',1),(11,'Cubeta',1);
/*!40000 ALTER TABLE `abasto_unidades_medida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abasto_usuarios`
--

DROP TABLE IF EXISTS `abasto_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abasto_usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cedula` varchar(10) NOT NULL,
  `nombres` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `clave` varchar(128) NOT NULL,
  `idrol_id` int NOT NULL,
  `idEstado` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_rolUsuario_idx` (`idrol_id`),
  KEY `fk_estado_usuario` (`idEstado`),
  CONSTRAINT `fk_estado_usuario` FOREIGN KEY (`idEstado`) REFERENCES `abasto_estados` (`id`),
  CONSTRAINT `usuario_rolUsuario` FOREIGN KEY (`idrol_id`) REFERENCES `abasto_rol_usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abasto_usuarios`
--

LOCK TABLES `abasto_usuarios` WRITE;
/*!40000 ALTER TABLE `abasto_usuarios` DISABLE KEYS */;
INSERT INTO `abasto_usuarios` VALUES (1,'0919389692','Jorge Luis','Charco Aguirre','123',1,1),(2,'0916583850','Alicia','Cordova','567',2,1),(3,'1207935097','Luis','Bedoya Jaime','pbkdf2_sha256$870000$bqV8Gfhv5966CARlqekWZi$zzPwejZOtjSS4htIS57M/NfgIb/+JcC7uGpUpcrnRCY=',1,1),(11,'1201815410','Usuario ','De prueba','1201815410',2,1),(12,'11111111','Este es un Usuario','De Prueba','11111111',1,1);
/*!40000 ALTER TABLE `abasto_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add rol_usuario',7,'add_rol_usuario'),(26,'Can change rol_usuario',7,'change_rol_usuario'),(27,'Can delete rol_usuario',7,'delete_rol_usuario'),(28,'Can view rol_usuario',7,'view_rol_usuario'),(29,'Can add usuarios',8,'add_usuarios'),(30,'Can change usuarios',8,'change_usuarios'),(31,'Can delete usuarios',8,'delete_usuarios'),(32,'Can view usuarios',8,'view_usuarios');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `debug_log`
--

DROP TABLE IF EXISTS `debug_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debug_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mensaje` text,
  `creado` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=690 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debug_log`
--

LOCK TABLES `debug_log` WRITE;
/*!40000 ALTER TABLE `debug_log` DISABLE KEYS */;
INSERT INTO `debug_log` VALUES (1,'Transaccion: editar_stock_pedido','2025-09-05 19:25:05'),(2,'Id_Producto recibido: NULL','2025-09-05 19:25:05'),(3,'StockPedido recibido: NULL','2025-09-05 19:25:05'),(4,NULL,'2025-09-05 19:25:05'),(5,'Transaccion: editar_stock_pedido','2025-09-05 19:25:31'),(6,'Id_Producto recibido: NULL','2025-09-05 19:25:31'),(7,'StockPedido recibido: NULL','2025-09-05 19:25:31'),(8,NULL,'2025-09-05 19:25:31'),(9,'Filas afectadas: 0','2025-09-05 19:25:31'),(10,'JSON COMPLETO: {\"datos\": \"{\\\"Id_Producto\\\":33,\\\"StockPedido\\\":12,\\\"debug_info\\\":{\\\"cantidad_original\\\":12,\\\"necesita_conversion\\\":false,\\\"factor_conversion\\\":20,\\\"unidad_origen\\\":\\\"Caja\\\",\\\"unidad_destino\\\":\\\"Unidad\\\"}}\", \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 19:29:25'),(11,'Tiene Id_Producto: 0','2025-09-05 19:29:25'),(12,'Tiene StockPedido: 0','2025-09-05 19:29:25'),(13,'Keys del JSON: [\"datos\", \"Transaccion\"]','2025-09-05 19:29:25'),(14,'Filas afectadas: 0','2025-09-05 19:29:25'),(15,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 19:34:12'),(16,'Tiene Id_Producto: 1','2025-09-05 19:34:12'),(17,'Tiene StockPedido: 1','2025-09-05 19:34:12'),(18,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 19:34:12'),(19,'Filas afectadas: 1','2025-09-05 19:34:12'),(20,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 5, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 19:47:30'),(21,'Tiene Id_Producto: 1','2025-09-05 19:47:30'),(22,'Tiene StockPedido: 1','2025-09-05 19:47:30'),(23,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 19:47:30'),(24,'Filas afectadas: 1','2025-09-05 19:47:30'),(25,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 20:07:37'),(26,'Tiene Id_Producto: 1','2025-09-05 20:07:37'),(27,'Tiene StockPedido: 1','2025-09-05 20:07:37'),(28,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 20:07:37'),(29,'Filas afectadas: 1','2025-09-05 20:07:37'),(30,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 20:16:16'),(31,'Tiene Id_Producto: 1','2025-09-05 20:16:16'),(32,'Tiene StockPedido: 1','2025-09-05 20:16:16'),(33,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 20:16:16'),(34,'Filas afectadas: 1','2025-09-05 20:16:16'),(35,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 50, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 20:16:30'),(36,'Tiene Id_Producto: 1','2025-09-05 20:16:30'),(37,'Tiene StockPedido: 1','2025-09-05 20:16:30'),(38,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 20:16:30'),(39,'Filas afectadas: 1','2025-09-05 20:16:30'),(40,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 200, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 20:18:07'),(41,'Tiene Id_Producto: 1','2025-09-05 20:18:07'),(42,'Tiene StockPedido: 1','2025-09-05 20:18:07'),(43,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 20:18:07'),(44,'Filas afectadas: 1','2025-09-05 20:18:07'),(45,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 20:20:53'),(46,'Tiene Id_Producto: 1','2025-09-05 20:20:53'),(47,'Tiene StockPedido: 1','2025-09-05 20:20:53'),(48,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 20:20:53'),(49,'Filas afectadas: 1','2025-09-05 20:20:53'),(50,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 20:20:55'),(51,'Tiene Id_Producto: 1','2025-09-05 20:20:55'),(52,'Tiene StockPedido: 1','2025-09-05 20:20:55'),(53,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 20:20:55'),(54,'Filas afectadas: 1','2025-09-05 20:20:55'),(55,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": 24, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 20:29:01'),(56,'Tiene Id_Producto: 1','2025-09-05 20:29:01'),(57,'Tiene StockPedido: 1','2025-09-05 20:29:01'),(58,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 20:29:01'),(59,'Filas afectadas: 1','2025-09-05 20:29:01'),(60,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": 100, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 20:29:10'),(61,'Tiene Id_Producto: 1','2025-09-05 20:29:10'),(62,'Tiene StockPedido: 1','2025-09-05 20:29:10'),(63,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 20:29:10'),(64,'Filas afectadas: 1','2025-09-05 20:29:10'),(65,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": -24, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 20:29:27'),(66,'Tiene Id_Producto: 1','2025-09-05 20:29:27'),(67,'Tiene StockPedido: 1','2025-09-05 20:29:27'),(68,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 20:29:27'),(69,'Filas afectadas: 1','2025-09-05 20:29:27'),(70,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": -100, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 20:29:51'),(71,'Tiene Id_Producto: 1','2025-09-05 20:29:51'),(72,'Tiene StockPedido: 1','2025-09-05 20:29:51'),(73,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 20:29:51'),(74,'Filas afectadas: 1','2025-09-05 20:29:51'),(75,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": 25, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 20:34:27'),(76,'Tiene Id_Producto: 1','2025-09-05 20:34:27'),(77,'Tiene StockPedido: 1','2025-09-05 20:34:28'),(78,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 20:34:28'),(79,'Filas afectadas: 1','2025-09-05 20:34:28'),(80,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": 40, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 20:45:24'),(81,'Tiene Id_Producto: 1','2025-09-05 20:45:24'),(82,'Tiene StockPedido: 1','2025-09-05 20:45:24'),(83,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 20:45:24'),(84,'Filas afectadas: 1','2025-09-05 20:45:24'),(85,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": 150, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 21:06:31'),(86,'Tiene Id_Producto: 1','2025-09-05 21:06:31'),(87,'Tiene StockPedido: 1','2025-09-05 21:06:31'),(88,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 21:06:31'),(89,'Filas afectadas: 1','2025-09-05 21:06:31'),(90,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": -150, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 21:06:43'),(91,'Tiene Id_Producto: 1','2025-09-05 21:06:43'),(92,'Tiene StockPedido: 1','2025-09-05 21:06:43'),(93,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 21:06:43'),(94,'Filas afectadas: 1','2025-09-05 21:06:43'),(95,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 22:09:42'),(96,'Tiene Id_Producto: 1','2025-09-05 22:09:42'),(97,'Tiene StockPedido: 1','2025-09-05 22:09:42'),(98,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 22:09:42'),(99,'Filas afectadas: 1','2025-09-05 22:09:42'),(100,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 22:11:58'),(101,'Tiene Id_Producto: 1','2025-09-05 22:11:58'),(102,'Tiene StockPedido: 1','2025-09-05 22:11:58'),(103,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 22:11:58'),(104,'Filas afectadas: 1','2025-09-05 22:11:58'),(105,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 2, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 22:13:23'),(106,'Tiene Id_Producto: 1','2025-09-05 22:13:23'),(107,'Tiene StockPedido: 1','2025-09-05 22:13:23'),(108,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 22:13:23'),(109,'Filas afectadas: 1','2025-09-05 22:13:23'),(110,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 22:13:55'),(111,'Tiene Id_Producto: 1','2025-09-05 22:13:55'),(112,'Tiene StockPedido: 1','2025-09-05 22:13:55'),(113,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 22:13:55'),(114,'Filas afectadas: 1','2025-09-05 22:13:55'),(115,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": 40, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 22:14:08'),(116,'Tiene Id_Producto: 1','2025-09-05 22:14:08'),(117,'Tiene StockPedido: 1','2025-09-05 22:14:08'),(118,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 22:14:08'),(119,'Filas afectadas: 1','2025-09-05 22:14:08'),(120,'JSON COMPLETO: {\"Id_Producto\": 1, \"StockPedido\": 12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 22:14:38'),(121,'Tiene Id_Producto: 1','2025-09-05 22:14:38'),(122,'Tiene StockPedido: 1','2025-09-05 22:14:38'),(123,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 22:14:38'),(124,'Filas afectadas: 1','2025-09-05 22:14:38'),(125,'JSON COMPLETO: {\"Id_Producto\": 1, \"StockPedido\": -12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 22:14:59'),(126,'Tiene Id_Producto: 1','2025-09-05 22:14:59'),(127,'Tiene StockPedido: 1','2025-09-05 22:14:59'),(128,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 22:14:59'),(129,'Filas afectadas: 1','2025-09-05 22:14:59'),(130,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": -40, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 22:14:59'),(131,'Tiene Id_Producto: 1','2025-09-05 22:14:59'),(132,'Tiene StockPedido: 1','2025-09-05 22:14:59'),(133,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 22:14:59'),(134,'Filas afectadas: 1','2025-09-05 22:14:59'),(135,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-05 22:15:00'),(136,'Tiene Id_Producto: 1','2025-09-05 22:15:00'),(137,'Tiene StockPedido: 1','2025-09-05 22:15:00'),(138,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-05 22:15:00'),(139,'Filas afectadas: 1','2025-09-05 22:15:00'),(140,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 200, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:23:26'),(141,'Tiene Id_Producto: 1','2025-09-08 15:23:26'),(142,'Tiene StockPedido: 1','2025-09-08 15:23:26'),(143,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:23:26'),(144,'Filas afectadas: 1','2025-09-08 15:23:26'),(145,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": 60, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:24:49'),(146,'Tiene Id_Producto: 1','2025-09-08 15:24:49'),(147,'Tiene StockPedido: 1','2025-09-08 15:24:49'),(148,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:24:49'),(149,'Filas afectadas: 1','2025-09-08 15:24:49'),(150,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:28:07'),(151,'Tiene Id_Producto: 1','2025-09-08 15:28:07'),(152,'Tiene StockPedido: 1','2025-09-08 15:28:07'),(153,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:28:07'),(154,'Filas afectadas: 1','2025-09-08 15:28:07'),(155,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:28:34'),(156,'Tiene Id_Producto: 1','2025-09-08 15:28:34'),(157,'Tiene StockPedido: 1','2025-09-08 15:28:34'),(158,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:28:34'),(159,'Filas afectadas: 1','2025-09-08 15:28:34'),(160,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:29:05'),(161,'Tiene Id_Producto: 1','2025-09-08 15:29:05'),(162,'Tiene StockPedido: 1','2025-09-08 15:29:05'),(163,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:29:05'),(164,'Filas afectadas: 1','2025-09-08 15:29:05'),(165,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:29:15'),(166,'Tiene Id_Producto: 1','2025-09-08 15:29:15'),(167,'Tiene StockPedido: 1','2025-09-08 15:29:15'),(168,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:29:15'),(169,'Filas afectadas: 1','2025-09-08 15:29:15'),(170,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 200, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:29:22'),(171,'Tiene Id_Producto: 1','2025-09-08 15:29:22'),(172,'Tiene StockPedido: 1','2025-09-08 15:29:22'),(173,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:29:22'),(174,'Filas afectadas: 1','2025-09-08 15:29:22'),(175,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -200, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:29:24'),(176,'Tiene Id_Producto: 1','2025-09-08 15:29:24'),(177,'Tiene StockPedido: 1','2025-09-08 15:29:24'),(178,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:29:24'),(179,'Filas afectadas: 1','2025-09-08 15:29:24'),(180,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 200, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:29:41'),(181,'Tiene Id_Producto: 1','2025-09-08 15:29:41'),(182,'Tiene StockPedido: 1','2025-09-08 15:29:41'),(183,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:29:41'),(184,'Filas afectadas: 1','2025-09-08 15:29:41'),(185,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -200, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:30:28'),(186,'Tiene Id_Producto: 1','2025-09-08 15:30:28'),(187,'Tiene StockPedido: 1','2025-09-08 15:30:28'),(188,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:30:28'),(189,'Filas afectadas: 1','2025-09-08 15:30:28'),(190,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 200, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:30:38'),(191,'Tiene Id_Producto: 1','2025-09-08 15:30:38'),(192,'Tiene StockPedido: 1','2025-09-08 15:30:38'),(193,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:30:38'),(194,'Filas afectadas: 1','2025-09-08 15:30:38'),(195,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 2, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:33:20'),(196,'Tiene Id_Producto: 1','2025-09-08 15:33:20'),(197,'Tiene StockPedido: 1','2025-09-08 15:33:20'),(198,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:33:20'),(199,'Filas afectadas: 1','2025-09-08 15:33:20'),(200,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": 20, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:33:27'),(201,'Tiene Id_Producto: 1','2025-09-08 15:33:27'),(202,'Tiene StockPedido: 1','2025-09-08 15:33:27'),(203,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:33:27'),(204,'Filas afectadas: 1','2025-09-08 15:33:27'),(205,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": -20, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:41:07'),(206,'Tiene Id_Producto: 1','2025-09-08 15:41:07'),(207,'Tiene StockPedido: 1','2025-09-08 15:41:07'),(208,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:41:07'),(209,'Filas afectadas: 1','2025-09-08 15:41:07'),(210,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -2, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:41:08'),(211,'Tiene Id_Producto: 1','2025-09-08 15:41:08'),(212,'Tiene StockPedido: 1','2025-09-08 15:41:08'),(213,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:41:08'),(214,'Filas afectadas: 1','2025-09-08 15:41:08'),(215,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:54:20'),(216,'Tiene Id_Producto: 1','2025-09-08 15:54:20'),(217,'Tiene StockPedido: 1','2025-09-08 15:54:20'),(218,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:54:20'),(219,'Filas afectadas: 1','2025-09-08 15:54:20'),(220,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": 30, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:54:36'),(221,'Tiene Id_Producto: 1','2025-09-08 15:54:36'),(222,'Tiene StockPedido: 1','2025-09-08 15:54:36'),(223,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:54:36'),(224,'Filas afectadas: 1','2025-09-08 15:54:36'),(225,'JSON COMPLETO: {\"Id_Producto\": 34, \"Transaccion\": \"editar_stock_pedido\", \"stockPedido\": -12}','2025-09-08 15:54:38'),(226,'Tiene Id_Producto: 1','2025-09-08 15:54:38'),(227,'Tiene StockPedido: 0','2025-09-08 15:54:38'),(228,'Keys del JSON: [\"Id_Producto\", \"Transaccion\", \"stockPedido\"]','2025-09-08 15:54:38'),(229,'Filas afectadas: 1','2025-09-08 15:54:38'),(230,'JSON COMPLETO: {\"Id_Producto\": 4, \"Transaccion\": \"editar_stock_pedido\", \"stockPedido\": -30}','2025-09-08 15:54:38'),(231,'Tiene Id_Producto: 1','2025-09-08 15:54:38'),(232,'Tiene StockPedido: 0','2025-09-08 15:54:38'),(233,'Keys del JSON: [\"Id_Producto\", \"Transaccion\", \"stockPedido\"]','2025-09-08 15:54:38'),(234,'Filas afectadas: 1','2025-09-08 15:54:38'),(235,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:55:35'),(236,'Tiene Id_Producto: 1','2025-09-08 15:55:35'),(237,'Tiene StockPedido: 1','2025-09-08 15:55:35'),(238,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:55:35'),(239,'Filas afectadas: 1','2025-09-08 15:55:35'),(240,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:56:36'),(241,'Tiene Id_Producto: 1','2025-09-08 15:56:36'),(242,'Tiene StockPedido: 1','2025-09-08 15:56:36'),(243,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:56:36'),(244,'Filas afectadas: 1','2025-09-08 15:56:36'),(245,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 1, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:56:44'),(246,'Tiene Id_Producto: 1','2025-09-08 15:56:44'),(247,'Tiene StockPedido: 1','2025-09-08 15:56:44'),(248,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:56:44'),(249,'Filas afectadas: 1','2025-09-08 15:56:44'),(250,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -1, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 15:57:03'),(251,'Tiene Id_Producto: 1','2025-09-08 15:57:03'),(252,'Tiene StockPedido: 1','2025-09-08 15:57:03'),(253,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 15:57:03'),(254,'Filas afectadas: 1','2025-09-08 15:57:03'),(255,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 200, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 16:02:35'),(256,'Tiene Id_Producto: 1','2025-09-08 16:02:35'),(257,'Tiene StockPedido: 1','2025-09-08 16:02:35'),(258,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 16:02:35'),(259,'Filas afectadas: 1','2025-09-08 16:02:35'),(260,'JSON COMPLETO: {\"Id_Producto\": 34, \"Transaccion\": \"editar_stock_pedido\", \"stockPedido\": -200}','2025-09-08 16:04:20'),(261,'Tiene Id_Producto: 1','2025-09-08 16:04:20'),(262,'Tiene StockPedido: 0','2025-09-08 16:04:20'),(263,'Keys del JSON: [\"Id_Producto\", \"Transaccion\", \"stockPedido\"]','2025-09-08 16:04:20'),(264,'Filas afectadas: 1','2025-09-08 16:04:20'),(265,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 16:09:19'),(266,'Tiene Id_Producto: 1','2025-09-08 16:09:19'),(267,'Tiene StockPedido: 1','2025-09-08 16:09:20'),(268,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 16:09:20'),(269,'Filas afectadas: 1','2025-09-08 16:09:20'),(270,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": 30, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 16:09:27'),(271,'Tiene Id_Producto: 1','2025-09-08 16:09:27'),(272,'Tiene StockPedido: 1','2025-09-08 16:09:27'),(273,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 16:09:27'),(274,'Filas afectadas: 1','2025-09-08 16:09:27'),(275,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 16:09:29'),(276,'Tiene Id_Producto: 1','2025-09-08 16:09:29'),(277,'Tiene StockPedido: 1','2025-09-08 16:09:29'),(278,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 16:09:29'),(279,'Filas afectadas: 1','2025-09-08 16:09:29'),(280,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": 30, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 16:09:29'),(281,'Tiene Id_Producto: 1','2025-09-08 16:09:29'),(282,'Tiene StockPedido: 1','2025-09-08 16:09:29'),(283,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 16:09:29'),(284,'Filas afectadas: 1','2025-09-08 16:09:29'),(285,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 16:36:42'),(286,'Tiene Id_Producto: 1','2025-09-08 16:36:42'),(287,'Tiene StockPedido: 1','2025-09-08 16:36:42'),(288,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 16:36:42'),(289,'Filas afectadas: 1','2025-09-08 16:36:42'),(290,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 16:36:59'),(291,'Tiene Id_Producto: 1','2025-09-08 16:36:59'),(292,'Tiene StockPedido: 1','2025-09-08 16:36:59'),(293,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 16:36:59'),(294,'Filas afectadas: 1','2025-09-08 16:36:59'),(295,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:08:03'),(296,'Tiene Id_Producto: 1','2025-09-08 17:08:03'),(297,'Tiene StockPedido: 1','2025-09-08 17:08:03'),(298,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:08:03'),(299,'Filas afectadas: 1','2025-09-08 17:08:03'),(300,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:08:09'),(301,'Tiene Id_Producto: 1','2025-09-08 17:08:09'),(302,'Tiene StockPedido: 1','2025-09-08 17:08:09'),(303,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:08:09'),(304,'Filas afectadas: 1','2025-09-08 17:08:09'),(305,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:08:17'),(306,'Tiene Id_Producto: 1','2025-09-08 17:08:17'),(307,'Tiene StockPedido: 1','2025-09-08 17:08:17'),(308,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:08:17'),(309,'Filas afectadas: 1','2025-09-08 17:08:17'),(310,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": 60, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:08:30'),(311,'Tiene Id_Producto: 1','2025-09-08 17:08:30'),(312,'Tiene StockPedido: 1','2025-09-08 17:08:30'),(313,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:08:30'),(314,'Filas afectadas: 1','2025-09-08 17:08:30'),(315,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:08:39'),(316,'Tiene Id_Producto: 1','2025-09-08 17:08:39'),(317,'Tiene StockPedido: 1','2025-09-08 17:08:39'),(318,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:08:39'),(319,'Filas afectadas: 1','2025-09-08 17:08:39'),(320,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": -60, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:08:39'),(321,'Tiene Id_Producto: 1','2025-09-08 17:08:39'),(322,'Tiene StockPedido: 1','2025-09-08 17:08:39'),(323,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:08:39'),(324,'Filas afectadas: 1','2025-09-08 17:08:39'),(325,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": 40, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:09:05'),(326,'Tiene Id_Producto: 1','2025-09-08 17:09:05'),(327,'Tiene StockPedido: 1','2025-09-08 17:09:05'),(328,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:09:05'),(329,'Filas afectadas: 1','2025-09-08 17:09:05'),(330,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": -40, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:10:44'),(331,'Tiene Id_Producto: 1','2025-09-08 17:10:44'),(332,'Tiene StockPedido: 1','2025-09-08 17:10:44'),(333,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:10:44'),(334,'Filas afectadas: 1','2025-09-08 17:10:44'),(335,'JSON COMPLETO: {\"Id_Producto\": 1, \"StockPedido\": 12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:11:06'),(336,'Tiene Id_Producto: 1','2025-09-08 17:11:06'),(337,'Tiene StockPedido: 1','2025-09-08 17:11:06'),(338,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:11:06'),(339,'Filas afectadas: 1','2025-09-08 17:11:06'),(340,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 20, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:11:22'),(341,'Tiene Id_Producto: 1','2025-09-08 17:11:22'),(342,'Tiene StockPedido: 1','2025-09-08 17:11:22'),(343,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:11:22'),(344,'Filas afectadas: 1','2025-09-08 17:11:22'),(345,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -20, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:11:31'),(346,'Tiene Id_Producto: 1','2025-09-08 17:11:31'),(347,'Tiene StockPedido: 1','2025-09-08 17:11:31'),(348,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:11:31'),(349,'Filas afectadas: 1','2025-09-08 17:11:31'),(350,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 20, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:11:39'),(351,'Tiene Id_Producto: 1','2025-09-08 17:11:39'),(352,'Tiene StockPedido: 1','2025-09-08 17:11:39'),(353,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:11:39'),(354,'Filas afectadas: 1','2025-09-08 17:11:39'),(355,'JSON COMPLETO: {\"Id_Producto\": 1, \"StockPedido\": -12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:11:44'),(356,'Tiene Id_Producto: 1','2025-09-08 17:11:44'),(357,'Tiene StockPedido: 1','2025-09-08 17:11:44'),(358,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:11:44'),(359,'Filas afectadas: 1','2025-09-08 17:11:44'),(360,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -20, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:11:44'),(361,'Tiene Id_Producto: 1','2025-09-08 17:11:44'),(362,'Tiene StockPedido: 1','2025-09-08 17:11:44'),(363,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:11:44'),(364,'Filas afectadas: 1','2025-09-08 17:11:44'),(365,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 20, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:13:49'),(366,'Tiene Id_Producto: 1','2025-09-08 17:13:49'),(367,'Tiene StockPedido: 1','2025-09-08 17:13:49'),(368,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:13:49'),(369,'Filas afectadas: 1','2025-09-08 17:13:49'),(370,'JSON COMPLETO: {\"Id_Producto\": 1, \"StockPedido\": 6, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:13:56'),(371,'Tiene Id_Producto: 1','2025-09-08 17:13:56'),(372,'Tiene StockPedido: 1','2025-09-08 17:13:56'),(373,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:13:56'),(374,'Filas afectadas: 1','2025-09-08 17:13:56'),(375,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": 30, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:14:04'),(376,'Tiene Id_Producto: 1','2025-09-08 17:14:04'),(377,'Tiene StockPedido: 1','2025-09-08 17:14:04'),(378,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:14:04'),(379,'Filas afectadas: 1','2025-09-08 17:14:04'),(380,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -20, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:16:46'),(381,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -20, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:16:46'),(382,'Tiene Id_Producto: 1','2025-09-08 17:16:46'),(383,'Tiene Id_Producto: 1','2025-09-08 17:16:46'),(384,'Tiene StockPedido: 1','2025-09-08 17:16:46'),(385,'Tiene StockPedido: 1','2025-09-08 17:16:46'),(386,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:16:46'),(387,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:16:46'),(388,'Filas afectadas: 1','2025-09-08 17:16:46'),(389,'Filas afectadas: 1','2025-09-08 17:16:46'),(390,'JSON COMPLETO: {\"Id_Producto\": 1, \"StockPedido\": -6, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:16:46'),(391,'JSON COMPLETO: {\"Id_Producto\": 1, \"StockPedido\": -6, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:16:46'),(392,'Tiene Id_Producto: 1','2025-09-08 17:16:46'),(393,'Tiene Id_Producto: 1','2025-09-08 17:16:46'),(394,'Tiene StockPedido: 1','2025-09-08 17:16:46'),(395,'Tiene StockPedido: 1','2025-09-08 17:16:46'),(396,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:16:46'),(397,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:16:46'),(398,'Filas afectadas: 1','2025-09-08 17:16:46'),(399,'Filas afectadas: 1','2025-09-08 17:16:46'),(400,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": -30, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:16:46'),(401,'Tiene Id_Producto: 1','2025-09-08 17:16:46'),(402,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": -30, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:16:46'),(403,'Tiene StockPedido: 1','2025-09-08 17:16:46'),(404,'Tiene Id_Producto: 1','2025-09-08 17:16:46'),(405,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:16:46'),(406,'Tiene StockPedido: 1','2025-09-08 17:16:46'),(407,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:16:46'),(408,'Filas afectadas: 1','2025-09-08 17:16:46'),(409,'Filas afectadas: 1','2025-09-08 17:16:46'),(410,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:18:15'),(411,'Tiene Id_Producto: 1','2025-09-08 17:18:15'),(412,'Tiene StockPedido: 1','2025-09-08 17:18:15'),(413,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:18:15'),(414,'Filas afectadas: 1','2025-09-08 17:18:15'),(415,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:18:22'),(416,'Tiene Id_Producto: 1','2025-09-08 17:18:22'),(417,'Tiene StockPedido: 1','2025-09-08 17:18:22'),(418,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:18:22'),(419,'Filas afectadas: 1','2025-09-08 17:18:22'),(420,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:21:14'),(421,'Tiene Id_Producto: 1','2025-09-08 17:21:14'),(422,'Tiene StockPedido: 1','2025-09-08 17:21:14'),(423,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:21:14'),(424,'Filas afectadas: 1','2025-09-08 17:21:14'),(425,'JSON COMPLETO: {\"Id_Producto\": 1, \"StockPedido\": 60, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 17:21:23'),(426,'Tiene Id_Producto: 1','2025-09-08 17:21:23'),(427,'Tiene StockPedido: 1','2025-09-08 17:21:23'),(428,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 17:21:23'),(429,'Filas afectadas: 1','2025-09-08 17:21:23'),(430,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 19:21:02'),(431,'Tiene Id_Producto: 1','2025-09-08 19:21:02'),(432,'Tiene StockPedido: 1','2025-09-08 19:21:02'),(433,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 19:21:02'),(434,'Filas afectadas: 1','2025-09-08 19:21:02'),(435,'JSON COMPLETO: {\"Id_Producto\": 1, \"StockPedido\": -60, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 19:21:02'),(436,'Tiene Id_Producto: 1','2025-09-08 19:21:02'),(437,'Tiene StockPedido: 1','2025-09-08 19:21:02'),(438,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 19:21:02'),(439,'Filas afectadas: 1','2025-09-08 19:21:02'),(440,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 19:39:45'),(441,'Tiene Id_Producto: 1','2025-09-08 19:39:45'),(442,'Tiene StockPedido: 1','2025-09-08 19:39:45'),(443,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 19:39:45'),(444,'Filas afectadas: 1','2025-09-08 19:39:45'),(445,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": 90, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 19:39:52'),(446,'Tiene Id_Producto: 1','2025-09-08 19:39:52'),(447,'Tiene StockPedido: 1','2025-09-08 19:39:52'),(448,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 19:39:52'),(449,'Filas afectadas: 1','2025-09-08 19:39:52'),(450,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": -90, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 20:38:31'),(451,'Tiene Id_Producto: 1','2025-09-08 20:38:31'),(452,'Tiene StockPedido: 1','2025-09-08 20:38:31'),(453,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 20:38:31'),(454,'Filas afectadas: 1','2025-09-08 20:38:31'),(455,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 20:38:35'),(456,'Tiene Id_Producto: 1','2025-09-08 20:38:35'),(457,'Tiene StockPedido: 1','2025-09-08 20:38:35'),(458,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 20:38:35'),(459,'Filas afectadas: 1','2025-09-08 20:38:35'),(460,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-08 20:38:46'),(461,'Tiene Id_Producto: 1','2025-09-08 20:38:46'),(462,'Tiene StockPedido: 1','2025-09-08 20:38:46'),(463,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-08 20:38:46'),(464,'Filas afectadas: 1','2025-09-08 20:38:46'),(465,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:06:10'),(466,'Tiene Id_Producto: 1','2025-09-10 14:06:10'),(467,'Tiene StockPedido: 1','2025-09-10 14:06:10'),(468,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:06:10'),(469,'Filas afectadas: 1','2025-09-10 14:06:10'),(470,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": 60, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:06:19'),(471,'Tiene Id_Producto: 1','2025-09-10 14:06:19'),(472,'Tiene StockPedido: 1','2025-09-10 14:06:19'),(473,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:06:19'),(474,'Filas afectadas: 1','2025-09-10 14:06:19'),(475,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:41:34'),(476,'Tiene Id_Producto: 1','2025-09-10 14:41:34'),(477,'Tiene StockPedido: 1','2025-09-10 14:41:34'),(478,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:41:34'),(479,'Filas afectadas: 1','2025-09-10 14:41:34'),(480,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": 30, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:41:42'),(481,'Tiene Id_Producto: 1','2025-09-10 14:41:42'),(482,'Tiene StockPedido: 1','2025-09-10 14:41:42'),(483,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:41:42'),(484,'Filas afectadas: 1','2025-09-10 14:41:42'),(485,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:42:05'),(486,'Tiene Id_Producto: 1','2025-09-10 14:42:05'),(487,'Tiene StockPedido: 1','2025-09-10 14:42:05'),(488,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:42:05'),(489,'Filas afectadas: 1','2025-09-10 14:42:05'),(490,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": -30, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:42:05'),(491,'Tiene Id_Producto: 1','2025-09-10 14:42:05'),(492,'Tiene StockPedido: 1','2025-09-10 14:42:05'),(493,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:42:05'),(494,'Filas afectadas: 1','2025-09-10 14:42:05'),(495,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:43:27'),(496,'Tiene Id_Producto: 1','2025-09-10 14:43:27'),(497,'Tiene StockPedido: 1','2025-09-10 14:43:27'),(498,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:43:27'),(499,'Filas afectadas: 1','2025-09-10 14:43:27'),(500,'JSON COMPLETO: {\"Id_Producto\": 4, \"StockPedido\": 60, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:43:38'),(501,'Tiene Id_Producto: 1','2025-09-10 14:43:38'),(502,'Tiene StockPedido: 1','2025-09-10 14:43:38'),(503,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:43:38'),(504,'Filas afectadas: 1','2025-09-10 14:43:38'),(505,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": 40, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:53:02'),(506,'Tiene Id_Producto: 1','2025-09-10 14:53:02'),(507,'Tiene StockPedido: 1','2025-09-10 14:53:02'),(508,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:53:02'),(509,'Filas afectadas: 1','2025-09-10 14:53:02'),(510,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 2, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:53:07'),(511,'Tiene Id_Producto: 1','2025-09-10 14:53:07'),(512,'Tiene StockPedido: 1','2025-09-10 14:53:07'),(513,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:53:07'),(514,'Filas afectadas: 1','2025-09-10 14:53:07'),(515,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -2, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:56:08'),(516,'Tiene Id_Producto: 1','2025-09-10 14:56:08'),(517,'Tiene StockPedido: 1','2025-09-10 14:56:08'),(518,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:56:08'),(519,'Filas afectadas: 1','2025-09-10 14:56:08'),(520,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": -40, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:56:08'),(521,'Tiene Id_Producto: 1','2025-09-10 14:56:08'),(522,'Tiene StockPedido: 1','2025-09-10 14:56:08'),(523,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:56:08'),(524,'Filas afectadas: 1','2025-09-10 14:56:08'),(525,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 3, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:56:52'),(526,'Tiene Id_Producto: 1','2025-09-10 14:56:52'),(527,'Tiene StockPedido: 1','2025-09-10 14:56:52'),(528,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:56:52'),(529,'Filas afectadas: 1','2025-09-10 14:56:52'),(530,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -3, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:58:36'),(531,'Tiene Id_Producto: 1','2025-09-10 14:58:36'),(532,'Tiene StockPedido: 1','2025-09-10 14:58:36'),(533,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:58:36'),(534,'Filas afectadas: 1','2025-09-10 14:58:36'),(535,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:58:50'),(536,'Tiene Id_Producto: 1','2025-09-10 14:58:50'),(537,'Tiene StockPedido: 1','2025-09-10 14:58:50'),(538,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:58:50'),(539,'Filas afectadas: 1','2025-09-10 14:58:50'),(540,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": 40, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 14:58:56'),(541,'Tiene Id_Producto: 1','2025-09-10 14:58:56'),(542,'Tiene StockPedido: 1','2025-09-10 14:58:56'),(543,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 14:58:56'),(544,'Filas afectadas: 1','2025-09-10 14:58:56'),(545,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": -40, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:06:05'),(546,'Tiene Id_Producto: 1','2025-09-10 15:06:05'),(547,'Tiene StockPedido: 1','2025-09-10 15:06:05'),(548,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:06:05'),(549,'Filas afectadas: 1','2025-09-10 15:06:05'),(550,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:06:06'),(551,'Tiene Id_Producto: 1','2025-09-10 15:06:06'),(552,'Tiene StockPedido: 1','2025-09-10 15:06:06'),(553,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:06:06'),(554,'Filas afectadas: 1','2025-09-10 15:06:06'),(555,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 20, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:06:38'),(556,'Tiene Id_Producto: 1','2025-09-10 15:06:38'),(557,'Tiene StockPedido: 1','2025-09-10 15:06:38'),(558,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:06:38'),(559,'Filas afectadas: 1','2025-09-10 15:06:38'),(560,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": 60, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:06:49'),(561,'Tiene Id_Producto: 1','2025-09-10 15:06:49'),(562,'Tiene StockPedido: 1','2025-09-10 15:06:49'),(563,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:06:49'),(564,'Filas afectadas: 1','2025-09-10 15:06:49'),(565,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -20, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:10:53'),(566,'Tiene Id_Producto: 1','2025-09-10 15:10:53'),(567,'Tiene StockPedido: 1','2025-09-10 15:10:53'),(568,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:10:53'),(569,'Filas afectadas: 1','2025-09-10 15:10:53'),(570,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": -60, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:10:53'),(571,'Tiene Id_Producto: 1','2025-09-10 15:10:53'),(572,'Tiene StockPedido: 1','2025-09-10 15:10:53'),(573,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:10:53'),(574,'Filas afectadas: 1','2025-09-10 15:10:53'),(575,'JSON COMPLETO: {\"Id_Producto\": 1, \"StockPedido\": 12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:14:50'),(576,'Tiene Id_Producto: 1','2025-09-10 15:14:50'),(577,'Tiene StockPedido: 1','2025-09-10 15:14:50'),(578,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:14:50'),(579,'Filas afectadas: 1','2025-09-10 15:14:50'),(580,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 25, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:15:09'),(581,'Tiene Id_Producto: 1','2025-09-10 15:15:09'),(582,'Tiene StockPedido: 1','2025-09-10 15:15:09'),(583,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:15:09'),(584,'Filas afectadas: 1','2025-09-10 15:15:09'),(585,'JSON COMPLETO: {\"Id_Producto\": 1, \"StockPedido\": -12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:16:41'),(586,'Tiene Id_Producto: 1','2025-09-10 15:16:41'),(587,'Tiene StockPedido: 1','2025-09-10 15:16:41'),(588,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:16:41'),(589,'Filas afectadas: 1','2025-09-10 15:16:41'),(590,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -25, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:16:41'),(591,'Tiene Id_Producto: 1','2025-09-10 15:16:41'),(592,'Tiene StockPedido: 1','2025-09-10 15:16:41'),(593,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:16:41'),(594,'Filas afectadas: 1','2025-09-10 15:16:41'),(595,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:19:26'),(596,'Tiene Id_Producto: 1','2025-09-10 15:19:26'),(597,'Tiene StockPedido: 1','2025-09-10 15:19:26'),(598,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:19:26'),(599,'Filas afectadas: 1','2025-09-10 15:19:26'),(600,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:20:27'),(601,'Tiene Id_Producto: 1','2025-09-10 15:20:27'),(602,'Tiene StockPedido: 1','2025-09-10 15:20:27'),(603,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:20:27'),(604,'Filas afectadas: 1','2025-09-10 15:20:27'),(605,'JSON COMPLETO: {\"Id_Producto\": 1, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:20:35'),(606,'Tiene Id_Producto: 1','2025-09-10 15:20:35'),(607,'Tiene StockPedido: 1','2025-09-10 15:20:35'),(608,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:20:35'),(609,'Filas afectadas: 1','2025-09-10 15:20:35'),(610,'JSON COMPLETO: {\"Id_Producto\": 1, \"StockPedido\": -10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:20:42'),(611,'Tiene Id_Producto: 1','2025-09-10 15:20:42'),(612,'Tiene StockPedido: 1','2025-09-10 15:20:42'),(613,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:20:42'),(614,'Filas afectadas: 1','2025-09-10 15:20:42'),(615,'JSON COMPLETO: {\"Id_Producto\": 1, \"StockPedido\": 60, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:20:45'),(616,'Tiene Id_Producto: 1','2025-09-10 15:20:45'),(617,'Tiene StockPedido: 1','2025-09-10 15:20:45'),(618,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:20:45'),(619,'Filas afectadas: 1','2025-09-10 15:20:45'),(620,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:37:53'),(621,'Tiene Id_Producto: 1','2025-09-10 15:37:53'),(622,'Tiene StockPedido: 1','2025-09-10 15:37:53'),(623,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:37:53'),(624,'Filas afectadas: 1','2025-09-10 15:37:53'),(625,'JSON COMPLETO: {\"Id_Producto\": 1, \"StockPedido\": 12, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:39:19'),(626,'Tiene Id_Producto: 1','2025-09-10 15:39:19'),(627,'Tiene StockPedido: 1','2025-09-10 15:39:19'),(628,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:39:19'),(629,'Filas afectadas: 1','2025-09-10 15:39:19'),(630,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:56:12'),(631,'Tiene Id_Producto: 1','2025-09-10 15:56:12'),(632,'Tiene StockPedido: 1','2025-09-10 15:56:12'),(633,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:56:12'),(634,'Filas afectadas: 1','2025-09-10 15:56:12'),(635,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": 40, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:56:19'),(636,'Tiene Id_Producto: 1','2025-09-10 15:56:19'),(637,'Tiene StockPedido: 1','2025-09-10 15:56:19'),(638,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:56:19'),(639,'Filas afectadas: 1','2025-09-10 15:56:19'),(640,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -10, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:59:19'),(641,'Tiene Id_Producto: 1','2025-09-10 15:59:19'),(642,'Tiene StockPedido: 1','2025-09-10 15:59:19'),(643,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:59:19'),(644,'Filas afectadas: 1','2025-09-10 15:59:19'),(645,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": -40, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:59:19'),(646,'Tiene Id_Producto: 1','2025-09-10 15:59:19'),(647,'Tiene StockPedido: 1','2025-09-10 15:59:19'),(648,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:59:19'),(649,'Filas afectadas: 1','2025-09-10 15:59:19'),(650,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 25, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:59:42'),(651,'Tiene Id_Producto: 1','2025-09-10 15:59:42'),(652,'Tiene StockPedido: 1','2025-09-10 15:59:42'),(653,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:59:42'),(654,'Filas afectadas: 1','2025-09-10 15:59:42'),(655,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": 100, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 15:59:56'),(656,'Tiene Id_Producto: 1','2025-09-10 15:59:56'),(657,'Tiene StockPedido: 1','2025-09-10 15:59:56'),(658,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 15:59:56'),(659,'Filas afectadas: 1','2025-09-10 15:59:56'),(660,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -25, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 16:00:23'),(661,'Tiene Id_Producto: 1','2025-09-10 16:00:23'),(662,'Tiene StockPedido: 1','2025-09-10 16:00:23'),(663,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 16:00:23'),(664,'Filas afectadas: 1','2025-09-10 16:00:23'),(665,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": -100, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 16:00:23'),(666,'Tiene Id_Producto: 1','2025-09-10 16:00:23'),(667,'Tiene StockPedido: 1','2025-09-10 16:00:23'),(668,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 16:00:23'),(669,'Filas afectadas: 1','2025-09-10 16:00:23'),(670,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": 25, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 16:00:46'),(671,'Tiene Id_Producto: 1','2025-09-10 16:00:46'),(672,'Tiene StockPedido: 1','2025-09-10 16:00:46'),(673,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 16:00:46'),(674,'Filas afectadas: 1','2025-09-10 16:00:46'),(675,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": 40, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 16:00:56'),(676,'Tiene Id_Producto: 1','2025-09-10 16:00:56'),(677,'Tiene StockPedido: 1','2025-09-10 16:00:56'),(678,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 16:00:56'),(679,'Filas afectadas: 1','2025-09-10 16:00:56'),(680,'JSON COMPLETO: {\"Id_Producto\": 33, \"StockPedido\": -40, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 16:03:25'),(681,'Tiene Id_Producto: 1','2025-09-10 16:03:25'),(682,'Tiene StockPedido: 1','2025-09-10 16:03:25'),(683,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 16:03:25'),(684,'Filas afectadas: 1','2025-09-10 16:03:25'),(685,'JSON COMPLETO: {\"Id_Producto\": 34, \"StockPedido\": -25, \"Transaccion\": \"editar_stock_pedido\"}','2025-09-10 16:03:26'),(686,'Tiene Id_Producto: 1','2025-09-10 16:03:26'),(687,'Tiene StockPedido: 1','2025-09-10 16:03:26'),(688,'Keys del JSON: [\"Id_Producto\", \"StockPedido\", \"Transaccion\"]','2025-09-10 16:03:26'),(689,'Filas afectadas: 1','2025-09-10 16:03:26');
/*!40000 ALTER TABLE `debug_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (7,'abasto','rol_usuario'),(8,'abasto','usuarios'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-12-24 00:42:25.556226'),(2,'auth','0001_initial','2024-12-24 00:42:29.486063'),(3,'admin','0001_initial','2024-12-24 00:42:30.080295'),(4,'admin','0002_logentry_remove_auto_add','2024-12-24 00:42:30.089473'),(5,'admin','0003_logentry_add_action_flag_choices','2024-12-24 00:42:30.124603'),(6,'contenttypes','0002_remove_content_type_name','2024-12-24 00:42:30.490238'),(7,'auth','0002_alter_permission_name_max_length','2024-12-24 00:42:30.692470'),(8,'auth','0003_alter_user_email_max_length','2024-12-24 00:42:30.725171'),(9,'auth','0004_alter_user_username_opts','2024-12-24 00:42:30.741871'),(10,'auth','0005_alter_user_last_login_null','2024-12-24 00:42:30.929924'),(11,'auth','0006_require_contenttypes_0002','2024-12-24 00:42:30.936040'),(12,'auth','0007_alter_validators_add_error_messages','2024-12-24 00:42:30.951150'),(13,'auth','0008_alter_user_username_max_length','2024-12-24 00:42:31.184167'),(14,'auth','0009_alter_user_last_name_max_length','2024-12-24 00:42:31.411185'),(15,'auth','0010_alter_group_name_max_length','2024-12-24 00:42:31.443445'),(16,'auth','0011_update_proxy_permissions','2024-12-24 00:42:31.462451'),(17,'auth','0012_alter_user_first_name_max_length','2024-12-24 00:42:31.682933'),(18,'sessions','0001_initial','2024-12-24 00:42:31.835048'),(19,'abasto','0001_initial','2025-03-14 17:45:58.030220');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'abastodb'
--

--
-- Dumping routines for database 'abastodb'
--
/*!50003 DROP PROCEDURE IF EXISTS `GetCategorias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCategorias`(IN transaccion VARCHAR(50))
BEGIN
	IF transaccion = 'consulta_general' THEN
		SELECT ac.id Id_Categoria, 
			   ac.nombre Nombre_Categoria
		FROM abasto_categorias ac
		ORDER BY ac.id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCliente`(IN codigoIdentificacion VARCHAR(20), IN codTipoId CHAR, IN transaccion VARCHAR(50))
BEGIN
	IF transaccion = 'consultar_cliente' THEN
		SELECT abc.codIdentificacion AS IdentificacionCliente,
			   abc.codTipoId         AS CodTipoIdentificacion,
			   abc.nombres           AS NombresCliente,
			   abc.apellidos         AS ApellidosCliente,
			   abc.telefono          AS TelefonoCliente,
			   abc.email             AS EmailCliente
		FROM abasto_clientes abc
		WHERE abc.codIdentificacion = codigoIdentificacion
		 AND abc.codTipoId = codTipoId;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetDetallePedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDetallePedido`(
    IN idPedido INT, 
    IN transaccion VARCHAR(50)
)
BEGIN
    IF transaccion = 'consulta_detalle_pedido' THEN
        SELECT 
            adp.id AS IdDetallePedido,
            adp.IdProducto,
            adp.CodigoProducto,
            adp.NombreProducto,
            adp.Marca,
            adp.CantidadSeleccionada AS Cantidad,
            adp.PrecioUnitario,
            adp.UnidadMedida AS ModoVenta,
            adp.IdUnidad AS IdUnidadMedida,
            adp.IdPrecioVenta,
            adp.ImpuestoProducto,
            adp.PorcentajeIva,
            adp.SubTotal AS SubTotalProducto,
            adp.Iva AS IvaProducto,
            adp.Total,
            adp.NecesitaConversion,
            adp.FactorConversion,
            adp.IdConversionVenta
        FROM abasto_detalle_pedido adp
        WHERE adp.IdPedido = idPedido
		  AND adp.idEstado = 4;
    END IF;
    
    IF transaccion = 'consulta_detalle_pedido_cancelado' THEN
        SELECT 
            adp.id AS IdDetallePedido,
            adp.IdProducto,
            adp.CodigoProducto,
            adp.NombreProducto,
            adp.Marca,
            adp.CantidadSeleccionada AS Cantidad,
            adp.PrecioUnitario,
            adp.UnidadMedida AS ModoVenta,
            adp.IdUnidad AS IdUnidadMedida,
            adp.IdPrecioVenta,
            adp.ImpuestoProducto,
            adp.PorcentajeIva,
            adp.SubTotal AS SubTotalProducto,
            adp.Iva AS IvaProducto,
            adp.Total,
            adp.NecesitaConversion,
            adp.FactorConversion,
            adp.IdConversionVenta
        FROM abasto_detalle_pedido adp
        WHERE adp.IdPedido = idPedido
		  AND adp.idEstado = 3;
    END IF;
    
    IF transaccion = 'consulta_general' THEN
        SELECT 
            adp.id AS IdDetallePedido,
            abp.nombre AS Producto,
            CONCAT(adp.cantidadSeleccionada, ' ', aum.nombre) AS Cantidad,
            adp.subTotal AS SubTotalProducto,
            adp.iva AS IvaProducto
        FROM abasto_detalle_pedido adp
        INNER JOIN abasto_productos abp ON (abp.id = adp.idProducto)
        INNER JOIN abasto_unidades_medida aum ON (adp.IdUnidad = aum.id);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetEstados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEstados`(IN transaccion VARCHAR(50))
BEGIN
	IF transaccion = 'consulta_general' THEN
		SELECT ae.id IdEstado,
			   ae.nombre NombreEstado
		FROM abasto_estados ae
		WHERE ae.id not in (3)
		ORDER BY ae.id;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetIva` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetIva`(IN idIva INT, IN transaccion varchar(50))
BEGIN
	IF transaccion = 'consulta_general' THEN
      SELECT ai.id AS IdIva,
             ai.descripcion AS DescripcionIva,
             ai.porcentaje  AS PorcentajeIva
      FROM abasto_iva ai;
	END IF;
    
    IF transaccion = 'consulta_iva' THEN
      SELECT ai.id AS IdIva,
             ai.descripcion AS DescripcionIva,
             ai.porcentaje  AS PorcentajeIva
      FROM abasto_iva ai
	  WHERE ai.id = idIva;
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetMarca` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMarca`(IN transaccion VARCHAR(50))
BEGIN
    IF transaccion = 'consulta_general' THEN
        SELECT am.id IdMarca,
               am.nombre NombreMarca,
               ae.nombre EstadoMarca
               FROM abasto_marca am
                   INNER JOIN abasto_estados ae ON (am.id_estado = ae.id)
               WHERE am.id NOT IN (3)
               ORDER BY am.id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetMedidasConversion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMedidasConversion`(IN datos JSON, IN transaccion VARCHAR(50))
BEGIN
DECLARE idMedidaT INT;
    IF transaccion = 'consulta_general' THEN
        SELECT amc.id                Id_Medida,
               amc.idUnidadPrincipal Id_Unidad_Principal,
               aum1.nombre            Nombre_Medida_Principal,
               amc.idUnidadConvertir Id_Medida_Convertir,
               aum2.nombre            Nombre_Medida_Convertir,
               amc.factorConversion  Factor_Conversion,
               abe.nombre            Estado_Medida
        FROM abasto_medidas_conversion amc
                 INNER JOIN abasto_unidades_medida aum1
                            on (amc.idUnidadPrincipal = aum1.id)
				INNER JOIN abasto_unidades_medida aum2
                            on (amc.idUnidadConvertir = aum2.id)
				INNER JOIN abasto_estados abe 
                           on (amc.idEstado = abe.id)
		WHERE amc.idEstado not in (3)
        ORDER BY aum1.id, aum2.id;
    END IF;
    IF transaccion = 'obtener_medida_especifica' THEN
        SET idMedidaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Id_Medida'));
        SELECT amc.id                Id_Medida,
               amc.idUnidadPrincipal Id_Unidad_Principal,
               aum1.nombre            Nombre_Medida_Principal,
               amc.idUnidadConvertir Id_Medida_Convertir,
               aum2.nombre            Nombre_Medida_Convertir,
               amc.factorConversion  Factor_Conversion,
               abe.nombre            Estado_Medida
        FROM abasto_medidas_conversion amc
                 INNER JOIN abasto_unidades_medida aum1
                            on (amc.idUnidadPrincipal = aum1.id)
				INNER JOIN abasto_unidades_medida aum2
                            on (amc.idUnidadConvertir = aum2.id)
				INNER JOIN abasto_estados abe 
							on (amc.idEstado = abe.id)
		WHERE amc.id = idMedidaT
        ORDER BY aum1.id, aum2.id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPedido`(IN transaccion varchar(50))
BEGIN
	IF transaccion = 'consultar_pedidos_pendientes' THEN
		SELECT abp.id        AS IdPedido,
			   abp.codigo    AS CodigoPedido,
			   abp.idCliente AS ClientePedido,
			   abp.subTotal  AS SubTotalPedido,
			   abp.IVA       AS IvaPedido,
			   abp.total     AS TotalPedido,
               abp.idEstado  AS IdEstado,
			   abe.nombre    AS EstadoPedido,
               DATE_FORMAT(abp.fechaCreacion, '%d/%m/%Y %H:%i:%s') AS FechaPedido
		 FROM abasto_pedidos abp
			INNER JOIN abasto_estados abe ON (abp.idEstado = abe.id)
		 WHERE abp.idEstado = 4
         ORDER BY abp.id, abp.codigo;
    END IF;
    
    IF transaccion = 'consultar_pedidos_general' THEN
		SELECT abp.id        AS IdPedido,
			   abp.codigo    AS CodigoPedido,
			   abp.idCliente AS ClientePedido,
			   abp.subTotal  AS SubTotalPedido,
			   abp.IVA       AS IvaPedido,
			   abp.total     AS TotalPedido,
               abp.idEstado  AS IdEstado,
			   abe.nombre    AS EstadoPedido,
                DATE_FORMAT(abp.fechaCreacion, '%d/%m/%Y %H:%i:%s') AS FechaPedido
		 FROM abasto_pedidos abp
			INNER JOIN abasto_estados abe ON (abp.idEstado = abe.id)
         ORDER BY abp.id, abp.codigo;
    END IF;
    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPrecio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPrecio`(IN idProducto INT, IN transaccion VARCHAR(50))
BEGIN
    IF transaccion = 'consulta_general' THEN
        SELECT apv.idproducto,
       apv.idunidadmedida,
       apv.precioventa
        FROM abasto_precios_venta apv
         INNER JOIN abastodb.abasto_unidades_medida aum on (apv.idUnidadMedida = aum.id);
    END IF;
    
    IF transaccion = 'consulta_precio_venta' THEN
        SELECT apv.id                IdPrecio,
               apv.idProducto     AS IdProducto,
               apv.idUnidadMedida AS IdUnidadMedida,
               aum.nombre            UnidadMedida,
               apv.precioVenta    as PrecioVenta
        FROM abasto_precios_venta apv
                 INNER JOIN abasto_unidades_medida aum ON (apv.idUnidadMedida = aum.id)
        WHERE apv.idProducto = idProducto
        AND apv.idEstado NOT IN (3);
        
        IF ROW_COUNT() = 0 THEN
			SELECT 'No se encontraron precios de venta' AS mensaje;
		END IF;
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProducto`(IN datos JSON, IN transaccion VARCHAR(50))
BEGIN
	DECLARE idproductoT INT;
    IF transaccion = 'obtener_productos' THEN
				SELECT ab.id Id_Producto,
			   ab.codigoProducto Codigo_Producto,
               ab.nombre Nombre_Producto,
			   ab.idMarca Id_Marca,
			   am.nombre Nombre_Marca,
			   ab.idProveedor Id_Proveedor,
			   ab.stock Stock,
			   ab.stockMaximo Stock_Maximo,
			   ab.stockMinimo Stock_Minimo,
			   ab.porcentajeGanancia Porcentaje_Ganancia,
			   ap.nombre Nombre_Proveedor,
			   ab.precioCompra AS Precio_Compra,
			   ac.id Id_Categoria,
			   ac.nombre Categoria,
			   ae.id AS IdEstado,
               ab.impuestoProducto Impuesto_Producto,
               ab.ventaGranel Venta_Granel,
               ab.esPerecible Es_Perecible,
               ab.FechaVencimiento Fecha_Vencimiento,
			   ae.nombre Estado,
               ab.idUnidadConversionVenta AS IdUnidadConversionVenta,
               ab.stockPedido AS StockPedido,
               aum.nombre    AS UnidadVenta
				FROM abasto_productos ab
				inner join abasto_categorias ac on ab.idCategoria = ac.id
				inner join abasto_estados ae on ab.idEstado = ae.id
				inner join abasto_marca am on ab.idMarca = am.id
				inner join abasto_proveedor ap on ab.idProveedor = ap.id
                inner join abasto_medidas_conversion amc on amc.id = ab.idUnidadConversionVenta
                inner join abasto_unidades_medida aum on aum.id = amc.idUnidadConvertir
				WHERE ab.idEstado not in (3)
                ORDER BY ab.codigoProducto;
	END IF;
    IF transaccion = 'obtener_producto_especifico' THEN
		 SET idproductoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdProducto'));
         SELECT ab.id Id_Producto,
			   ab.codigoProducto Codigo_Producto,
               ab.nombre Nombre_Producto,
			   ab.idMarca Id_Marca,
			   am.nombre Nombre_Marca,
			   ab.idProveedor Id_Proveedor,
			   ab.stock Stock,
			   ab.stockMaximo Stock_Maximo,
			   ab.stockMinimo Stock_Minimo,
			   ab.porcentajeGanancia Porcentaje_Ganancia,
			   ap.nombre Nombre_Proveedor,
			   ab.precioCompra AS Precio_Compra,
			   ac.id Id_Categoria,
			   ac.nombre Categoria,
			   ae.id AS IdEstado,
               ab.impuestoProducto Impuesto_Producto,
               ab.ventaGranel Venta_Granel,
               ab.esPerecible Es_Perecible,
               ab.FechaVencimiento Fecha_Vencimiento,
			   ae.nombre Estado,
               ab.idUnidadConversionVenta AS IdUnidadConversionVenta,
               ab.stockPedido AS StockPedido,
               aum.nombre    AS UnidadVenta
				FROM abasto_productos ab
				inner join abasto_categorias ac on ab.idCategoria = ac.id
				inner join abasto_estados ae on ab.idEstado = ae.id
				inner join abasto_marca am on ab.idMarca = am.id
				inner join abasto_proveedor ap on ab.idProveedor = ap.id
                inner join abasto_medidas_conversion amc on amc.id = ab.idUnidadConversionVenta
                inner join abasto_unidades_medida aum on aum.id = amc.idUnidadConvertir
        WHERE ab.id = idproductoT;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProveedor`(IN transaccion VARCHAR(50))
BEGIN
    IF transaccion = 'consulta_general' THEN
        SELECT ap.id IdProveedor,
               ap.ruc RucProveedor,
               ap.nombre NombreProveedor,
               ap.telefono TelefonoProveedor,
               ae.nombre EstadoProveedor
        FROM abasto_proveedor ap
            INNER JOIN abasto_estados ae ON (ap.idEstado = ae.id)
                 WHERE ap.idEstado NOT IN (3)
                 ORDER by ap.id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetReportes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetReportes`(IN datos JSON, IN transaccion VARCHAR(50))
BEGIN
	DECLARE fechaInicio DATE;
    DECLARE fechaFin DATE;
    
    -- Reporte: Ventas por rango de fechas
    IF transaccion = 'ventas_por_fecha' THEN
		SET fechaInicio = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.FechaInicio'));
        SET fechaFin = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.FechaFin'));
        
			SELECT DATE(cf.fechaEmision) AS Fecha,
				   SUM(cf.total)         AS TotalVendido,
                   COUNT(cf.id)          AS NumeroFacturas
            FROM 
				abasto_cabecera_factura AS cf
            WHERE 
				DATE(cf.fechaEmision) BETWEEN fechaInicio AND fechaFin
            GROUP BY
				DATE(cf.fechaEmision)
			ORDER BY
				fecha ASC;
    END IF;
    
    IF transaccion = 'top_productos_vendidos' THEN
		SET fechaInicio = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.FechaInicio'));
        SET fechaFin = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.FechaFin'));
        
			SELECT df.nombreProducto as NombreProducto,
				   SUM(df.cantidadSeleccionada) AS UnidadesVendidas,
				   SUM(df.total) AS IngresosGenerados
			FROM
				abasto_detalle_factura AS df
			INNER JOIN
				abasto_cabecera_factura AS cf ON df.idFactura = cf.id
			WHERE
				DATE(cf.fechaEmision) BETWEEN fechaInicio AND fechaFin
			GROUP BY
				df.nombreProducto
			ORDER BY
				IngresosGenerados DESC
			LIMIT 5;
    END IF;
    
    IF transaccion = 'productos_bajo_stock' THEN
		SELECT p.codigoProducto AS CodigoProducto,
			   p.nombre AS NombreProducto,
               p.stock AS StockActual,
               p.stockMinimo AS StockMinimo,
               prov.nombre AS Proveedor,
               prov.telefono AS TelefonoProveedor
		FROM abasto_productos AS p
        LEFT JOIN abasto_proveedor AS prov ON p.idProveedor = prov.id
        WHERE p.stock <= p.stockMinimo
        AND p.idEstado = 1;
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetRol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetRol`(IN transaccion VARCHAR(50))
BEGIN
    IF transaccion = 'consulta_general' THEN
        SELECT abr.id          as IdRol,
               abr.descripcion as NombreRol
        FROM abasto_rol_usuarios abr
        ORDER BY abr.id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetStockProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStockProducto`(IN datos json, IN transaccion varchar(50))
BEGIN
DECLARE idProductoT INT;
	IF transaccion = 'consulta_stock_producto' THEN
     SET idProductoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Id_Producto'));
		SELECT abs.id                                              Id_Stock,
			   abs.idProducto                                      Id_Producto,
			   abs.cantidadStock                                   Cantidad_Stock,
			   DATE_FORMAT(abs.fechaIngreso, '%d/%m/%Y %H:%i:%s')  Fecha_Ingreso
		FROM abasto_stock abs
		WHERE abs.idProducto = idProductoT;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUnidadMedida` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUnidadMedida`(IN transaccion VARCHAR(50))
BEGIN
    IF transaccion = 'consulta_general' THEN
        SELECT au.id IdUnidad,
               au.nombre NombreUnidad,
               ae.nombre EstadoUnidad
               FROM abasto_unidades_medida au
                   INNER JOIN abasto_estados ae ON (au.idEstado = ae.id)
               WHERE au.idEstado NOT IN (3)
               ORDER BY au.id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUsuario`(IN datos JSON, IN transaccion VARCHAR(50))
BEGIN
    DECLARE cedulaT VARCHAR(10);
    DECLARE claveT VARCHAR(100);

    IF transaccion = 'login' THEN
        SET cedulaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Cedula'));
        -- SET claveT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Password'));

        SELECT ab.id, 
			  ab.cedula, 
              ab.nombres, 
              ab.apellidos, 
              ab.clave, 
              ab.idrol_id AS idrol, 
              ab.idEstado
        FROM abasto_usuarios ab
        WHERE ab.cedula = cedulaT;
          -- AND ab.clave = claveT;
    END IF;
    
    IF transaccion = 'consulta_general' THEN
		SELECT ab.id, 
			   ab.cedula, 
               ab.nombres, 
               ab.apellidos, 
               ab.clave,
               ar.descripcion as rol,
               ab.idrol_id as idrol, 
               ab.idEstado,
               ae.nombre as estado
        FROM abasto_usuarios ab
        INNER JOIN abasto_rol_usuarios ar ON (ab.idrol_id = ar.id)
        INNER JOIN abasto_estados ae ON (ab.idEstado = ae.id)
        WHERE ab.idEstado not in (3);
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetCategoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetCategoria`(IN datos JSON, IN transaccion VARCHAR(50))
BEGIN
	DECLARE nombreT VARCHAR(100);
    DECLARE descripcionT VARCHAR(100);
    
    -- Extraer datos del JSON
    SET nombreT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Nombre'));
    SET descripcionT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Descripcion'));
    
    IF transaccion = 'agregar_categoria' THEN
		INSERT INTO abasto_categorias (Nombre, Descripcion, IdEstado)
        VALUES (nombreT, descripcionT,1);
	END IF;
    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetCliente`(IN datos JSON, IN transaccion VARCHAR(50))
BEGIN
	DECLARE codIdentificacionT VARCHAR(20);
    DECLARE codTipoIdT CHAR(1);
    DECLARE nombresClienteT VARCHAR(150);
    DECLARE apellidosClienteT VARCHAR(150);
    DECLARE telefonoClienteT VARCHAR(10);
    DECLARE emailClienteT VARCHAR(100);
    DECLARE cliente_existe INT DEFAULT 0;
	
    IF transaccion = 'registrar_cliente' THEN
		SET codIdentificacionT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.CodigoIdentificacion'));
        SET codTipoIdT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.CodigoTipoId'));
        SET nombresClienteT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.NombresCliente'));
        SET apellidosClienteT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.ApellidosCliente'));
        SET telefonoClienteT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.TelefonoCliente'));
        SET emailClienteT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.EmailCliente'));
        
        INSERT INTO abasto_clientes(codIdentificacion, codTipoId, nombres, apellidos, telefono, email)
        VALUES (codIdentificacionT, codTipoIdT, nombresClienteT, apellidosClienteT, telefonoClienteT, emailClienteT);
        
        SELECT 'Cliente registrado correctamente' as mensaje;
    END IF;
    
    IF transaccion = 'actualizar_cliente' THEN
		-- Extraer datos del JSON
		SET codIdentificacionT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.CodigoIdentificacion'));
        SET codTipoIdT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.CodigoTipoId'));
        SET telefonoClienteT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.TelefonoCliente'));
        SET emailClienteT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.EmailCliente'));
        
        -- DEBUG: Mostrar valores extraídos
        SELECT 
            codIdentificacionT as debug_codigo,
            codTipoIdT as debug_tipo,
            telefonoClienteT as debug_telefono,
            emailClienteT as debug_email;
        
        -- Verificar si el cliente existe
        SELECT COUNT(*) INTO cliente_existe 
        FROM abasto_clientes 
        WHERE codIdentificacion = codIdentificacionT 
        AND codTipoId = codTipoIdT;
        
        SELECT cliente_existe as debug_cliente_existe;
        
        IF cliente_existe > 0 THEN
            -- Actualizar cliente
            UPDATE abasto_clientes
            SET telefono = telefonoClienteT,
                email = emailClienteT
            WHERE codIdentificacion = codIdentificacionT
            AND codTipoId = codTipoIdT;
            
            -- Verificar filas afectadas
            SELECT ROW_COUNT() as debug_filas_afectadas;
            SELECT 'Cliente actualizado correctamente' as mensaje;
        ELSE
            SELECT 'Error: Cliente no encontrado' as mensaje;
        END IF;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetDetalleFactura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetDetalleFactura`(IN datos JSON, IN transaccion VARCHAR(50))
BEGIN
	DECLARE codigoFacturaT VARCHAR(25);
    DECLARE idFacturaT     INT;
    DECLARE idProductoT   INT;
    DECLARE codigoProductoT VARCHAR(50);
    DECLARE nombreProductoT VARCHAR(255);
    DECLARE marcaT VARCHAR(100);
    DECLARE unidadMedidaT VARCHAR(50);
    DECLARE cantidadT     DECIMAL(10,2);
    DECLARE precioUnitarioT DECIMAL(10,2);
    DECLARE subTotalT     DECIMAL(10,2);
    DECLARE ivaT          DECIMAL(10,2);
    DECLARE totalT DECIMAL(10,2);
    DECLARE impuestoProductoT CHAR(1);
    DECLARE porcentajeIvaT DECIMAL(5,2);
    
    -- Extraer valor del JSON
    SET codigoFacturaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.CodigoFactura'));
    SET idFacturaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdFactura'));
    SET idProductoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdProducto'));
    SET codigoProductoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.CodigoProducto'));
    SET nombreProductoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.NombreProducto'));
    SET marcaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Marca'));
    SET unidadMedidaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.UnidadMedida'));
    SET cantidadT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.CantidadSeleccionada'));
    SET precioUnitarioT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.PrecioUnitario'));
    SET subTotalT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.SubTotal'));
    SET ivaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IVA'));
    SET totalT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Total'));
    SET impuestoProductoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.ImpuestoProducto'));
    SET porcentajeIvaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.PorcentajeIva'));
    
    IF transaccion = 'agregar_detalle_factura' THEN
		INSERT INTO abasto_detalle_factura(
			CodigoFactura,
            IdFactura,
            IdProducto,
            CodigoProducto,        
            NombreProducto,       
            Marca,   
            UnidadMedida,
            CantidadSeleccionada,
            PrecioUnitario,
            SubTotal, 
            Iva,
            Total,
            ImpuestoProducto,      
            PorcentajeIva,
            IdEstado
        ) VALUES (
			codigoFacturaT,
            idFacturaT,
            idProductoT,
            codigoProductoT,       
            nombreProductoT,       
            marcaT,
            unidadMedidaT,
            cantidadT,
            precioUnitarioT,
            subTotalT,
            ivaT,
            totalT,
            impuestoProductoT,     
            porcentajeIvaT,
            7
        );
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetDetallePedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetDetallePedido`(
    IN datos JSON, 
    IN transaccion VARCHAR(50)
)
BEGIN
    DECLARE codigoPedidoT VARCHAR(25);
    DECLARE idPedidoT     INT;
    DECLARE idProductoT   INT;
    DECLARE subTotalT     DECIMAL(10,2);
    DECLARE ivaT          DECIMAL(10,2);
    DECLARE cantidadT     DECIMAL(10,2);
    DECLARE idUnidadT     INT;
    
    DECLARE codigoProductoT VARCHAR(50);
    DECLARE nombreProductoT VARCHAR(255);
    DECLARE marcaT VARCHAR(100);
    DECLARE precioUnitarioT DECIMAL(10,2);
    DECLARE unidadMedidaT VARCHAR(50);
    DECLARE idPrecioVentaT INT;
    DECLARE impuestoProductoT CHAR(1);
    DECLARE porcentajeIvaT DECIMAL(5,2);
    DECLARE totalT DECIMAL(10,2);
    DECLARE necesitaConversionT CHAR(1);
    DECLARE factorConversionT DECIMAL(10,4);
    DECLARE idConversionVentaT INT;
    DECLARE idItemT INT;
    
    -- Extraer valores del JSON
    SET codigoPedidoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.CodigoPedido'));
    SET idPedidoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdPedido'));
    SET idProductoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdProducto'));
    SET subTotalT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.SubTotal'));
    SET ivaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IVA'));
    SET cantidadT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.CantidadSeleccionada'));
    SET idUnidadT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdUnidad'));
    
    -- Extraer NUEVOS campos del JSON
    SET codigoProductoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.CodigoProducto'));
    SET nombreProductoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.NombreProducto'));
    SET marcaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Marca'));
    SET precioUnitarioT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.PrecioUnitario'));
    SET unidadMedidaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.UnidadMedida'));
    SET idPrecioVentaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdPrecioVenta'));
    SET impuestoProductoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.ImpuestoProducto'));
    SET porcentajeIvaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.PorcentajeIva'));
    SET totalT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Total'));
    SET necesitaConversionT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.NecesitaConversion'));
    SET factorConversionT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.FactorConversion'));
    SET idConversionVentaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdConversionVenta'));
    
    IF transaccion = 'agregar_detalle_pedido' THEN
        INSERT INTO abasto_detalle_pedido(
            CodigoPedido, 
            IdPedido, 
            IdProducto,
            CodigoProducto,        
            NombreProducto,       
            Marca,                
            SubTotal, 
            Iva, 
            CantidadSeleccionada, 
            IdUnidad,
            PrecioUnitario,        
            UnidadMedida,          
            IdPrecioVenta,         
            ImpuestoProducto,      
            PorcentajeIva,        
            Total,                
            NecesitaConversion,    
            FactorConversion,      
            IdConversionVenta,     
            IdEstado
        ) VALUES (
            codigoPedidoT,
            idPedidoT,
            idProductoT,
            codigoProductoT,       
            nombreProductoT,       
            marcaT,                
            subTotalT,
            ivaT,
            cantidadT,
            idUnidadT,
            precioUnitarioT,       
            unidadMedidaT,         
            idPrecioVentaT,        
            impuestoProductoT,     
            porcentajeIvaT,        
            totalT,                
            necesitaConversionT,   
            factorConversionT,     
            idConversionVentaT,    
            4
        );
    END IF;
    
    IF transaccion = 'eliminar_producto_detalle' THEN
		SET idItemT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdItem'));
        UPDATE abasto_detalle_pedido
			SET idEstado = 3
		WHERE id = idItemT
         AND idProducto = idProductoT
         AND idPedido = idPedidoT;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetFactura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetFactura`(IN datos JSON, IN transaccion VARCHAR(50))
BEGIN
    DECLARE codigoFactura VARCHAR(25);
    DECLARE tipoIdClienteT CHAR;
    DECLARE idClienteT VARCHAR(45);
    DECLARE idPedidoT INT;
    DECLARE nombreClienteT VARCHAR(150);
    DECLARE apellidoClienteT VARCHAR(150);
    DECLARE telefonoClienteT VARCHAR(10);
    DECLARE emailClienteT VARCHAR(100);
    DECLARE subTotalFacturaT DECIMAL(10,2);
    DECLARE ivaFacturaT DECIMAL(10,2);
    DECLARE totalFacturaT DECIMAL(10,2);
    DECLARE fechaActual VARCHAR(8);
    DECLARE nuevoId INT;
    DECLARE consecutivoDia INT;
    
    -- Extraer los datos del JSON
    SET tipoIdClienteT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.TipoIdCliente'));
    SET idClienteT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdCliente'));
    SET idPedidoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdPedido'));
    SET nombreClienteT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.NombreCliente'));
    SET apellidoClienteT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.ApellidoCliente'));
    SET telefonoClienteT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.TelefonoCliente'));
    SET emailClienteT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.EmailCliente'));
    SET subTotalFacturaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.SubTotal'));
    SET ivaFacturaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IVA'));
    SET totalFacturaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.TotalFactura'));
    
    -- Obtener la fecha actual en formato YYYYMMDD
    SET fechaActual = DATE_FORMAT(NOW(), '%Y%m%d');
    
    IF transaccion = 'generar_factura' THEN
        INSERT INTO abasto_cabecera_factura(
            CodigoFactura, TipoIdCliente, IdCliente, IdPedido, NombreCliente,
            ApellidoCliente, FechaEmision, TelefonoCliente, EmailCliente, 
            SubTotal, IVA, Total, IdEstado
        )
        VALUES(
            'TEMP', tipoIdClienteT, idClienteT, idPedidoT, nombreClienteT, 
            apellidoClienteT, NOW(), telefonoClienteT, emailClienteT,
            subTotalFacturaT, ivaFacturaT, totalFacturaT, 7
        );
        
        -- Obtener el ID insertado
        SET nuevoId = LAST_INSERT_ID();
        
        -- OPCION 2: Usar conteo de facturas del dia + ID
        SELECT COUNT(*) + 1 INTO consecutivoDia
        FROM abasto_cabecera_factura 
        WHERE DATE(FechaEmision) = CURDATE()
        AND id < nuevoId;  -- Excluir la factura actual
        
        -- Generar codigo basado en consecutivo del dia
        SET codigoFactura = CONCAT('FACT-', fechaActual, '-', LPAD(consecutivoDia, 4, '0'));
        
        -- Actualizar la factura con el codigo real
        UPDATE abasto_cabecera_factura 
        SET CodigoFactura = codigoFactura
        WHERE id = nuevoId;
        
        -- Devolver el codigo e ID generados
        SELECT
            nuevoId AS IdFactura,
            codigoFactura AS CodigoFactura;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetIva` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetIva`(IN datos json, IN transaccion varchar(50))
BEGIN
	DECLARE descripcionT VARCHAR(45);
    DECLARE porcentajeT DECIMAL(5,2);
    DECLARE idIvaT INT;
    
    -- Extraer los valores del JSON
     SET descripcionT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.DescripcionIva'));
	 SET porcentajeT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.PorcentajeIva'));
     
     IF transaccion = 'agregar_iva' THEN
		INSERT INTO abasto_iva(Descripcion,Porcentaje)
        VALUES (descripcionT, porcentajeT);
     END IF;
    
    IF transaccion = 'editar_iva' THEN
	 SET idIvaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdIva'));
		UPDATE abasto_iva
          SET porcentaje = porcentajeT
		WHERE id = idIvaT;
     END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetMarca` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetMarca`(IN datos JSON, IN transaccion VARCHAR(50))
BEGIN
    DECLARE nombreT VARCHAR(100);
    DECLARE descripcionT VARCHAR(100);

    -- Extraer los datos del JSON
    SET nombreT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Nombre'));

    IF transaccion = 'agregar_marca' THEN
        INSERT INTO abasto_marca(Nombre, Id_Estado)
            VALUES(nombreT, 1);
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetMedidaConversion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetMedidaConversion`(IN datos JSON, IN transaccion VARCHAR(50))
BEGIN
    DECLARE idMedida INT;
    DECLARE idUnidadPrincipalT INT;
    DECLARE idUnidadConvertirT INT;
    DECLARE factorConversionT  INT;

    -- Extraer datos del JSON
    SET idUnidadPrincipalT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Id_Unidad_Principal'));
    SET idUnidadConvertirT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Id_Unidad_Convertir'));
    SET factorConversionT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Factor_Conversion'));

    IF transaccion = 'agregar_medida_conversion' THEN
        INSERT INTO abasto_medidas_conversion(idUnidadPrincipal, idUnidadConvertir, factorConversion, idEstado)
            VALUES (idUnidadPrincipalT, idUnidadConvertirT, factorConversionT,1);
    END IF;
    
    IF transaccion = 'editar_medida_conversion' THEN
        SET idMedida = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Id_Medida'));
        UPDATE abasto_medidas_conversion
            SET idUnidadPrincipal = idUnidadPrincipalT,
                idUnidadConvertir = idUnidadConvertirT,
                factorConversion = factorConversionT
            WHERE id = idMedida;
    END IF;
    
    IF transaccion = 'eliminar_medida_conversion' THEN
        SET idMedida = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Id_Medida'));
        UPDATE abasto_medidas_conversion
            SET idEstado = 3
            WHERE id = idMedida;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetPedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetPedido`(IN datos json, IN transaccion varchar(50))
BEGIN
    DECLARE idClienteT VARCHAR(45);
    DECLARE subTotalT  DECIMAL(10,2);
    DECLARE ivaT       DECIMAL(10,2);
    DECLARE totalT     DECIMAL(10,2);
    DECLARE codigoPedido VARCHAR(25);
    DECLARE ultimoNumero INT DEFAULT 0;
    DECLARE fechaActual VARCHAR(8);
    DECLARE nuevoId INT;
    DECLARE maxCodigo VARCHAR(25);
    DECLARE idPedidoT INT;
    -- Extraer valores del JSON
    SET idClienteT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdCliente'));
    SET subTotalT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.SubTotal'));
    SET ivaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IVA'));
    SET totalT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Total'));
    
    -- Obtener fecha actual en formato YYYYMMDD
    SET fechaActual = DATE_FORMAT(NOW(), '%Y%m%d');
    
    -- Buscar el último código para esta fecha
    SELECT MAX(Codigo) INTO maxCodigo
    FROM abasto_pedidos 
    WHERE Codigo LIKE CONCAT('PED-', fechaActual, '-%');
    
    -- Si existe un código, extraer el número
    IF maxCodigo IS NOT NULL THEN
        -- Extraer la parte numérica después del último guión
        SET ultimoNumero = CAST(SUBSTRING_INDEX(maxCodigo, '-', -1) AS UNSIGNED);
    ELSE
        SET ultimoNumero = 0;
    END IF;
    
    -- Incrementar el número
    SET ultimoNumero = ultimoNumero + 1;
    
    -- Generar código del pedido
    SET codigoPedido = CONCAT('PED-', fechaActual, '-', LPAD(ultimoNumero, 4, '0'));
    
    IF transaccion = 'agregar_pedido' THEN
        INSERT INTO abasto_pedidos(Codigo, IdCliente, SubTotal, IVA, Total, IdEstado, FechaCreacion)
        VALUES(codigoPedido, idClienteT, subTotalT, ivaT, totalT, 4, NOW());
        
        -- Obtener el ID insertado
        SET nuevoId = LAST_INSERT_ID();
        
        -- Devolver el código e ID generados
        SELECT 
            nuevoId AS IdPedido,
            codigoPedido AS CodigoPedido;
    END IF;
    
    IF transaccion = 'editar_pedido' THEN
    SET idPedidoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdPedido'));
			UPDATE abasto_pedidos
				SET subTotal = subTotalT,
					IVA = ivaT,
					total = totalT
			WHERE id = idPedidoT;
    END IF;
    
    IF transaccion = 'cancelar_pedido' THEN
		SET idPedidoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdPedido'));
			UPDATE abasto_pedidos
				-- SET idEstado = 3,
                SET idEstado = 6,
					fechaActualizacion = NOW()
			WHERE id = idPedidoT;
    END IF;
    
    IF transaccion = 'facturar_pedido' THEN
		SET idPedidoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdPedido'));
			UPDATE abasto_pedidos
				-- SET idEstado = 3,
                SET idEstado = 7,
					fechaActualizacion = NOW()
			WHERE id = idPedidoT;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetPrecio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetPrecio`(IN datos JSON,IN transaccion VARCHAR(50))
BEGIN
    DECLARE idPrecioT   INT;
    DECLARE idProductoT INT;
    DECLARE idUnidadMedidaT INT;
    DECLARE precioVentaT DECIMAL(10,2);

    -- Extarer los valores del JSON
    SET idProductoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdProducto'));
    SET idUnidadMedidaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdUnidadMedida'));
    SET precioVentaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.PrecioVenta'));

    IF transaccion = 'agregar_precio_venta' THEN
        INSERT INTO abasto_precios_venta(IdProducto, IdUnidadMedida,PrecioVenta,IdEstado)
        VALUES (idProductoT, idUnidadMedidaT, precioVentaT,1);
    END IF;
    
    IF transaccion = 'editar_precio_venta' THEN
		SET idPrecioT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdPrecio'));
        UPDATE abasto_precios_venta
			SET
				IdUnidadMedida = idUnidadMedidaT,
                PrecioVenta = precioVentaT
		WHERE id = idPrecioT;
    END IF;
    
    IF transaccion = 'eliminar_precio_venta' THEN
		SET idPrecioT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdPrecio'));
        UPDATE abasto_precios_venta
			SET
				IdEstado = 3
		WHERE id = idPrecioT;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetProducto`(IN datos JSON, IN transaccion VARCHAR(50))
BEGIN
	DECLARE nombreT TEXT;
    DECLARE precioCompraT DECIMAL(10,2);
    DECLARE codigoProductoT TEXT;
    DECLARE idMarcaT INT;
    DECLARE idProveedorT INT;
    DECLARE stockT INT;
    DECLARE stockMaximoT INT;
    DECLARE stockMinimoT INT;
    DECLARE porcentajeGananciaT DECIMAL(10,2);
    DECLARE fechaVencimientoT DATE;
    DECLARE impuestoProductoT CHAR(1);
    DECLARE ventaGranelT CHAR(1);
    DECLARE idcategoriaT     INT;
    DECLARE idestadoT        INT;
    DECLARE idproductoT		 INT;
    DECLARE idUnidadConversionVenta INT;
    DECLARE esPerecibleT     CHAR(1);
    DECLARE stockPedidoT     DECIMAL(5,2);

	-- Extraer datos del JSON
    SET nombreT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Nombre'));
	SET precioCompraT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.PrecioCompra'));
	SET codigoProductoT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.CodigoProducto'));
	SET idMarcaT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.IdMarca'));
	SET idProveedorT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.IdProveedor'));
	SET stockT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Stock'));
	SET stockMaximoT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.StockMaximo'));
	SET stockMinimoT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.StockMinimo'));
	SET porcentajeGananciaT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.PorcentajeGanancia'));
	SET fechaVencimientoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.FechaVencimiento'));
	SET impuestoProductoT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.ImpuestoProducto'));
	SET ventaGranelT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.VentaGranel'));
	SET idcategoriaT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.IdCategoria'));
    SET idUnidadConversionVenta = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdUnidadConversionVenta'));
    SET esPerecibleT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Es_Perecible'));
    SET stockPedidoT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.StockPedido'));


    IF transaccion = 'agregar_producto' THEN
		
        IF JSON_UNQUOTE(JSON_EXTRACT(datos, '$.esPerecible')) = 'false' THEN
            SET fechaVencimientoT = NULL;
        END IF;
        
        INSERT INTO abasto_productos (CodigoProducto, Nombre, PrecioCompra , IdCategoria, IdMarca, Stock,
                                      StockMaximo, StockMinimo, IdProveedor, PorcentajeGanancia,ImpuestoProducto,
                                      VentaGranel,fechaVencimiento, esPerecible, IdUnidadConversionVenta, IdEstado)
        VALUES (codigoProductoT,nombreT,precioCompraT,idcategoriaT,
                idMarcaT,stockT,stockMaximoT,stockMinimoT,idProveedorT,
                porcentajeGananciaT,impuestoProductoT,ventaGranelT,fechaVencimientoT, esPerecibleT,
                idUnidadConversionVenta,1);
    END IF;

    IF transaccion = 'editar_producto' THEN
    SET idproductoT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Id_Producto'));
    SET idestadoT  = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Id_Estado'));
		UPDATE abasto_productos
			SET
                CodigoProducto = codigoProductoT,
				Nombre = nombreT,
				PrecioCompra = precioCompraT,
				IdCategoria = idcategoriaT,
                IdMarca = idMarcaT,
                Stock = stockT,
                StockMaximo = stockMaximoT,
                StockMinimo = stockMinimoT,
                IdProveedor = idProveedorT,
                PorcentajeGanancia = porcentajeGananciaT,
                ImpuestoProducto = impuestoProductoT,
                VentaGranel = ventaGranelT,
                FechaVencimiento = fechaVencimientoT,
                Esperecible = esPerecibleT,
                IdEstado = idestadoT,
                IdUnidadConversionVenta = idUnidadConversionVenta
		WHERE id = idproductoT;
    END IF;
    
    IF transaccion = 'editar_stock' THEN
    SET idproductoT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Id_Producto'));
		UPDATE abasto_productos
			SET
                Stock = Stock + stockT
		WHERE id = idproductoT;
    END IF;
    
    IF transaccion = 'editar_stock_pedido' THEN
    SET idproductoT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Id_Producto'));
		UPDATE abasto_productos
			SET
				stockPedido = stockPedido + stockPedidoT
			WHERE id = idproductoT;
    END IF;

    IF transaccion = 'eliminar_producto' THEN
    SET idproductoT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Id_Producto'));
		UPDATE abasto_productos
			SET
				IdEstado = 3
            WHERE id = idproductoT;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetProveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetProveedor`(IN datos JSON,IN transaccion VARCHAR(50))
BEGIN
    DECLARE nombreT TEXT;
    DECLARE rucT VARCHAR(13);
    DECLARE telefonoT TEXT;
    DECLARE direccionT TEXT;

    -- Extraer datos del JSON
    SET rucT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Ruc'));
    SET nombreT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Nombre'));
    SET telefonoT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Telefono'));
    SET direccionT = JSON_UNQUOTE(JSON_EXTRACT(datos,'$.Direccion'));

    IF transaccion = 'agregar_proveedor' THEN
        INSERT INTO abasto_proveedor(Nombre, Ruc, Direccion, Telefono, IdEstado)
            VALUES(nombreT,rucT,direccionT,telefonoT,1);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetStockProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetStockProducto`(IN datos json, IN transaccion varchar(50))
BEGIN
	DECLARE idProductoT  INT;
    DECLARE cantidadStockT DECIMAL(5,2);
    
    -- Extraer los datos del JSON
    SET idProductoT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdProducto'));
    SET cantidadStockT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.CantidadStock'));
    
    IF transaccion = 'agregar_stock_producto' THEN
		INSERT INTO abasto_stock(IdProducto, CantidadStock, FechaIngreso)
        VALUES (idProductoT, cantidadStockT, NOW());
        
        UPDATE abasto_productos
        SET Stock = Stock + cantidadStockT
        WHERE id = idProductoT;
        
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetUnidadMedida` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetUnidadMedida`(IN datos JSON,IN transaccion VARCHAR(50))
BEGIN
    DECLARE nombreT VARCHAR(100);

    -- Extraer datos del JSON
    SET nombreT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Nombre'));

    IF transaccion = 'agregar_unidad' THEN
        INSERT INTO abasto_unidades_medida(Nombre, IdEstado)
            VALUES(nombreT,1);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetUsuario`(IN datos JSON, IN transaccion VARCHAR(50))
BEGIN
    DECLARE idUsuarioT INT;
    DECLARE cedulaT VARCHAR(10);
    DECLARE claveT  VARCHAR(100);
    DECLARE nombresT VARCHAR(100);
    DECLARE apellidosT VARCHAR(100);
    DECLARE idrolT     INT;
    DECLARE existe INT;

    -- Extraer datos del JSON
    SET cedulaT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Cedula'));
    SET claveT =  JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Password'));
    SET nombresT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Nombres'));
    SET apellidosT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.Apellidos'));
    SET idrolT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdRol'));

    -- Validar si ya existen usuarios con la misma cédula, pero no el mismo usuario
    IF transaccion = 'editar_usuario' THEN
        SET idUsuarioT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdUsuario'));

        -- Validación si la cédula ya está registrada para otro usuario
        SELECT COUNT(*) INTO existe
        FROM abasto_usuarios
        WHERE cedula = cedulaT
        AND id != idUsuarioT;  -- Verificar que no sea el mismo usuario

    ELSE
        -- Validación para registro
        SELECT COUNT(*) INTO existe
        FROM abasto_usuarios
        WHERE cedula = cedulaT;
    END IF;

    -- Si la cédula ya está registrada y no es para eliminación, lanzar un error
    IF existe > 0 AND transaccion != 'eliminar_usuario' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La cédula ya está registrada';
    ELSE
        IF transaccion = 'registrar' THEN
            -- Insertar datos en la tabla
            INSERT INTO abasto_usuarios (cedula, nombres, apellidos, clave, idrol_id, idEstado) 
            VALUES (cedulaT, nombresT, apellidosT, claveT, idrolT, 1);
        END IF;
        
        IF transaccion = 'editar_usuario' THEN
            -- Actualizar la información del usuario
            UPDATE abasto_usuarios
            SET
                cedula = cedulaT,
                clave = claveT,
                nombres = nombresT,
                apellidos = apellidosT,
                idrol_id = idrolT
            WHERE id = idUsuarioT;
        END IF;
        
        IF transaccion = 'eliminar_usuario' THEN
            SET idUsuarioT = JSON_UNQUOTE(JSON_EXTRACT(datos, '$.IdUsuario'));
            UPDATE abasto_usuarios
            SET
                idEstado = 3  -- Se marca como eliminado (estado 3)
            WHERE id = idUsuarioT;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-22 12:54:06
