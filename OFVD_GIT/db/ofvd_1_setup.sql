
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


DROP DATABASE IF EXISTS ofvd_access;
CREATE DATABASE ofvd_access;

USE ofvd_access;

DROP USER IF EXISTS 'ofvd'@'localhost';
CREATE USER 'ofvd'@'localhost' IDENTIFIED BY 'ofvd_178@cx';
GRANT ALL ON ofvd_access.* TO 'ofvd'@'localhost';




