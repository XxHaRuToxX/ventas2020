-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: ventas2020v
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.38-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `ID_persona_c` int(11) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  PRIMARY KEY (`ID_persona_c`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`ID_persona_c`) REFERENCES `persona` (`ID_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'2012-04-10'),(2,'2012-04-10'),(3,'2012-04-10'),(4,'2012-04-10'),(5,'2012-04-10'),(6,'2012-04-10'),(7,'2012-04-10'),(17,'1998-06-12'),(20,'1999-05-23');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle`
--

DROP TABLE IF EXISTS `detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle` (
  `ID_Detalle` int(11) NOT NULL,
  `ID_producto` int(11) DEFAULT NULL,
  `ID_factura` varchar(5) DEFAULT NULL,
  `cantidad` double DEFAULT NULL,
  `SubTotal02` double DEFAULT NULL,
  PRIMARY KEY (`ID_Detalle`),
  KEY `ID_producto` (`ID_producto`),
  KEY `ID_factura` (`ID_factura`),
  CONSTRAINT `detalle_ibfk_1` FOREIGN KEY (`ID_producto`) REFERENCES `producto` (`ID_producto`),
  CONSTRAINT `detalle_ibfk_2` FOREIGN KEY (`ID_factura`) REFERENCES `factura` (`ID_factura`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle`
--

LOCK TABLES `detalle` WRITE;
/*!40000 ALTER TABLE `detalle` DISABLE KEYS */;
INSERT INTO `detalle` VALUES (1,1,'R001',5,20),(2,2,'R001',10,12),(3,3,'R002',1,200),(4,2,'R003',12,144),(5,3,'R003',1,200),(6,6,'R004',7,140),(7,5,'R005',1,38.5),(8,4,'R006',1,54),(9,3,'R007',1,200),(10,4,'R005',10,540),(11,2,'R012',10,120),(12,1,'R012',6,120),(13,1,'R012',20,400),(14,2,'R012',10,120);
/*!40000 ALTER TABLE `detalle` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ventas2020v`.`detalle_AFTER_INSERT` AFTER INSERT ON `detalle` FOR EACH ROW
BEGIN
	update producto set stock =stock -new.cantidad where ID_producto = new.id_producto;
	update factura set TOTALFACTURA =TOTALFACTURA +new.Subtotal02 where ID_factura =new.id_factura;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ventas2020v`.`detalle_BEFORE_UPDATE` BEFORE UPDATE ON `detalle` FOR EACH ROW
BEGIN
	update producto set stock =stock +old.cantidad -new.cantidad
				where id_producto=old.id_producto;
			update factura  set TOTALFACTURA =TOTALFACTURA - old.subtotal02 +new.subtotal02
				where ID_factura =old.id_factura;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ventas2020v`.`detalle_BEFORE_DELETE` BEFORE DELETE ON `detalle` FOR EACH ROW
BEGIN
			update producto set stock =stock +old.cantidad
				where id_producto=old.id_producto;
			update factura  set TOTALFACTURA =TOTALFACTURA - old.subtotal02 
				where ID_factura =old.id_factura;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `detalle02`
--

DROP TABLE IF EXISTS `detalle02`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle02` (
  `id_pr` int(11) DEFAULT NULL,
  `id_fac` varchar(5) DEFAULT NULL,
  `cant` double DEFAULT NULL,
  `subt` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle02`
--

LOCK TABLES `detalle02` WRITE;
/*!40000 ALTER TABLE `detalle02` DISABLE KEYS */;
INSERT INTO `detalle02` VALUES (1,'R001',5,100),(2,'R001',10,120),(3,'R002',1,200),(2,'R003',12,144),(3,'R003',1,200),(6,'R004',7,140),(5,'R005',1,38.5),(4,'R006',1,54),(3,'R007',1,200),(3,'R007',1,200),(1,'R001',5,100),(2,'R001',10,120),(3,'R002',1,200),(2,'R003',12,144),(3,'R003',1,200),(6,'R004',7,140),(5,'R005',1,38.5),(4,'R006',1,54),(3,'R007',1,200),(3,'R007',1,200),(1,'R001',5,20),(2,'R001',10,12),(3,'R002',1,200),(2,'R003',12,144),(3,'R003',1,200),(6,'R004',7,140),(5,'R005',1,38.5),(4,'R006',1,54),(3,'R007',1,200),(4,'R005',10,540),(2,'R012',10,120),(1,'R012',6,120),(1,'R012',20,400),(2,'R012',10,120),(2,'R012',10,120);
/*!40000 ALTER TABLE `detalle02` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura` (
  `ID_factura` varchar(5) NOT NULL,
  `fecha_factura` date DEFAULT NULL,
  `ID_persona_c` int(11) DEFAULT NULL,
  `ID_persona_v` int(11) DEFAULT NULL,
  `TOTALFACTURA` double DEFAULT NULL,
  `IGV` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`ID_factura`),
  KEY `ID_persona_c` (`ID_persona_c`),
  KEY `ID_persona_v` (`ID_persona_v`),
  CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`ID_persona_c`) REFERENCES `cliente` (`ID_persona_c`),
  CONSTRAINT `factura_ibfk_2` FOREIGN KEY (`ID_persona_v`) REFERENCES `vendedor` (`ID_persona_v`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
INSERT INTO `factura` VALUES ('R001','2011-07-25',1,8,259.6,46.73),('R002','2011-07-26',1,8,236,42.48),('R003','2011-07-27',2,8,1349.92,242.99),('R004','2011-07-28',3,8,165.2,29.74),('R005','2011-07-29',4,8,682.63,122.87),('R006','2011-07-30',5,9,0,0.00),('R007','2011-07-31',1,9,236,42.48),('R009','2020-02-18',3,8,236,42.48),('R010','2020-02-19',4,8,0,0.00),('R011','2020-02-19',5,8,0,0.00),('R012','2020-02-20',5,11,320,0.00),('R013','2020-02-20',2,8,0,0.00),('R014','2020-02-20',7,8,0,0.00),('R015','2020-02-20',7,9,0,0.00),('R016','2020-02-20',7,11,0,0.00);
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persona` (
  `ID_persona` int(11) NOT NULL,
  `nombres` varchar(30) DEFAULT NULL,
  `apellidos` varchar(30) DEFAULT NULL,
  `DNI` varchar(10) DEFAULT '10771899',
  PRIMARY KEY (`ID_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (1,'Jose','Perez','20120410'),(2,'Rina','Torres','20111225'),(3,'Rosa','Salas','20120625'),(4,'Oliver','Gamarra','20110822'),(5,'Alicia','Romero','20111224'),(6,'Joaquin','Rojas','20111126'),(7,'Rebeca','Ricalde','20120404'),(8,'Roberto','Gozales','20000404'),(9,'Anastasia','Perez','12220040'),(11,'JUAN','RIOS','76759452'),(16,'Javier','Moreno','12345643'),(17,'Nick','Macedo Cordava','98765433'),(18,'Wilson Papu','Mallma Sarmiento','9876549'),(19,'Juan','Moreno','84727121'),(20,'Pedro','Cusi','84727121');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod03`
--

DROP TABLE IF EXISTS `prod03`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prod03` (
  `id` int(11) NOT NULL,
  `nomb` varchar(40) DEFAULT NULL,
  `decs` varchar(30) DEFAULT NULL,
  `prec` double DEFAULT NULL,
  `stk` int(11) DEFAULT NULL,
  `padre` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod03`
--

LOCK TABLES `prod03` WRITE;
/*!40000 ALTER TABLE `prod03` DISABLE KEYS */;
INSERT INTO `prod03` VALUES (1,'FIERRO 3/4','BARRA',20,174,NULL),(2,'FIERRO 1/2','BARRA',12,180,'2'),(3,'LAVATORIO TREBOL CLASICO BLANCO','UNIDAD',200,240,'3'),(4,'CERROJO FORTE TRIPLE SEGURO','UNIDAD',54,200,NULL),(5,'CERROJO FORTE SIMPLE','UNIDAD',38.5,200,'5'),(6,'MAYOLICA CELIMA 20X50 BLANCA','METRO CUADRADO',20,200,'6'),(7,'MAOLICA CELIMA 35X20 COLOR','METRO CUADRADO',30,200,NULL),(8,'BAÑERA LOZA COLOR','UNIDAD',500,200,NULL),(9,'BAÑERA LOZA BLANCA','UNIDAD',300,200,'9'),(10,'BAÑERA LOZA BLANCA MARCA XYZ','UNIDAD',300,200,'9'),(12,'BASELINA','GALONES',300,50,NULL),(13,'CARRO','PESIMO',234,4,NULL),(14,'CARRO','PESIMO',234,4,NULL),(15,'CARBON','EL MEJOR',65,30,NULL),(16,'CARTON','BUENO',13,34,NULL),(17,'ARROZ','GALLITO',54,200,NULL);
/*!40000 ALTER TABLE `prod03` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto` (
  `ID_producto` int(11) NOT NULL,
  `nombre` varchar(40) DEFAULT NULL,
  `descripcion` varchar(30) DEFAULT NULL,
  `precio` double DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'FIERRO 3/4','BARRA',20,174),(2,'FIERRO 1/2','BARRA',12,180),(3,'LAVATORIO TREBOL CLASICO BLANCO','UNIDAD',200,240),(4,'CERROJO FORTE TRIPLE SEGURO','UNIDAD',54,200),(5,'CERROJO FORTE SIMPLE','UNIDAD',38.5,200),(6,'MAYOLICA CELIMA 20X50 BLANCA','METRO CUADRADO',20,200),(7,'MAOLICA CELIMA 35X20 COLOR','METRO CUADRADO',30,200),(8,'BAÑERA LOZA COLOR','UNIDAD',500,200),(9,'BAÑERA LOZA BLANCA','UNIDAD',300,200),(10,'BAÑERA LOZA BLANCA MARCA XYZ','UNIDAD',300,200),(12,'BASELINA','GALONES',300,50),(13,'CARRO','PESIMO',234,4),(14,'CARRO','PESIMO',234,4),(15,'CARBON','EL MEJOR',65,30),(16,'CARTON','BUENO',13,34),(17,'ARROZ','GALLITO',54,200);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto02`
--

DROP TABLE IF EXISTS `producto02`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto02` (
  `id_producto` int(11) DEFAULT NULL,
  `nombre` varchar(40) DEFAULT NULL,
  `descripcion` varchar(30) DEFAULT NULL,
  `precio` double DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `precioMax` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto02`
--

LOCK TABLES `producto02` WRITE;
/*!40000 ALTER TABLE `producto02` DISABLE KEYS */;
INSERT INTO `producto02` VALUES (1,'FIERRO 3/4','BARRA',20,174,20),(2,'FIERRO 1/2','BARRA',12,180,12),(4,'CERROJO FORTE TRIPLE SEGURO','UNIDAD',54,200,54),(5,'CERROJO FORTE SIMPLE','UNIDAD',38.5,200,38.5),(6,'MAYOLICA CELIMA 20X50 BLANCA','METRO CUADRADO',20,200,20),(7,'MAOLICA CELIMA 35X20 COLOR','METRO CUADRADO',30,200,30),(8,'BAÑERA LOZA COLOR','UNIDAD',500,200,450),(9,'BAÑERA LOZA BLANCA','UNIDAD',300,200,270),(10,'BAÑERA LOZA BLANCA MARCA XYZ','UNIDAD',300,200,270),(12,'BASELINA','GALONES',300,50,270),(13,'CARRO','PESIMO',234,4,210.6),(14,'CARRO','PESIMO',234,4,210.6),(15,'CARBON','EL MEJOR',65,30,65),(16,'CARTON','BUENO',13,34,13),(17,'ARROZ','GALLITO',54,200,54),(17,'ARROZ','GALLITO',54,200,54);
/*!40000 ALTER TABLE `producto02` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productotemporal`
--

DROP TABLE IF EXISTS `productotemporal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productotemporal` (
  `id_producto` int(11) DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `descripcion` varchar(40) DEFAULT NULL,
  `precio` double(6,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productotemporal`
--

LOCK TABLES `productotemporal` WRITE;
/*!40000 ALTER TABLE `productotemporal` DISABLE KEYS */;
/*!40000 ALTER TABLE `productotemporal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodxtra`
--

DROP TABLE IF EXISTS `prodxtra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prodxtra` (
  `idp` varchar(40) NOT NULL,
  PRIMARY KEY (`idp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodxtra`
--

LOCK TABLES `prodxtra` WRITE;
/*!40000 ALTER TABLE `prodxtra` DISABLE KEYS */;
/*!40000 ALTER TABLE `prodxtra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `id_proveedor` int(11) NOT NULL,
  `nombre_p` varchar(30) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `telefono` varchar(9) DEFAULT NULL,
  `ruc` varchar(11) DEFAULT '12983755364',
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'Pedro','Jr. Junin','934583722','12983755364'),(2,'Lucas','Jr. Puno','976328283','12983755364'),(3,'Javier','Jr. Linux','953627722','12983755364'),(4,'Kevin','Jr. kilo','973535221','10347383881'),(5,'Cementos sol','Jr. Ancash','928377172','12837363662'),(6,'Cementos','Jr. Ancash','928377172','12837363662'),(7,'Cementos','Jr. Ancash','928377172','12837363662'),(9,'Bancos','Jr. Lambayeque','974643172','12833566662'),(10,'Babas SAC','Jr. Tambopata','974556172','12845666621'),(11,'CEMENTO SAC','JR. CUSCO','958573333','21345678912');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedorproducto`
--

DROP TABLE IF EXISTS `proveedorproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedorproducto` (
  `id_producto` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `fecha_pro` date DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio_prod` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id_producto`,`id_proveedor`),
  KEY `id_proveedor_idx` (`id_proveedor`),
  CONSTRAINT `id_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`ID_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_proveedor` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedorproducto`
--

LOCK TABLES `proveedorproducto` WRITE;
/*!40000 ALTER TABLE `proveedorproducto` DISABLE KEYS */;
INSERT INTO `proveedorproducto` VALUES (1,1,'2002-12-23',14,400.00),(1,2,'2002-12-23',12,300.00),(14,1,'2020-03-09',2,276.12),(15,2,'2020-03-09',6,76.70),(16,1,'2020-03-12',12,14.16),(17,4,'2020-03-13',23,63.72);
/*!40000 ALTER TABLE `proveedorproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendedor`
--

DROP TABLE IF EXISTS `vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendedor` (
  `ID_persona_v` int(11) NOT NULL,
  `sueldo` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`ID_persona_v`),
  CONSTRAINT `vendedor_ibfk_1` FOREIGN KEY (`ID_persona_v`) REFERENCES `persona` (`ID_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedor`
--

LOCK TABLES `vendedor` WRITE;
/*!40000 ALTER TABLE `vendedor` DISABLE KEYS */;
INSERT INTO `vendedor` VALUES (8,2800.00),(9,2900.00),(11,4070.00),(16,4213.00),(18,750.00),(19,8382.00);
/*!40000 ALTER TABLE `vendedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ventas2020v'
--
/*!50003 DROP FUNCTION IF EXISTS `fnGetPrecio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnGetPrecio`() RETURNS double
begin 
	declare vID int;
	declare vFlag double;
	declare vPrecio double;
	set vFlag=(select precio from producto where ID_producto=vID);
	
			if(vFlag=0 and vFlag<100) then
				set vprecio=vFlag;
			elseif(vFlag>=100 and vFlag<200)then
				set vprecio=vFlag-(vFlag*0.5);
			elseif (vFlag>=200)then
				set vprecio=vFlag-(vFlag*0.1);
			end if;
	
	return vPrecio;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fnIDProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnIDProducto`() RETURNS int(11)
begin 
	declare fIdP int;
	if((select count(ID_producto) from producto)=0) then
		set fIdP=1;
	else 
		set fIdP=(select max(id_producto)+1 from producto);
	end if;

	return fIdP;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fnIDProveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnIDProveedor`() RETURNS int(11)
begin 
	declare vIDPro int;

	set vIDPro=(select max(id_proveedor)+1 from proveedor);
	return vIDPro;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fnNombreProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnNombreProducto`(
pID int
) RETURNS varchar(80) CHARSET latin1
BEGIN
declare varNombre varchar(80);
set varNombre=(select nombre from producto where id_producto=pID);

RETURN varNombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fnNuevoIdDetalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnNuevoIdDetalle`() RETURNS int(11)
begin 
	
	declare fIdD int;
	if((select count(id_detalle) from detalle)=0) then
		set fIdD=1;
	else 
		set fIdD=(select max(id_detalle)+1 from detalle);
	end if;

	return fIdD;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fnNuevoIDFactura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnNuevoIDFactura`() RETURNS varchar(5) CHARSET latin1
BEGIN
Declare vIDFac varchar(5);
Declare vIDFacInt int;
Set vIDFacInt = (Select right(max(ID_factura),3)+1 from factura);
IF (vIDFacInt<=9) THEN
	Set vIDFac = concat('R00',vIDFacInt);
ELSEIF (vIDFacInt>9 && vIDFacInt<=99) THEN
	Set vIDFac = concat('R0',vIDFacInt);
ELSEIF (vIDFacInt>99 && vIDFacInt<=999) THEN
	Set vIDFac = concat('R',vIDFacInt);
END IF;

RETURN vIDFac;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fnPadreProd03` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnPadreProd03`( _DATO VARCHAR(40)) RETURNS varchar(40) CHARSET latin1
BEGIN 
	DECLARE A,B,C,D,E INT DEFAULT 0;
	DECLARE AUX VARCHAR(40) DEFAULT NULL;
	SET A=(SELECT _DATO LIKE '%FIERRO 1/2%');
	SET B=(SELECT _DATO LIKE '%LAVATORIO TREBOL CLASICO BLANCO%');
	SET C=(SELECT _DATO LIKE '%CERROJO FORTE SIMPLE%');
	SET D=(SELECT _DATO LIKE '%MAYOLICA CELIMA 20X50 BLANCA%');
	SET E=(SELECT _DATO LIKE '%BAÑERA LOZA BLANCA%');
	
	IF(A>0)THEN
		SET AUX=('2');/*FIERRO*/
	END IF;
	IF(B>0)THEN
		SET AUX=('3');/*LAVATORIO*/
	END IF;
	IF(C>0)THEN
		SET AUX=('5');/*CERROJO*/
	END IF;
	IF(D>0)THEN
		SET AUX=('6');/*MAYOLICA*/
	END IF;
	IF(E>0)THEN
		SET AUX=('9');/*BAÑERA*/
	END IF;
	
	RETURN AUX;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fnPrecio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnPrecio`(
fIDpr int 
) RETURNS double
begin 
	declare vPrecio double ;
	set vPrecio=(select precio from producto where ID_producto =fIDpr);
return vPrecio;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fnPrecioProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnPrecioProducto`(
pID int
) RETURNS varchar(80) CHARSET latin1
BEGIN
declare varPrecio double;
set varPrecio=(select precio from producto where id_producto=pID);
RETURN varPrecio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fnPrecioProducto1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnPrecioProducto1`(pID int, pNomb varchar(80)) RETURNS double
begin 
	declare vPrecio double;
	if(pID=0)then
	set vPrecio=(select precio from producto where nombre=pNomb);
	else
	set vPrecio=(select precio from producto where id_producto=pID);
end if;
RETURN vPrecio;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `actualizarPersona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarPersona`(
pID int,
pNom varchar(30), 
pAp varchar(30), 
pDNI varchar(10), 
pFNac date, 
pDir varchar(80), 
pSuel double
)
BEGIN
UpDAte persona Set nombres=pNom, apellidos=pAp, DNI=pDNI
		Where id_persona=pID;
IF pDir != '' THEN -- direccion de Cliente es diferente de vacio, es decir tiene contenido
	update cliente Set direccion=pDir Where id_persona_c=pID;
else
	update vendedor Set sueldo=pSuel Where id_persona_v=pID;
END IF;    

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarProducto`()
BEGIN
DECLARE dato boolean default true;
set dato =(false);
SELECT dato;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscarProducto2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarProducto2`(in spDato varchar(20),in spPre double, out spPrice varchar(50))
BEGIN
if exists(select nombre,precio from producto where nombre like concat(spdato,'%') and precio=sppre )then
set spprice=(select concat(nombre,'precio: $',precio) from producto where nombre like concat(spdato,'%') 
and precio=sppre);
else
set spprice='no coinciden los datos';
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscarProducto3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarProducto3`(in spNomb varchar(20),in spPre double, out spName varchar(50), out spPrice double)
BEGIN
select nombre,precio into spname, spprice from producto where nombre like concat(spNomb,'%') and precio=sppre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cliente`()
BEGIN
select*from cliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clientesmasventas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clientesmasventas`()
BEGIN
select p.id_producto,c.id_persona_c,f.id_factura,d.id_detalle,c.fecha_nacimiento,sum(p.precio) from producto p,cliente c,factura f,detalle d where
p.id_producto=d.id_producto and c.id_persona_c=f.id_persona_c and d.id_factura=f.id_factura and precio > 150 group by c.id_persona_c;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ejemplo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ejemplo`(
	in pNombre varchar(20),
	in pApellidos varchar (20),
	in pDNI varchar(8),
	in S_FN_Persona varchar(10)
)
begin 
	declare IdAlterno int;
	declare Dnicatch varchar(8);
	declare a int;
	declare auxid int default 0;

	set dnicatch = (select count(dni) from Persona where dni=pDNI);

	if(dnicatch=0) then
		select max(id_persona)+1 into IdAlterno from persona;
	    
		insert into Persona() values(idAlterno,pNombre,pApellidos,pDNI);
		
	    if length(S_FN_Persona)=10 then
	        insert into cliente() values(Idalterno, date(S_FN_Persona));
	    else
			insert into vendedor() values(IdAlterno,S_FN_Persona);
	    end if;
		
	else
		if length(S_FN_Persona)=0 then
			set a = (select id_persona from persona where DNI = pDNI);
			set auxid = (select count(ID_persona_c) from cliente where ID_persona_c = a);
	        if auxid = 0 then
		        delete from vendedor where ID_persona_v = a;
		    else
				delete from cliente where ID_persona_c = a;
		    end if;
		    delete from persona where ID_persona = a;
	    else
			set a = (select id_persona from persona where DNI = pDNI);
			set auxid = (select count(ID_persona_c) from cliente where ID_persona_c = a);
	        if auxid = 0 then
		        update vendedor set sueldo =S_FN_Persona where ID_persona_v =a;
		    else
				update cliente set fecha_nacimiento =S_FN_Persona where ID_persona_c =a;
		    end if;
		    update persona set nombres =pNombre ,apellidos =pApellidos where ID_persona =a;
	    end if;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ListarPersona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarPersona`()
BEGIN
select*from persona;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `productomasvendido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `productomasvendido`()
BEGIN
select d.id_detalle,p.id_producto,p.nombre,sum(d.cantidad) from detalle d,producto p where
d.id_producto=p.id_producto and cantidad>9 group by p.id_producto;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registrarPersona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registrarPersona`(
in pNOmbre varchar(20),
in pAp varchar(20),
in pDNI varchar(8),
in pFN date,
in pSueldo decimal(8,2)
)
BEGIN
declare varID,varIDalterno int;
declare varFlag int;

select count(id_persona),id_persona into varFlag,varIDalterno from persona
where nombres=pNombre and apellidos=pAp and DNI=pDNI;

select max(id_persona) + 1 into varID from persona;

/*set varID=(select max(id_perosna)+1 from perosna);*/
if(varFlag>0)then
	if(psueldo=0)then
	insert into cliente() values(varIDalterno,pFN);
	else
	insert into vendedor() values(varIDalterno,pSueldo);
	end if;
else

insert into Persona() values (varID,pNombre,pap,pDNI);
if(psueldo=0)then
	insert into cliente() values(varID,pFN);
	else
	insert into vendedor() values(varID,pSueldo);
	end if;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarDetalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarDetalle`()
begin 
	declare  _error boolean default false;
	declare vIDDet,indice int;
	declare vSubTotal double;
	declare MatrizX cursor for
		select ID_Detalle ,cantidad*fnPrecio(id_producto)from detalle;
	declare continue handler for sqlstate '02000' set _error =true;
	
	open MatrizX;
	
	repeat
			set indice=indice+1;
			fetch MatrizX into vIDDet,vSubTotal;
			update detalle set SubTotal02=vSubTotal where ID_Detalle =vIDDet;
			
	until _error end repeat;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarFactura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarFactura`()
begin 
	declare  _error boolean default false;
	
	declare vIdf varchar(5);
	declare vcant double;
	declare vTotal double;

	declare MatrizX cursor for 
	select factura.id_factura,sum(SubTotal02) from factura ,detalle  
	where factura.ID_factura =detalle.ID_factura group by factura.ID_factura;
	declare continue handler for sqlstate '02000' set _error =true;
	
	open MatrizX;
	
	repeat
			fetch MatrizX into vIdf,vTotal ;
			update factura set TOTALFACTURA=vTotal where ID_factura =vIDF;
			
	until _error end repeat;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spActualizarFactura1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spActualizarFactura1`()
begin 
	declare  _error boolean default false;
	
	declare vIdf varchar(5);
	declare vcant double;
	declare vTotal double;

	declare MatrizX cursor for 
	select factura.id_factura,sum(SubTotal02+(0.18*SubTotal02)) from factura ,detalle  
	where factura.ID_factura =detalle.ID_factura group by factura.ID_factura;
	declare continue handler for sqlstate '02000' set _error =true;
	
	open MatrizX;
	
	repeat
			fetch MatrizX into vIdf,vTotal ;
			update factura set TOTALFACTURA=vTotal, IGV=(vTotal*0.18) where ID_factura =vIDF;
			
	until _error end repeat;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spBuscarCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spBuscarCliente`(in pDato varchar(20))
BEGIN
select*from persona, cliente where persona.id_persona =cliente.id_persona_c 
and nombres like concat(pDato, '%');

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spBuscarrCliente2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spBuscarrCliente2`(in pDato varchar(20),out pNombre varchar(20))
BEGIN
select nombres into pnombre from persona, cliente where persona.id_persona=cliente.id_persona_c and
nombres like concat(pdato,'%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spBuscarVendedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spBuscarVendedor`(in nomb varchar(30))
BEGIN
select p.id_persona,v.id_persona_v, nombres from persona p, vendedor v where
p.id_persona=v.id_persona_v and nombres like concat(nomb,'%');

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spBuscarVendedor2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spBuscarVendedor2`(in spDato varchar(30),out spNombre varchar(30) )
BEGIN
select   nombres into spNombre from persona , vendedor  where
persona.id_persona=vendedor.id_persona_v and nombres like concat(spDato,'%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spDetalleProPro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDetalleProPro`(id_p int)
begin 
	declare  _error boolean default false;
	declare vIdpr int;

	declare MatrizX cursor for 
		select ID_producto from proveedorproducto where id_proveedor = id_p;
	declare continue handler for sqlstate '02000' set _error =true;
	
	open MatrizX;
	
	repeat
			fetch MatrizX into vIDPr;
			insert into productotemporal() select * from producto where ID_producto = vIDPr;
			
	until _error end repeat;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestinarDetalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestinarDetalle`(
pIDDet int,
pIDPr int,
pIDFac varchar(5),
pCant int
)
begin 
	declare vIdd int;
	declare vFlag int;
	declare varCon int;

	
	set vIdd=(select id_detalle from detalle where id=pIDDet);
if vIdd = 0 then
		set vFlag=(select max(id_detalle)+1 from detalle);
		insert into detalle values(pIDDet,pIDFact,pCant);
	else
		set varCon=(select count(pIDPr)+count(pIDFac)+count(pCant));
		if varCon = 1 then
			delete from detalle  where ID_detalle =pIDDet;
		else
			update detalle set ID_producto=pIDpr,ID_factura=pIDFac,cantidad =pCant where ID_detalle =pIDDet; 
		end if;
	end if;
	
	
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarDetalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarDetalle`(
pIDDet int,
pIDPr int,
pIDFac varchar(5),
pCant int
)
begin 
	declare vIdd int;
	declare vFlag int;
	declare varCon int;

	set vIdd=(select count(id_detalle) from detalle where id_detalle =pIDDet);
	if vIdd = 0 then
		-- select 'insertar';
			set vFlag=(select max(id_detalle)+1 from detalle);
			insert into detalle values(vFlag,pIDPr,pIDFac,pCant,pCant*fnPrecio(pIDPr));
	else
		    -- select 'eliminar y actualizar';
			if length(pIDFac) = 0 then
				delete from detalle where ID_detalle=pIDDet;
			else
				update detalle set ID_producto=pIDpr,ID_factura=pIDFac,cantidad =pCant where ID_detalle =pIDDet; 
			end if;
	end if;
		
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarDetalle1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarDetalle1`(
pIDDet int,
pIDPr int,
pIDFac varchar(5),
pCant int
)
begin 
	declare varID int;
	
	set varID=(select max(id_detalle)+1 from detalle);
if pIDDet = 0 then
	select 'insertar';
		
		insert into detalle values(varID,pIDPr,pIDFac,pCant,pCant*fnPrecio(pIDPr) );
else
	select 'actualizar';
		
		if (pIDDet != 0 && pIDPr!=0) then
			update detalle set cantidad =pCant,SubTotal02 =fnPrecio(pIDPr) where ID_detalle =pIDDet;
			
		else 
			
			if(pIDDet!=0 && pIDPr=0)then
				select 'eliminar';
			 	delete from detalle  where ID_detalle =pIDDet;
		end if;
	end if;
end if;
		
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarDetalle2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarDetalle2`(
pIDDet int,
pIDPr int,
pIDFac varchar(5),
pCant int)
begin 
	declare varID int;
	declare varCantBD,varStBD int; 
	declare vIDPr int;
	declare vIDF varchar(5);
	select ID_producto,ID_factura,cantidad,subtotal02 into vIDPr,vIDF,varCantBD,varSTBD from detalle where ID_Detalle =pIDDet;

	set varID=(select max(id_detalle)+1 from detalle);
	-- set varCantBD=(select cantidad from detalle where ID_Detalle=pIDDet);
	-- set varStBD=(select SubTotal02 from detalle where ID_Detalle=pIDDet);
	if(pIDDet=0)then
		insert into detalle values(varID,pIDPr,pIDFac,pCant,pCant*fnPrecio(pIDPr) );
		/*update factura set TOTALFACTURA =TOTALFACTURA -pCant*fnPrecio(pIDPr) where 
			ID_factura =pIDFac;
		update producto set stock =stock -pCant
			where ID_producto =pIDPr;*/
	elseif (pIDDet != 0 && pIDPr!=0) then
			update detalle set cantidad =pCant,SubTotal02 =fnPrecio(pIDPr) 
				where ID_detalle =pIDDet;
			/*update producto set stock =stock +varCantBD-pCant
				where id_producto=pIDPr;
			update factura  set TOTALFACTURA =TOTALFACTURA - varStBD +pCant*fnPrecio(pIDPr) 
				where ID_factura =pIDFac;*/
						
	elseif (pIDDet!=0 && pIDPr=0)then
	-- select vIDPr;
			delete from detalle where ID_Detalle =pIDDet;
			/*update producto set stock =stock +varCantBD
				where id_producto=vIDPr;
			update factura  set TOTALFACTURA =TOTALFACTURA - varCantBD*fnPrecio(vIDPr) 
				where ID_factura =vIDF;*/
	end if;	
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarDetalle3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarDetalle3`(
in vFlag char(1),
in idDe int,
in idProd int,
in idFact varchar (5),
in cant double

)
begin 
	declare varCantDB int;
    declare fac int;
   
        set varCantDB = (select cantidad from detalle where id_detalle = IDDe);
        set fac = (select subtotal02 from detalle where id_detalle = idDe);
    case vFlag
      when 'c' then
  		insert into detalle() 
    	values(fnNuevoIdDetalle(),idProd,idFact,cant,cant*fnPrecio(idProd)) ;
        update factura set totalfactura = totalfactura + cant*fnPrecio(idProd) where id_Factura=idFact;
        update producto set stock = stock - cant where id_producto=idProd;
      when 'a' then 
        update detalle set cantidad=cant, subtotal02 = cant*fnPrecio(idProd) where id_Detalle=idDe;
        update factura set totalfactura = totalfactura - fac +cant*fnPrecio(idProd) where id_Factura=idFact;
        update producto set stock = stock + varCantDB - cant where id_producto=idProd;
    when 'e' then
   		delete from detalle where id_Detalle=idDe;
        
        update factura set totalfactura = totalfactura - fac   where id_Factura=idFact;
        update producto set stock = stock + varCantDB where id_producto=idProd;
        
      end case;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarFactura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarFactura`(
in pIDFactura varchar(5),
in pIdPersona_c int,
in pIdPersona_v int

)
begin 
	declare varAuxIDFac varchar(5);
	declare varAuxIDFacInt int;

	declare varId varchar(5);

	set varId=(select id_factura from factura where ID_factura =pIDFactura);
	
if(varID is null)then
	
	set varAuxIDFacInt=(select right (max(id_factura),3)+1 from factura);
	
	if(varAuxIDFacInt<=9)then
		set varAuxIDFac=concat('R00',varAuxIDFacInt);
	else
		if (varAuxIDFac<=99) then
			set varAuxIDFac=concat('R0',varAuxIDFacInt); 
		else
			set varAuxIDFac=concat('R',varAuxIDFacInt); 
		end if;
	end if;
	insert into factura()values (varAuxIDFac,current_date(),pIdPersona_c,pIdPersona_v,0);
else
	if(pIdPersona_c=0 and pIdPersona_v=0)then
		delete from factura where ID_factura =pIdFactura;
		
	else
		update factura set  id_persona_c=pIdPersona_c, id_persona_v=pIdPersona_v where ID_factura =pIdFactura ;
	end if;
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarFactura1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarFactura1`(
in pIDFact varchar(5),
in pIDCli int,
in pIDVend int
)
BEGIN
insert into factura values(fnNuevoIDFactura(),current_date(),pIDCli,pIDvend,0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarFactura2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarFactura2`(
in pFlag char(1),
in pIDFact varchar(5),
in pIDCli int,
in pIDVend int
)
begin 
	case pflag 
		when 'a' then 
			insert into factura values(fnNuevoIDFactura(),current_date(),pIDCli,pIDvend,0);
		when 'b'then
			update factura set  id_persona_c=pIDCli, ID_persona_v =pIDVend where ID_factura =pIdFact;
		else 
			delete from factura where id_factura=pIDFact;
	end case;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarFactura3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarFactura3`(
in pIDFact varchar(5),
in pIDCli int,
in pIDVend int
)
begin 
case 
	when pIDFact='' then 
		insert into factura values(fnNuevoIDFactura(),current_date(),pIDCli,pIDvend,0);
	when pIDFact!='' && pIdCli!=0 then
		update factura set  id_persona_c=pIDCli, ID_persona_v =pIDVend where ID_factura =pIdFact;
	when pIDFact!='' && pIdCli=0 then
		delete from factura where id_factura=pIDFact;
end case;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarPersonas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarPersonas`(
in pNombre varchar(20),
in pApellidos varchar (20),
in pDNI varchar(8),
in S_FN_Persona varchar(10)
)
BEGIN
	declare IdAlterno int;
	declare Dnicatch varchar(8);
	declare a int;
	declare auxid int default 0;

	set dnicatch = (select count(dni) from Persona where dni=pDNI);

	if(dnicatch=0) then
		select max(id_persona)+1 into IdAlterno from persona;
	    
		insert into Persona() values(idAlterno,pNombre,pApellidos,pDNI);
		
	    if length(S_FN_Persona)=10 then
	        insert into cliente() values(Idalterno, date(S_FN_Persona));
	    else
			insert into vendedor() values(IdAlterno,S_FN_Persona);
	    end if;
		
	else
		if length(S_FN_Persona)=0 then
			set a = (select id_persona from persona where DNI = pDNI);
			set auxid = (select count(ID_persona_c) from cliente where ID_persona_c = a);
	        if auxid = 0 then
		        delete from vendedor where ID_persona_v = a;
		    else
				delete from cliente where ID_persona_c = a;
		    end if;
		    delete from persona where ID_persona = a;
	    else
			set a = (select id_persona from persona where DNI = pDNI);
			set auxid = (select count(ID_persona_c) from cliente where ID_persona_c = a);
	        if auxid = 0 then
		        update vendedor set sueldo =S_FN_Persona where ID_persona_v =a;
		    else
				update cliente set fecha_nacimiento =S_FN_Persona where ID_persona_c =a;
		    end if;
		    update persona set nombres =pNombre ,apellidos =pApellidos where ID_persona =a;
	    end if;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarProducto`(
in pID int,
in pNombre varchar(30),
in pDescripcion varchar(30),
in pPrecio double,
in pStock int
)
begin 
	declare varID int;
	declare auxID int;
	declare varCon int;
	
	set varID = (select count(ID_producto) from producto where ID_producto = pID);
	if varID = 0 then
		set auxID=(select max(id_producto)+1 from producto);
		insert into producto values(pID,pNombre,pDescripcion,pPrecio,pStock);
	else
		set varCon=(select count(pPrecio)+count(pStock)+count(pID));
		if varCon = 1 then
			delete from producto  where ID_producto =pID;
		else
			update producto set nombre=pNombre, descripcion=pDescripcion, precio=pPrecio, stock=pStock where ID_producto =pID; 
		end if;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarProducto1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarProducto1`(
in vFlag char(1),
in pIDPro int(11),
in pNombre varchar(40),
in pDesc varchar(30),
in pPrec double(8,2),
in pSto int(11)
)
begin 
	case vflag 
		when 'c' then 
			insert into producto values (fnIdProducto(),pnombre,pDesc,pPrec,pSto);
		when 'a'then
			update producto set nombre=pNombre,descripcion=pDesc,precio =pPrec,stock=pSto where ID_producto=pIdPro;
		when 'e' then
			delete from producto where ID_producto=pIDPro;
	end case;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarProducto2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarProducto2`(
in pIDPv int,
in pNombre varchar(30),
in pDir varchar(50),
in pTel varchar(9),
in pRuc varchar(11)
)
begin 
	declare varID int;
	
	
	set varID = (select count(ID_producto) from producto where ID_producto = pID);
	if pIDPv = 0 then
		
		insert into proveedor values(fnIDProveedor,pNombre,pDir,pTel,pRuc);
	else
		
		if (pIDPv != 0 && pNombre!='') then
			update proveedor set nombre_p =pNombre, direccion =pDir, telefono =pTel, ruc=pRuc where id_proveedor =pIDPv; 
			
		else
			if(pIDPv!=0 && pNombre='')then
			delete from proveedor  where id_proveedor =pIDPv;
			end if;
		end if;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarProPro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarProPro`(in _id int)
begin 
	select pro.id_producto,pro.nombre,pro.descripcion,pro.precio,pro.stock from producto pro,proveedorproducto p where
	pro.ID_producto=p.id_producto and p.ID_proveedor =_id;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarProveedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarProveedor`(
in vIdPro int,
in vNom varchar(30),
in vDir varchar(50), 
in vTel varchar(9),
in vRuc varchar(11)
)
begin 
	declare IdFlag int;
	declare varCon int;
	set idFlag=(select count(id_proveedor) from proveedor where id_proveedor =vIDPro);
	if idFlag = 0 then
		insert into proveedor values(fnIDProveedor(),vNom,vDir,vTel,vRuc);
	else
		set varcon=(select count(id_proveedor) from proveedor where id_proveedor= vIdPro);
		
		if varcon != 0 then
			delete from proveedor  where ID_proveedor =vIDPro;
		else
			if (varcon!=0 && vTel=0) then
			update proveedor set nombre=vNom, direccion =vDir, telefono =vTel,ruc=vRuc where ID_proveedor =vIDpro; 
			end if;
		end if;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarProveedor1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarProveedor1`(
in vFlag char(1),
in vIdPro int,
in vNom varchar(30),
in vDir varchar(50), 
in vTel varchar(9),
in vRuc varchar(11)
)
begin 
	case vFlag 
		when 'c' then 
			insert into proveedor values(fnIdProveedor(),vNom,vDir,vTel,vRuc);
		when 'a'then
			update proveedor set  nombre_p =vNom, direccion =vDir,telefono=vTel,ruc=vRuc where id_proveedor =vIDPro;
		when 'e' then 
			delete from proveedor where id_proveedor =vIDPro;
	end case;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarProveedor2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarProveedor2`(
in pIDPv int,
in pNombre varchar(30),
in pDir varchar(50),
in pTel varchar(9),
in pRuc varchar(11)
)
begin 
	declare varID int;
	
	
	-- set varID = (select count(ID_producto) from producto where ID_producto = pIDPv);
	if pIDPv = 0 then
		
		insert into proveedor values(fnIDProveedor(),pNombre,pDir,pTel,pRuc);
	else
		
		if (pIDPv != 0 && pNombre!='') then
			update proveedor set nombre_p =pNombre, direccion =pDir, telefono =pTel, ruc=pRuc where id_proveedor =pIDPv; 
			
		else
			if(pIDPv!=0 && pNombre='')then
			delete from proveedor  where id_proveedor =pIDPv;
			end if;
		end if;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarProveedorProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarProveedorProducto`(
in vFlag char(1),
in vIdPro int,
in vIDProv int,
in vDate date,
in vCant int,
in vPrecio decimal(8,2)

)
begin 
	declare varPrecio decimal(8,2);
	declare varCantDB int;
	declare varId int;
	declare varIDProv int;
	set varId=(select count(id_producto) from producto);
	set varCantDB = (select cantidad from proveedorproducto where id_producto = vIdPro);
	set varPrecio =(select precio from producto where ID_producto=vIdPro);
	
	case vFlag 
	
		when 'c' then 
			insert into proveedorproducto values(varID,vIDProv,vDate,vCant,varPrecio);
			update producto set stock = stock - vCant where id_producto=vIdPro;
		when 'a'then
			update proveedorproducto set  id_producto =varID, id_proveedor =vIDProv,fecha_pro=vDate,cantidad =vCant,precio_prod =varPrecio 
			where id_producto =vIDPro;
			update producto set stock = stock + varCantDB - cant where id_producto=vIdProd;
		when 'e' then 
			delete from proveedorproducto where id_producto =vIDPro;
			update producto set stock = stock + varCantDB where id_producto=vIdProd;
	end case;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarProveedorProducto1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarProveedorProducto1`(
in vIdPro int,
in vIDProv int,
in vDate date,
in vCant int,
in vPrecio decimal(8,2)
)
begin 
	declare varPrecio decimal(8,2);
	declare varCantDB int;
	declare varId int;
	set varId=(select count(id_producto) from producto);
	set varCantDB = (select cantidad from proveedorproducto where id_producto = vIdPro);
	set varPrecio =(select precio from producto where ID_producto=vIdPro);

	if(varID!=0)then
		insert into proveedorproducto values(varID,vIDProv,vDate,vCant);
		update producto set stock = stock - vCant where id_producto=vIdPro;
	elseif (vIDPro != 0 && vIDProv!=0) then
			update proveedorproducto set fecha_pro=vDate,cantidad =vCant,precio_prod =varPrecio 
			where id_producto =vIDPro;
			update producto set stock = stock + varCantDB - vcant where id_producto=vIdProd;
						
	elseif (vIDPro!=0 && vIDProv=0)then
	-- select vIDPr;
		delete from proveedorproducto where id_producto =vIDPro;
		update producto set stock = stock + varCantDB where id_producto=vIdProd;
	end if;	
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestionarProvProd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestionarProvProd`(in _id int)
begin 
	select p.id_proveedor,p.nombre_p,p.direccion,p.telefono,p.ruc from proveedor p,proveedorproducto pp where 
	p.id_proveedor=pp.id_proveedor and pp.id_producto =_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGestonarDetalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGestonarDetalle`(
pIDDet int,
pIDPr int,
pIDFac varchar(5),
pCant int
)
begin 
	declare vIdd int;
	declare vFlag int;
	declare varCon int;

	
	set vIdd=(select id_detalle from detalle where id=pIDDet);
if vIdd = 0 then
		set vFlag=(select max(id_detalle)+1 from detalle);
		insert into detalle values(pIDDet,pIDFact,pCant);
	else
		set varCon=(select count(pIDPr)+count(pIDFac)+count(pCant));
		if varCon = 1 then
			delete from detalle  where ID_detalle =pIDDet;
		else
			update detalle set ID_producto=pIDpr,ID_factura=pIDFac,cantidad =pCant where ID_detalle =pIDDet; 
		end if;
	end if;
	
	
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spMigrarDetalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spMigrarDetalle`()
begin 
	declare  _error boolean default false;
	declare vIdpr int;
	declare vIdfac varchar(5);
	declare vcant double;
	declare vSubTotal double;

	declare MatrizX cursor for select ID_producto, ID_factura, cantidad, SubTotal02 from detalle;
	declare continue handler for sqlstate '02000' set _error =true;
	
	open MatrizX;
	
	repeat
			fetch MatrizX into vIdpr,vIdfac,vcant,vSubTotal;
			insert into detalle02 values(vIdpr,vIdfac,vcant,vSubTotal);
			
	until _error end repeat;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spMigrarProd03` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spMigrarProd03`()
BEGIN 
	declare vid,vstk,vfilas,aux INT DEFAULT 0;
	declare vnomb,vdesc,vpadre VARCHAR(40);
	declare vpre DOUBLE;
	
	declare _error boolean default false;
	declare MatrizX cursor for select id_producto,nombre,descripcion,precio,stock from producto;
	declare continue handler for sqlstate '02000' set _error=true;
		set vfilas=(select count(*) from producto);
		truncate table prod03;
	OPEN MatrizX;
		aux:loop
		fetch MatrizX into vid,vnomb,vdesc,vpre,vstk;
		if(_error&&aux<=vfilas)then leave aux;end if;
	
	INSERT INTO prod03(id,nomb,decs,prec,stk,padre) VALUES(vid,vnomb,vdesc,vpre,vstk,fnPadreProd03(nomb));
	
	end loop aux;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spMigrarProducto02` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spMigrarProducto02`()
begin 
	declare  _error boolean default false;
	declare vId int;
	declare vnombre varchar(40);
	declare vdescripcion varchar(30);
	declare vprecio double;
	declare vstock int(11);
	declare prexm double;

	declare MatrizX cursor for select ID_producto,nombre, descripcion, precio,stock from producto;
	declare continue handler for sqlstate '02000' set _error =true;
	open MatrizX;			
	repeat
					
			fetch MatrizX into vId,vnombre,vdescripcion,vprecio,vstock;
			if vprecio<100 then 
				set prexm=(vprecio);
				insert into producto02 values(vId,vnombre,vdescripcion,vprecio,vstock,prexm);
			elseif vprecio>100 and vprecio<200 then
				set prexm=(vprecio-(vprecio*0.05));
				insert into producto02 values(vId,vnombre,vdescripcion,vprecio,vstock,prexm);
			elseif vprecio>200 then
				set prexm=(vprecio-(vprecio*0.10));
				insert into producto02 values(vId,vnombre,vdescripcion,vprecio,vstock,prexm);
			end if;
			
	until _error end repeat;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spObtenerIdProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spObtenerIdProducto`()
begin 
	declare vFlag int;
	if((select max(id_producto) from producto)=0)then
		select vFlag =1;
	 else 
		set vFlag=(select max(id_producto) from producto);
		select vFlag;
	end if;
	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `vendedor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `vendedor`()
BEGIN
select*from vendedor;
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

-- Dump completed on 2021-02-21 12:02:19
