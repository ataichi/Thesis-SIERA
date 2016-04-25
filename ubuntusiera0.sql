-- MySQL dump 10.13  Distrib 5.1.73, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: siera_final
-- ------------------------------------------------------
-- Server version	5.1.73-0ubuntu0.10.04.1

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
-- Table structure for table `attack`
--

DROP TABLE IF EXISTS `attack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attack` (
  `attack_id` int(11) NOT NULL AUTO_INCREMENT,
  `attack_name` varchar(100) NOT NULL,
  `security_id` int(11) NOT NULL,
  `protocol_type` varchar(5) NOT NULL,
  PRIMARY KEY (`attack_id`),
  KEY `security_id_idx` (`security_id`),
  CONSTRAINT `security_id` FOREIGN KEY (`security_id`) REFERENCES `security_level` (`security_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attack`
--

LOCK TABLES `attack` WRITE;
/*!40000 ALTER TABLE `attack` DISABLE KEYS */;
INSERT INTO `attack` VALUES (1,'Malware - Checks for open accounts',2,'tcp'),(2,'Malware - Open a TCP connection to port 0',2,'tcp'),(3,'Port Scanners - Performs portscan',6,'udp'),(4,'Windows - Check for the vulnerable certificates',3,'tcp');
/*!40000 ALTER TABLE `attack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attack_log`
--

DROP TABLE IF EXISTS `attack_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attack_log` (
  `attack_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `source_ip` varchar(45) NOT NULL,
  `source_port` int(11) NOT NULL,
  `destination_ip` varchar(45) NOT NULL,
  `destination_port` int(11) NOT NULL,
  `attack_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`attack_log_id`),
  KEY `attack_id_idx` (`attack_id`),
  KEY `role_id_idx` (`role_id`),
  CONSTRAINT `attack_id` FOREIGN KEY (`attack_id`) REFERENCES `attack` (`attack_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `source_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attack_log`
--

LOCK TABLES `attack_log` WRITE;
/*!40000 ALTER TABLE `attack_log` DISABLE KEYS */;
INSERT INTO `attack_log` VALUES (1,'2016-01-26 16:45:58','209.193.76.194',443,'172.16.4.104',76,1,1),(2,'2016-02-03 13:03:29','209.193.76.194',443,'172.16.4.26',1243,1,2),(3,'2016-02-05 00:20:04','24.34.23.12',46766,'172.16.4.52',80,4,1),(4,'2016-02-05 01:12:23','209.193.76.194',443,'172.16.4.104',76,1,1),(5,'2016-02-05 01:13:18','209.193.76.194',443,'172.16.4.104',76,1,1),(6,'2016-02-06 15:12:05','24.34.23.12',46491,'172.16.4.26',1534,2,2),(7,'2016-02-06 15:15:37','209.193.76.194',443,'172.16.4.104',76,1,1),(8,'2016-02-05 18:12:43','74.124.24.34',1245,'172.16.4.67',17538,3,2),(9,'2016-02-05 18:14:18','183.3.202.104',234,'172.16.4.31',45,4,2),(10,'2016-02-06 00:08:45','183.3.202.104',5000,'172.16.4.21',23,4,2),(11,'2016-02-06 02:17:26','58.230.97.226',34,'172.16.4.231',233,3,2),(12,'2016-02-07 00:19:28','58.230.97.226',67,'172.16.4.232',567,3,2),(13,'2016-02-08 13:14:09','24.34.23.12',567,'172.16.4.110',45,1,2),(14,'2016-02-08 17:03:59','24.34.23.12',123,'172.16.4.109',23,1,2),(15,'2016-02-09 19:27:03','24.34.23.12',122,'172.16.4.108',34,1,2),(16,'2016-02-10 20:06:16','24.34.23.12',450,'172.16.4.107',11,1,2),(17,'2016-02-10 21:06:18','24.34.23.12',98,'172.16.4.107',79,1,2),(18,'2016-02-10 23:06:08','89.163.245.98',43,'172.16.4.101',54,3,2),(19,'2016-02-10 23:29:03','89.163.245.98',23,'172.16.4.101',1000,3,2),(20,'2016-02-12 08:15:04','89.163.245.98',111,'172.16.4.102',655,3,2),(21,'2016-02-13 10:39:46','89.163.245.98',789,'172.16.4.103',564,3,2),(22,'2016-02-14 17:15:32','89.163.245.98',90,'172.16.4.107',400,3,2),(23,'2016-02-15 20:02:38','46.148.19.138',45,'172.16.4.107',677,2,2),(24,'2016-02-15 22:47:31','46.148.19.138',343,'172.16.4.107',666,2,2),(25,'2016-02-17 01:24:48','46.148.19.138',331,'172.16.4.107',333,2,2),(26,'2016-02-17 02:52:11','46.148.19.138',121,'172.16.4.107',888,2,2),(27,'2016-02-18 03:14:51','46.148.19.138',121,'172.16.4.101',566,2,2),(28,'2016-02-18 05:54:02','46.148.19.138',566,'172.16.4.101',65,2,2),(29,'2016-02-18 17:12:09','46.148.19.138',778,'172.16.4.101',53,2,2),(30,'2016-02-18 19:11:35','46.148.19.138',1222,'172.16.4.101',54,2,2),(31,'2016-02-20 00:22:01','95.66.141.13',343,'172.16.4.53',232,3,2),(32,'2016-02-20 12:22:28','95.66.141.13',565,'172.16.4.54',232,3,2),(33,'2016-02-21 01:22:34','95.66.141.13',22,'172.16.4.54',121,3,2),(34,'2016-02-21 06:22:56','95.66.141.13',123,'172.16.4.56',34,3,2),(35,'2016-02-21 18:26:03','95.66.141.13',454,'172.16.4.56',12,3,2),(36,'2016-02-21 20:14:28','95.66.141.13',232,'172.16.4.56',75,3,2),(37,'2016-02-22 20:12:49','95.66.141.13',565,'172.16.4.56',87,3,2),(38,'2016-02-22 22:20:58','95.66.141.13',989,'172.16.4.56',23,3,2),(39,'2016-02-24 07:23:00','93.127.245.41',333,'172.16.4.230',567,1,1),(40,'2016-02-29 05:02:35','93.127.245.41',190,'172.16.4.52',78,1,1),(41,'2016-02-29 18:40:24','69.67.67.14',4546,'172.16.4.104',234,3,1),(42,'2016-03-06 22:24:55','69.67.67.14',2323,'172.16.4.103',545,3,1),(43,'2016-03-08 00:20:25','85.174.144.228',1212,'172.16.4.39',21,2,1),(44,'2016-03-08 18:15:12','85.174.144.228',1111,'172.16.4.39',114,2,1),(45,'2016-03-09 22:38:14','85.174.144.228',1111,'172.16.4.104',114,2,1),(46,'2016-03-11 07:03:23','85.174.144.228',1111,'172.16.4.103',114,2,1),(47,'2016-03-14 10:12:00','85.174.144.228',1111,'172.16.4.65',114,2,1),(48,'2016-03-14 18:12:02','204.232.243.189',324,'172.16.4.65',232,3,1),(49,'2016-03-14 20:13:27','204.232.243.189',1111,'172.16.4.104',121,3,1),(50,'2016-03-15 00:52:42','204.232.243.189',343,'172.16.4.232',121,3,1),(51,'2016-03-15 03:43:57','204.232.243.189',652,'172.16.4.114',121,3,1),(52,'2016-03-15 11:16:41','204.232.243.189',234,'172.16.4.65',121,3,1),(53,'2016-03-23 17:34:41','64.125.239.211',656,'172.16.4.65',88,4,1),(54,'2016-03-23 17:36:43','64.125.239.211',232,'172.16.4.114',453,4,1),(55,'2016-03-23 19:23:45','64.125.239.211',112,'172.16.4.65',453,4,1),(56,'2016-03-23 22:25:02','64.125.239.211',325,'172.16.4.103',453,4,1),(57,'2016-03-23 23:13:39','64.125.239.211',892,'172.16.4.104',453,4,1),(58,'2016-03-24 00:16:51','64.125.239.211',50,'172.16.4.39',453,4,1),(59,'2016-03-24 02:32:12','64.125.239.211',132,'172.16.4.65',453,4,1),(60,'2016-03-24 12:55:44','64.125.239.211',652,'172.16.4.103',453,4,1),(61,'2016-03-23 17:52:33','131.40.55.141',217,'172.16.4.39',345,3,1),(62,'2016-03-24 11:07:24','131.40.55.141',832,'172.16.4.103',22,3,1),(63,'2016-03-24 11:07:25','131.40.55.141',23,'172.16.4.104',22,3,1),(64,'2016-03-24 11:07:26','131.40.55.141',64,'172.16.4.65',22,3,1),(65,'2016-03-24 11:07:27','131.40.55.141',1221,'172.16.4.114',22,3,1),(66,'2016-03-24 11:07:28','131.40.55.141',431,'172.16.4.39',22,3,1),(67,'2016-03-24 11:07:29','131.40.55.141',53,'172.16.4.65',22,3,1),(68,'2016-03-24 11:07:30','131.40.55.141',321,'172.16.4.65',22,3,1),(69,'2016-03-25 12:07:30','204.232.243.189',4444,'172.16.4.23',1222,3,1),(70,'2016-03-26 12:07:31','204.232.243.189',2322,'172.16.4.23',1145,3,1);
/*!40000 ALTER TABLE `attack_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attack_persistence`
--

DROP TABLE IF EXISTS `attack_persistence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attack_persistence` (
  `persistence_id` int(11) NOT NULL AUTO_INCREMENT,
  `attack_log_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `persistence_count` int(11) NOT NULL,
  PRIMARY KEY (`persistence_id`),
  KEY `attack_log_id_idx` (`attack_log_id`),
  CONSTRAINT `attack_log_id` FOREIGN KEY (`attack_log_id`) REFERENCES `attack_log` (`attack_log_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attack_persistence`
--

LOCK TABLES `attack_persistence` WRITE;
/*!40000 ALTER TABLE `attack_persistence` DISABLE KEYS */;
INSERT INTO `attack_persistence` VALUES (1,1,'2016-03-03 06:20:09',1),(2,2,'2016-03-03 06:20:09',1),(3,3,'2016-03-03 06:20:09',1),(4,4,'2016-03-03 06:20:09',2),(5,5,'2016-03-03 06:20:09',3),(6,6,'2016-03-03 06:20:09',1),(7,7,'2016-03-03 06:20:09',4),(8,8,'2016-03-03 06:20:09',1),(9,9,'2016-03-03 06:20:09',1),(10,10,'2016-03-03 06:20:09',2),(11,11,'2016-03-03 06:20:09',1),(12,12,'2016-03-03 06:20:09',2),(13,13,'2016-03-03 06:20:09',1),(14,14,'2016-03-03 06:20:09',2),(15,15,'2016-03-03 06:20:09',3),(16,16,'2016-03-03 06:20:09',4),(17,17,'2016-03-03 06:20:09',5),(18,18,'2016-03-03 06:20:09',1),(19,19,'2016-03-03 06:20:09',2),(20,20,'2016-03-03 06:20:09',3),(21,21,'2016-03-03 06:20:09',4),(22,22,'2016-03-03 06:20:09',5),(23,23,'2016-03-03 06:20:09',1),(24,24,'2016-03-03 06:20:09',2),(25,25,'2016-03-03 06:20:09',3),(26,26,'2016-03-03 06:20:09',4),(27,27,'2016-03-03 06:20:09',5),(28,28,'2016-03-03 06:20:09',6),(29,29,'2016-03-03 06:20:09',7),(30,30,'2016-03-03 06:20:09',8),(31,31,'2016-03-03 06:20:09',1),(32,32,'2016-03-03 06:20:09',2),(33,33,'2016-03-03 06:20:09',3),(34,34,'2016-03-03 06:20:09',4),(35,35,'2016-03-03 06:20:09',5),(36,36,'2016-03-03 06:20:09',6),(37,37,'2016-03-03 06:20:09',7),(38,38,'2016-03-03 06:20:09',8),(39,39,'2016-03-03 06:20:09',1),(40,40,'2016-03-03 06:20:09',2),(41,41,'2016-03-03 06:20:09',1),(42,42,'2016-03-03 06:20:09',2),(43,43,'2016-03-03 06:20:09',1),(44,44,'2016-03-03 06:20:09',2),(45,45,'2016-03-03 06:20:09',3),(46,46,'2016-03-03 06:20:09',4),(47,47,'2016-03-03 06:20:09',5),(48,48,'2016-03-03 06:20:09',1),(49,49,'2016-03-03 06:20:09',2),(50,50,'2016-03-03 06:20:09',3),(51,51,'2016-03-03 06:20:09',4),(52,52,'2016-03-03 06:20:09',5),(53,53,'2016-03-03 06:20:09',1),(54,54,'2016-03-03 06:20:09',2),(55,55,'2016-03-03 06:20:09',3),(56,56,'2016-03-03 06:20:09',4),(57,57,'2016-03-03 06:20:09',5),(58,58,'2016-03-03 06:20:09',6),(59,59,'2016-03-03 06:20:09',7),(60,60,'2016-03-03 06:20:09',8),(61,61,'2016-03-03 06:20:09',1),(62,62,'2016-03-03 06:20:09',2),(63,63,'2016-03-03 06:20:09',3),(64,64,'2016-03-03 06:20:09',4),(65,65,'2016-03-03 06:20:09',5),(66,66,'2016-03-03 06:20:09',6),(67,67,'2016-03-03 06:20:09',7),(68,68,'2016-03-03 06:20:09',8),(69,69,'2016-03-03 06:20:10',1),(70,70,'2016-03-03 06:20:10',2);
/*!40000 ALTER TABLE `attack_persistence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attack_rate`
--

DROP TABLE IF EXISTS `attack_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attack_rate` (
  `attack_rate_id` int(11) NOT NULL AUTO_INCREMENT,
  `value_from` float NOT NULL,
  `value_to` float NOT NULL,
  `attack_level` varchar(45) NOT NULL,
  PRIMARY KEY (`attack_rate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attack_rate`
--

LOCK TABLES `attack_rate` WRITE;
/*!40000 ALTER TABLE `attack_rate` DISABLE KEYS */;
INSERT INTO `attack_rate` VALUES (1,0,0.4999,'low'),(2,0.5,1,'medium'),(3,1.0001,65535,'high');
/*!40000 ALTER TABLE `attack_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `high_priority_users`
--

DROP TABLE IF EXISTS `high_priority_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `high_priority_users` (
  `high_priority_id` int(11) NOT NULL AUTO_INCREMENT,
  `source_ip` varchar(45) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`high_priority_id`),
  KEY `role_id_idx` (`role_id`),
  CONSTRAINT `hp_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `high_priority_users`
--

LOCK TABLES `high_priority_users` WRITE;
/*!40000 ALTER TABLE `high_priority_users` DISABLE KEYS */;
INSERT INTO `high_priority_users` VALUES (1,'172.16.4.104',1),(2,'172.16.4.52',1),(3,'172.16.4.111',1),(4,'172.16.4.23',1),(5,'172.16.4.55',1),(6,'172.16.4.32',1),(7,'172.16.4.230',1),(8,'172.16.4.39',1),(9,'172.16.4.65',1),(10,'172.16.4.103',1);
/*!40000 ALTER TABLE `high_priority_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metric_conjunction`
--

DROP TABLE IF EXISTS `metric_conjunction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metric_conjunction` (
  `metric_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `attack_rate_id` int(11) NOT NULL,
  `protocol_type` varchar(5) NOT NULL,
  `tcp_reset` int(1) NOT NULL,
  `time_based` int(1) NOT NULL,
  `acl_block` int(1) NOT NULL,
  PRIMARY KEY (`metric_id`),
  KEY `metric_role_id_idx` (`role_id`),
  KEY `metric_attack_rate_id_idx` (`attack_rate_id`),
  CONSTRAINT `metric_attack_rate_id` FOREIGN KEY (`attack_rate_id`) REFERENCES `attack_rate` (`attack_rate_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `metric_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metric_conjunction`
--

LOCK TABLES `metric_conjunction` WRITE;
/*!40000 ALTER TABLE `metric_conjunction` DISABLE KEYS */;
INSERT INTO `metric_conjunction` VALUES (1,2,1,'tcp',1,1,0),(2,2,2,'tcp',1,1,0),(3,2,3,'tcp',0,0,1),(4,1,1,'tcp',0,0,1),(5,1,2,'tcp',0,0,1),(6,1,3,'tcp',0,0,1),(7,2,1,'udp',0,1,0),(8,2,2,'udp',0,1,0),(9,2,3,'udp',0,0,1),(10,1,1,'udp',0,0,1),(11,1,2,'udp',0,0,1),(12,1,3,'udp',0,0,1);
/*!40000 ALTER TABLE `metric_conjunction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permanent_block`
--

DROP TABLE IF EXISTS `permanent_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permanent_block` (
  `permanent_block_id` int(11) NOT NULL AUTO_INCREMENT,
  `response_id` int(11) NOT NULL,
  `is_block` int(11) NOT NULL,
  `last_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`permanent_block_id`),
  KEY `permanent_response_id_idx` (`response_id`),
  CONSTRAINT `permanent_response_id` FOREIGN KEY (`response_id`) REFERENCES `response` (`response_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permanent_block`
--

LOCK TABLES `permanent_block` WRITE;
/*!40000 ALTER TABLE `permanent_block` DISABLE KEYS */;
INSERT INTO `permanent_block` VALUES (1,1,1,'2016-03-03 06:20:09'),(2,3,1,'2016-03-03 06:20:09'),(3,4,1,'2016-03-03 06:20:09'),(4,5,1,'2016-03-03 06:20:09'),(5,7,1,'2016-03-03 06:20:09'),(6,30,1,'2016-03-03 06:20:09'),(7,38,1,'2016-03-03 06:20:09'),(8,39,1,'2016-03-03 06:20:09'),(9,40,1,'2016-03-03 06:20:09'),(10,41,1,'2016-03-03 06:20:09'),(11,42,1,'2016-03-03 06:20:09'),(12,43,1,'2016-03-03 06:20:09'),(13,44,1,'2016-03-03 06:20:09'),(14,45,1,'2016-03-03 06:20:09'),(15,46,1,'2016-03-03 06:20:09'),(16,47,1,'2016-03-03 06:20:09'),(17,48,1,'2016-03-03 06:20:09'),(18,49,1,'2016-03-03 06:20:09'),(19,50,1,'2016-03-03 06:20:09'),(20,51,1,'2016-03-03 06:20:09'),(21,52,1,'2016-03-03 06:20:09'),(22,53,1,'2016-03-03 06:20:09'),(23,54,1,'2016-03-03 06:20:09'),(24,55,1,'2016-03-03 06:20:09'),(25,56,1,'2016-03-03 06:20:09'),(26,57,1,'2016-03-03 06:20:09'),(27,58,1,'2016-03-03 06:20:09'),(28,59,1,'2016-03-03 06:20:09'),(29,60,1,'2016-03-03 06:20:09'),(30,61,1,'2016-03-03 06:20:09'),(31,62,1,'2016-03-03 06:20:09'),(32,63,1,'2016-03-03 06:20:09'),(33,64,1,'2016-03-03 06:20:09'),(34,65,1,'2016-03-03 06:20:09'),(35,66,1,'2016-03-03 06:20:09'),(36,67,1,'2016-03-03 06:20:09'),(37,68,1,'2016-03-03 06:20:10'),(38,69,1,'2016-03-03 06:20:10'),(39,70,1,'2016-03-03 06:20:10');
/*!40000 ALTER TABLE `permanent_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `response`
--

DROP TABLE IF EXISTS `response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `response` (
  `response_id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `persistence_id` int(11) NOT NULL,
  `interval_id` int(11) NOT NULL,
  `attack_rate_id` int(11) NOT NULL,
  `metric_id` int(11) NOT NULL DEFAULT '-1',
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`response_id`),
  KEY `response_attack_persistence_id_idx` (`persistence_id`),
  KEY `response_time_interval_id_idx` (`interval_id`),
  KEY `response_attack_rate_id_idx` (`attack_rate_id`),
  KEY `response_metric_id_idx` (`metric_id`),
  CONSTRAINT `response_attack_persistence_id` FOREIGN KEY (`persistence_id`) REFERENCES `attack_persistence` (`persistence_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `response_attack_rate_id` FOREIGN KEY (`attack_rate_id`) REFERENCES `attack_rate` (`attack_rate_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `response_metric_id` FOREIGN KEY (`metric_id`) REFERENCES `metric_conjunction` (`metric_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `response_time_interval_id` FOREIGN KEY (`interval_id`) REFERENCES `time_persistence_interval` (`interval_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `response`
--

LOCK TABLES `response` WRITE;
/*!40000 ALTER TABLE `response` DISABLE KEYS */;
INSERT INTO `response` VALUES (1,'2016-03-03 06:20:09',1,1,1,4,'0'),(2,'2016-03-03 06:20:09',2,1,1,1,'0'),(3,'2016-03-03 06:20:09',3,1,1,4,'0'),(4,'2016-03-03 06:20:09',4,1,1,4,'0'),(5,'2016-03-03 06:20:09',5,1,1,4,'0'),(6,'2016-03-03 06:20:09',6,1,1,1,'0'),(7,'2016-03-03 06:20:09',7,1,2,5,'0'),(8,'2016-03-03 06:20:09',8,1,1,7,'0'),(9,'2016-03-03 06:20:09',9,1,1,1,'0'),(10,'2016-03-03 06:20:09',10,1,1,1,'0'),(11,'2016-03-03 06:20:09',11,1,1,7,'0'),(12,'2016-03-03 06:20:09',12,1,1,7,'0'),(13,'2016-03-03 06:20:09',13,1,1,1,'0'),(14,'2016-03-03 06:20:09',14,1,1,1,'0'),(15,'2016-03-03 06:20:09',15,1,1,1,'0'),(16,'2016-03-03 06:20:09',16,1,2,2,'0'),(17,'2016-03-03 06:20:09',17,1,2,2,'0'),(18,'2016-03-03 06:20:09',18,1,1,7,'0'),(19,'2016-03-03 06:20:09',19,1,1,7,'0'),(20,'2016-03-03 06:20:09',20,1,1,7,'0'),(21,'2016-03-03 06:20:09',21,1,2,8,'0'),(22,'2016-03-03 06:20:09',22,1,2,8,'0'),(23,'2016-03-03 06:20:09',23,1,1,1,'0'),(24,'2016-03-03 06:20:09',24,1,1,1,'0'),(25,'2016-03-03 06:20:09',25,1,1,1,'0'),(26,'2016-03-03 06:20:09',26,1,2,2,'0'),(27,'2016-03-03 06:20:09',27,1,2,2,'0'),(28,'2016-03-03 06:20:09',28,1,2,2,'0'),(29,'2016-03-03 06:20:09',29,1,2,2,'0'),(30,'2016-03-03 06:20:09',30,1,3,3,'0'),(31,'2016-03-03 06:20:09',31,1,1,7,'0'),(32,'2016-03-03 06:20:09',32,1,1,7,'0'),(33,'2016-03-03 06:20:09',33,1,1,7,'0'),(34,'2016-03-03 06:20:09',34,1,2,8,'0'),(35,'2016-03-03 06:20:09',35,1,2,8,'0'),(36,'2016-03-03 06:20:09',36,1,2,8,'0'),(37,'2016-03-03 06:20:09',37,1,2,8,'0'),(38,'2016-03-03 06:20:09',38,1,3,9,'0'),(39,'2016-03-03 06:20:09',39,1,1,4,'0'),(40,'2016-03-03 06:20:09',40,1,1,4,'0'),(41,'2016-03-03 06:20:09',41,1,1,10,'0'),(42,'2016-03-03 06:20:09',42,1,1,10,'0'),(43,'2016-03-03 06:20:09',43,1,1,4,'0'),(44,'2016-03-03 06:20:09',44,1,1,4,'0'),(45,'2016-03-03 06:20:09',45,1,1,4,'0'),(46,'2016-03-03 06:20:09',46,1,2,5,'0'),(47,'2016-03-03 06:20:09',47,1,2,5,'0'),(48,'2016-03-03 06:20:09',48,1,1,10,'0'),(49,'2016-03-03 06:20:09',49,1,1,10,'0'),(50,'2016-03-03 06:20:09',50,1,1,10,'0'),(51,'2016-03-03 06:20:09',51,1,2,11,'0'),(52,'2016-03-03 06:20:09',52,1,2,11,'0'),(53,'2016-03-03 06:20:09',53,1,1,4,'0'),(54,'2016-03-03 06:20:09',54,1,1,4,'0'),(55,'2016-03-03 06:20:09',55,1,1,4,'0'),(56,'2016-03-03 06:20:09',56,1,2,5,'0'),(57,'2016-03-03 06:20:09',57,1,2,5,'0'),(58,'2016-03-03 06:20:09',58,1,2,5,'0'),(59,'2016-03-03 06:20:09',59,1,2,5,'0'),(60,'2016-03-03 06:20:09',60,1,3,6,'0'),(61,'2016-03-03 06:20:09',61,1,1,10,'0'),(62,'2016-03-03 06:20:09',62,1,1,10,'0'),(63,'2016-03-03 06:20:09',63,1,1,10,'0'),(64,'2016-03-03 06:20:09',64,1,2,11,'0'),(65,'2016-03-03 06:20:09',65,1,2,11,'0'),(66,'2016-03-03 06:20:09',66,1,2,11,'0'),(67,'2016-03-03 06:20:09',67,1,2,11,'0'),(68,'2016-03-03 06:20:09',68,1,3,12,'0'),(69,'2016-03-03 06:20:10',69,1,1,10,'0'),(70,'2016-03-03 06:20:10',70,1,1,10,'0');
/*!40000 ALTER TABLE `response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(45) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'High Priority'),(2,'Low Priority');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_level`
--

DROP TABLE IF EXISTS `security_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_level` (
  `security_id` int(11) NOT NULL AUTO_INCREMENT,
  `security_name` varchar(45) NOT NULL,
  PRIMARY KEY (`security_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_level`
--

LOCK TABLES `security_level` WRITE;
/*!40000 ALTER TABLE `security_level` DISABLE KEYS */;
INSERT INTO `security_level` VALUES (1,'serious'),(2,'high'),(3,'medium'),(6,'low'),(7,'info');
/*!40000 ALTER TABLE `security_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tcp_reset`
--

DROP TABLE IF EXISTS `tcp_reset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tcp_reset` (
  `tcp_reset_id` int(11) NOT NULL AUTO_INCREMENT,
  `response_id` int(11) NOT NULL,
  PRIMARY KEY (`tcp_reset_id`),
  KEY `response_id_idx` (`response_id`),
  CONSTRAINT `tcp_response_id` FOREIGN KEY (`response_id`) REFERENCES `response` (`response_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tcp_reset`
--

LOCK TABLES `tcp_reset` WRITE;
/*!40000 ALTER TABLE `tcp_reset` DISABLE KEYS */;
INSERT INTO `tcp_reset` VALUES (1,2),(2,6),(3,9),(4,10),(5,13),(6,14),(7,15),(8,16),(9,17),(10,23),(11,24),(12,25),(13,26),(14,27),(15,28),(16,29);
/*!40000 ALTER TABLE `tcp_reset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_based`
--

DROP TABLE IF EXISTS `time_based`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_based` (
  `time_based_id` int(11) NOT NULL AUTO_INCREMENT,
  `response_id` int(11) NOT NULL,
  `num_days` int(11) NOT NULL,
  `block_start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `block_end` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`time_based_id`),
  KEY `response_id_idx` (`response_id`),
  KEY `num_days_idx` (`num_days`),
  CONSTRAINT `num_days` FOREIGN KEY (`num_days`) REFERENCES `time_based_range` (`timebased_range_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `time_response_id` FOREIGN KEY (`response_id`) REFERENCES `response` (`response_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_based`
--

LOCK TABLES `time_based` WRITE;
/*!40000 ALTER TABLE `time_based` DISABLE KEYS */;
INSERT INTO `time_based` VALUES (1,2,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(2,6,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(3,8,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(4,9,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(5,10,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(6,11,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(7,12,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(8,13,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(9,14,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(10,15,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(11,16,2,'2016-03-03 06:20:09','2016-03-08 06:20:09'),(12,17,2,'2016-03-03 06:20:09','2016-03-08 06:20:09'),(13,18,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(14,19,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(15,20,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(16,21,2,'2016-03-03 06:20:09','2016-03-08 06:20:09'),(17,22,2,'2016-03-03 06:20:09','2016-03-08 06:20:09'),(18,23,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(19,24,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(20,25,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(21,26,2,'2016-03-03 06:20:09','2016-03-08 06:20:09'),(22,27,2,'2016-03-03 06:20:09','2016-03-08 06:20:09'),(23,28,2,'2016-03-03 06:20:09','2016-03-08 06:20:09'),(24,29,2,'2016-03-03 06:20:09','2016-03-08 06:20:09'),(25,31,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(26,32,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(27,33,1,'2016-03-03 06:20:09','2016-03-05 06:20:09'),(28,34,2,'2016-03-03 06:20:09','2016-03-08 06:20:09'),(29,35,2,'2016-03-03 06:20:09','2016-03-08 06:20:09'),(30,36,2,'2016-03-03 06:20:09','2016-03-08 06:20:09'),(31,37,2,'2016-03-03 06:20:09','2016-03-08 06:20:09');
/*!40000 ALTER TABLE `time_based` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_based_range`
--

DROP TABLE IF EXISTS `time_based_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_based_range` (
  `timebased_range_id` int(11) NOT NULL AUTO_INCREMENT,
  `level` varchar(45) NOT NULL,
  `num_days` int(11) NOT NULL,
  PRIMARY KEY (`timebased_range_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_based_range`
--

LOCK TABLES `time_based_range` WRITE;
/*!40000 ALTER TABLE `time_based_range` DISABLE KEYS */;
INSERT INTO `time_based_range` VALUES (1,'Low',2),(2,'Medium',5);
/*!40000 ALTER TABLE `time_based_range` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_persistence_interval`
--

DROP TABLE IF EXISTS `time_persistence_interval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_persistence_interval` (
  `interval_id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `interval_number` int(11) NOT NULL,
  PRIMARY KEY (`interval_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_persistence_interval`
--

LOCK TABLES `time_persistence_interval` WRITE;
/*!40000 ALTER TABLE `time_persistence_interval` DISABLE KEYS */;
INSERT INTO `time_persistence_interval` VALUES (1,'2016-01-25 14:37:13',7);
/*!40000 ALTER TABLE `time_persistence_interval` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-24 23:34:19
