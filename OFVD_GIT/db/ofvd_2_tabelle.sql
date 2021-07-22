
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

USE ofvd_access;

DROP TABLE IF EXISTS `operatore`;

DROP TABLE IF EXISTS `cav`;
CREATE TABLE `cav` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(20) NOT NULL,
  `INDIRIZZO` varchar(200) NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `TELEFONO` varchar(15) NOT NULL,  
  PRIMARY KEY (`EMAIL`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

LOCK TABLES `cav` WRITE;
UNLOCK TABLES;


DROP TABLE IF EXISTS `hospital`;
CREATE TABLE `hospital` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(20) NOT NULL,
  `INDIRIZZO` varchar(200) NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `TELEFONO` varchar(15) NOT NULL,  
  PRIMARY KEY (`EMAIL`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

LOCK TABLES `hospital` WRITE;
UNLOCK TABLES;


DROP TABLE IF EXISTS `super_user`;
CREATE TABLE `super_user` (
  `EMAIL` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `NOME` varchar(50) NOT NULL,
  `COGNOME` varchar(50) NOT NULL,
  `TELEFONO` varchar(15) NOT NULL,
  PRIMARY KEY (`EMAIL`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `super_user` WRITE;
INSERT INTO `super_user` (`email`,`password`, `nome`, `cognome`, `telefono`) 
VALUES ('dottrosariabruno@gmail.com',MD5('ofvd'),'Rosaria', 'Bruno', '3398147425');
UNLOCK TABLES;

CREATE TABLE `operatore` (
  `NOME` varchar(20) NOT NULL,
  `COGNOME` varchar(30) NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL,
  `DEFAULTPASSWORD` boolean NOT NULL,
  `CODE_OSPEDALE` varchar(50),
  `CODE_CAV` varchar(50),
  `CODE_ADMIN` varchar(50),
  `TELEFONO` varchar(10) NOT NULL,
  `MATRICOLA` varchar(10) NOT NULL,
  PRIMARY KEY (`EMAIL`),
  FOREIGN KEY (`CODE_OSPEDALE`) REFERENCES hospital(EMAIL) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (`CODE_CAV`) REFERENCES cav(EMAIL) ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (`CODE_ADMIN`) REFERENCES super_user(EMAIL) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `operatore` WRITE;
UNLOCK TABLES;


DROP TABLE IF EXISTS `options`;
CREATE TABLE `options` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `module` varchar(30) NOT NULL DEFAULT '',
  `key` varchar(30) NOT NULL DEFAULT '',
  `label` varchar(50) NOT NULL DEFAULT '',
  `value` varchar(5000) NOT NULL DEFAULT '',
  `type` tinyint(2) DEFAULT '0',
  `modifiable` tinyint(2) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `idx_options_key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

LOCK TABLES `options` WRITE;
INSERT INTO `options` VALUES (1,'Informazioni','dbsVersion','Versione DB','2.0.1',0,0);
UNLOCK TABLES;




