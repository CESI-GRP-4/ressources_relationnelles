-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: ressources_relationnelles
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `asso_resource_game`
--

DROP TABLE IF EXISTS `asso_resource_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asso_resource_game` (
  `id_resource` int(11) NOT NULL,
  `id_game` int(11) NOT NULL,
  PRIMARY KEY (`id_resource`,`id_game`),
  KEY `id_game` (`id_game`),
  CONSTRAINT `asso_resource_game_ibfk_1` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`),
  CONSTRAINT `asso_resource_game_ibfk_2` FOREIGN KEY (`id_game`) REFERENCES `games` (`id_game`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asso_resource_game`
--

LOCK TABLES `asso_resource_game` WRITE;
/*!40000 ALTER TABLE `asso_resource_game` DISABLE KEYS */;
INSERT INTO `asso_resource_game` VALUES (1,1);
/*!40000 ALTER TABLE `asso_resource_game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asso_resource_statistic`
--

DROP TABLE IF EXISTS `asso_resource_statistic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asso_resource_statistic` (
  `id_resource` int(11) NOT NULL,
  `id_statistic_archive` int(11) NOT NULL,
  PRIMARY KEY (`id_resource`,`id_statistic_archive`),
  KEY `id_statistic_archive` (`id_statistic_archive`),
  CONSTRAINT `asso_resource_statistic_ibfk_1` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`),
  CONSTRAINT `asso_resource_statistic_ibfk_2` FOREIGN KEY (`id_statistic_archive`) REFERENCES `statistics_archive` (`id_statistic_archive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asso_resource_statistic`
--

LOCK TABLES `asso_resource_statistic` WRITE;
/*!40000 ALTER TABLE `asso_resource_statistic` DISABLE KEYS */;
INSERT INTO `asso_resource_statistic` VALUES (1,1);
/*!40000 ALTER TABLE `asso_resource_statistic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asso_role_right`
--

DROP TABLE IF EXISTS `asso_role_right`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asso_role_right` (
  `id_role` int(11) NOT NULL,
  `id_right` int(11) NOT NULL,
  PRIMARY KEY (`id_role`,`id_right`),
  KEY `id_right` (`id_right`),
  CONSTRAINT `asso_role_right_ibfk_1` FOREIGN KEY (`id_role`) REFERENCES `roles` (`id_role`),
  CONSTRAINT `asso_role_right_ibfk_2` FOREIGN KEY (`id_right`) REFERENCES `rights` (`id_right`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asso_role_right`
--

LOCK TABLES `asso_role_right` WRITE;
/*!40000 ALTER TABLE `asso_role_right` DISABLE KEYS */;
INSERT INTO `asso_role_right` VALUES (1,1);
/*!40000 ALTER TABLE `asso_role_right` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asso_user_bookmark`
--

DROP TABLE IF EXISTS `asso_user_bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asso_user_bookmark` (
  `id_user` int(11) NOT NULL,
  `id_resource` int(11) NOT NULL,
  PRIMARY KEY (`id_user`,`id_resource`),
  KEY `id_resource` (`id_resource`),
  CONSTRAINT `asso_user_bookmark_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  CONSTRAINT `asso_user_bookmark_ibfk_2` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asso_user_bookmark`
--

LOCK TABLES `asso_user_bookmark` WRITE;
/*!40000 ALTER TABLE `asso_user_bookmark` DISABLE KEYS */;
INSERT INTO `asso_user_bookmark` VALUES (1,1);
/*!40000 ALTER TABLE `asso_user_bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asso_user_note`
--

DROP TABLE IF EXISTS `asso_user_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asso_user_note` (
  `id_user` int(11) NOT NULL,
  `id_resource` int(11) NOT NULL,
  PRIMARY KEY (`id_user`,`id_resource`),
  KEY `id_resource` (`id_resource`),
  CONSTRAINT `asso_user_note_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  CONSTRAINT `asso_user_note_ibfk_2` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asso_user_note`
--

LOCK TABLES `asso_user_note` WRITE;
/*!40000 ALTER TABLE `asso_user_note` DISABLE KEYS */;
INSERT INTO `asso_user_note` VALUES (1,1);
/*!40000 ALTER TABLE `asso_user_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asso_user_resource`
--

DROP TABLE IF EXISTS `asso_user_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asso_user_resource` (
  `id_user` int(11) NOT NULL,
  `id_resource` int(11) NOT NULL,
  PRIMARY KEY (`id_user`,`id_resource`),
  KEY `id_resource` (`id_resource`),
  CONSTRAINT `asso_user_resource_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  CONSTRAINT `asso_user_resource_ibfk_2` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asso_user_resource`
--

LOCK TABLES `asso_user_resource` WRITE;
/*!40000 ALTER TABLE `asso_user_resource` DISABLE KEYS */;
INSERT INTO `asso_user_resource` VALUES (1,1);
/*!40000 ALTER TABLE `asso_user_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blocked_users`
--

DROP TABLE IF EXISTS `blocked_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocked_users` (
  `id_blocked` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `id_user` int(11) NOT NULL,
  PRIMARY KEY (`id_blocked`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `blocked_users_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocked_users`
--

LOCK TABLES `blocked_users` WRITE;
/*!40000 ALTER TABLE `blocked_users` DISABLE KEYS */;
INSERT INTO `blocked_users` VALUES (1,'2024-01-18 22:38:55','2024-01-19 22:38:55',1);
/*!40000 ALTER TABLE `blocked_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id_category` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Education'),(2,'Entertainment');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `id_city` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_city`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,'Paris'),(2,'New York'),(3,'Tokyo');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id_comment` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(1000) NOT NULL,
  `posting_date` datetime NOT NULL,
  `id_parent_comment` int(11) DEFAULT NULL,
  `id_resource` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  PRIMARY KEY (`id_comment`),
  KEY `id_parent_comment` (`id_parent_comment`),
  KEY `id_resource` (`id_resource`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`id_parent_comment`) REFERENCES `comments` (`id_comment`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`),
  CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'Great Resource!','2024-01-18 22:38:55',NULL,1,1);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id_country` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `country_code` varchar(8) NOT NULL,
  PRIMARY KEY (`id_country`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'France','FR'),(2,'United States','US'),(3,'Japan','JP');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id_file` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(2048) NOT NULL,
  `is_verified` tinyint(1) DEFAULT NULL,
  `download_count` bigint(20) NOT NULL,
  `id_resource` int(11) NOT NULL,
  PRIMARY KEY (`id_file`),
  KEY `id_resource` (`id_resource`),
  CONSTRAINT `files_ibfk_1` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (1,'/path/to/file',1,50,1);
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `games` (
  `id_game` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `max_player` smallint(6) NOT NULL,
  PRIMARY KEY (`id_game`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
INSERT INTO `games` VALUES (1,'Chess',2),(2,'Monopoly',6);
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invitations`
--

DROP TABLE IF EXISTS `invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invitations` (
  `id_invitation` int(11) NOT NULL AUTO_INCREMENT,
  `link` varchar(2048) NOT NULL,
  `status` varchar(50) NOT NULL,
  `creation_date` datetime NOT NULL,
  `expiration_date` datetime NOT NULL,
  `id_resource` int(11) NOT NULL,
  PRIMARY KEY (`id_invitation`),
  KEY `id_resource` (`id_resource`),
  CONSTRAINT `invitations_ibfk_1` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invitations`
--

LOCK TABLES `invitations` WRITE;
/*!40000 ALTER TABLE `invitations` DISABLE KEYS */;
INSERT INTO `invitations` VALUES (1,'http://example.com/invite','Sent','2024-01-18 22:38:55','2024-01-19 22:38:55',1);
/*!40000 ALTER TABLE `invitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postal_codes`
--

DROP TABLE IF EXISTS `postal_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postal_codes` (
  `id_postal_code` int(11) NOT NULL AUTO_INCREMENT,
  `postal_code` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id_postal_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postal_codes`
--

LOCK TABLES `postal_codes` WRITE;
/*!40000 ALTER TABLE `postal_codes` DISABLE KEYS */;
INSERT INTO `postal_codes` VALUES (1,'75000'),(2,'10001'),(3,'100-0001');
/*!40000 ALTER TABLE `postal_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources`
--

DROP TABLE IF EXISTS `resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources` (
  `id_resource` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `content` varchar(8000) DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT NULL,
  `view_count` bigint(20) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_category` int(11) NOT NULL,
  `id_status` int(11) NOT NULL,
  PRIMARY KEY (`id_resource`),
  KEY `id_user` (`id_user`),
  KEY `id_category` (`id_category`),
  KEY `id_status` (`id_status`),
  CONSTRAINT `resources_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  CONSTRAINT `resources_ibfk_2` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id_category`),
  CONSTRAINT `resources_ibfk_3` FOREIGN KEY (`id_status`) REFERENCES `status_resources` (`id_status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources`
--

LOCK TABLES `resources` WRITE;
/*!40000 ALTER TABLE `resources` DISABLE KEYS */;
INSERT INTO `resources` VALUES (1,'Resource 1','Description of Resource 1','Content of Resource 1',1,100,1,1,1);
/*!40000 ALTER TABLE `resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rights` (
  `id_right` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_right`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rights`
--

LOCK TABLES `rights` WRITE;
/*!40000 ALTER TABLE `rights` DISABLE KEYS */;
INSERT INTO `rights` VALUES (1,'Edit Post','Can edit any post'),(2,'Delete Post','Can delete any post');
/*!40000 ALTER TABLE `rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id_role` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin'),(2,'User'),(3,'Moderator');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_archive`
--

DROP TABLE IF EXISTS `statistics_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics_archive` (
  `id_statistic_archive` int(11) NOT NULL AUTO_INCREMENT,
  `archive_date` datetime DEFAULT NULL,
  `bookmarks_count` bigint(20) NOT NULL,
  `views_count` bigint(20) DEFAULT NULL,
  `total_download_count` bigint(20) NOT NULL,
  PRIMARY KEY (`id_statistic_archive`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_archive`
--

LOCK TABLES `statistics_archive` WRITE;
/*!40000 ALTER TABLE `statistics_archive` DISABLE KEYS */;
INSERT INTO `statistics_archive` VALUES (1,'2024-01-18 22:38:55',10,150,5);
/*!40000 ALTER TABLE `statistics_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_resources`
--

DROP TABLE IF EXISTS `status_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status_resources` (
  `id_status` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(50) NOT NULL,
  PRIMARY KEY (`id_status`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_resources`
--

LOCK TABLES `status_resources` WRITE;
/*!40000 ALTER TABLE `status_resources` DISABLE KEYS */;
INSERT INTO `status_resources` VALUES (1,'Active'),(2,'Inactive'),(3,'Pending');
/*!40000 ALTER TABLE `status_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `password` varchar(65) NOT NULL,
  `is_verified` tinyint(1) DEFAULT NULL,
  `path_picture` varchar(255) DEFAULT NULL,
  `id_city` int(11) NOT NULL,
  `id_postal_code` int(11) NOT NULL,
  `id_country` int(11) NOT NULL,
  `id_role` int(11) NOT NULL,
  PRIMARY KEY (`id_user`),
  KEY `id_city` (`id_city`),
  KEY `id_postal_code` (`id_postal_code`),
  KEY `id_country` (`id_country`),
  KEY `id_role` (`id_role`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_city`) REFERENCES `cities` (`id_city`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`id_postal_code`) REFERENCES `postal_codes` (`id_postal_code`),
  CONSTRAINT `users_ibfk_3` FOREIGN KEY (`id_country`) REFERENCES `countries` (`id_country`),
  CONSTRAINT `users_ibfk_4` FOREIGN KEY (`id_role`) REFERENCES `roles` (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'john.doe@example.com','John','Doe','$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m',1,'/path/to/picture',1,1,1,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-20 12:03:15
