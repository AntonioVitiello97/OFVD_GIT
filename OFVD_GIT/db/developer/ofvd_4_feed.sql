
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

USE ofvd_access;

LOCK TABLES `cav` WRITE;
INSERT INTO `cav` VALUES (120,'Napoli','Via Poggio, 21','napoli@cav.it','0811122331'),(100,'Salerno','Via Rossi, 23','salerno@cav.it','0892233441');
UNLOCK TABLES;

LOCK TABLES `hospital` WRITE;
INSERT INTO `hospital` VALUES (2,'Solofra','Viale Fiorito, 112a','solofra@uol.it','3332233445'),(1,'Avellino','Via Roma, 3','avellino@uol.it','0825234567');
UNLOCK TABLES;

LOCK TABLES `super_user` WRITE;
INSERT INTO `super_user` (`email`,`password`, `nome`, `cognome`, `telefono`) 
VALUES ('mrisi@unisa.it',MD5('ofvd'),'Michele', 'Risi', '089963323');
UNLOCK TABLES;


LOCK TABLES `operatore` WRITE;
INSERT INTO `operatore` VALUES ('Antonio','Cavallo','cav@u.u',MD5('ofvd'),0,NULL,'napoli@cav.it','mrisi@unisa.it','3281234567','1234'),('Marco','Ospina','hos@u.u',MD5('ofvd'),0,'solofra@uol.it',NULL,'mrisi@unisa.it','3289988877','4321');
UNLOCK TABLES;







