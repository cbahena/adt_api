# SQL Manager 2011 for MySQL 5.1.0.2
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : adt_bd


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES latin1 */;

SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `adt_bd`;

CREATE DATABASE `adt_bd`
    CHARACTER SET 'latin1'
    COLLATE 'latin1_swedish_ci';

USE `adt_bd`;

#
# Structure for the `estado_civil` table : 
#

CREATE TABLE `estado_civil` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `DESCRIPCION` (`descripcion`),
  UNIQUE KEY `descripcion_2` (`descripcion`)
)ENGINE=InnoDB
AVG_ROW_LENGTH=4096 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `pais` table : 
#

CREATE TABLE `pais` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `DESCRIPCION` (`descripcion`),
  UNIQUE KEY `descripcion_2` (`descripcion`)
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `genero` table : 
#

CREATE TABLE `genero` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `DESCRIPCION` (`descripcion`),
  UNIQUE KEY `descripcion_2` (`descripcion`)
)ENGINE=InnoDB
AVG_ROW_LENGTH=8192 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `persona` table : 
#

CREATE TABLE `persona` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL,
  `nombres` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL,
  `apellidos` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `direccion` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `id_pais` INTEGER(11) DEFAULT NULL,
  `id_estado_civil` INTEGER(11) DEFAULT NULL,
  `id_genero` INTEGER(11) DEFAULT NULL,
  `ecorreo` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `telefono` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `celular` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `CODIGO` (`codigo`),
  UNIQUE KEY `codigo_2` (`codigo`),
  KEY `ID_PAIS` (`id_pais`),
  KEY `ID_GENERO` (`id_genero`),
  KEY `id_estado_civil` (`id_estado_civil`),
  CONSTRAINT `persona_fk1` FOREIGN KEY (`id_pais`) REFERENCES `pais` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `persona_fk2` FOREIGN KEY (`id_estado_civil`) REFERENCES `estado_civil` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `persona_fk4` FOREIGN KEY (`id_genero`) REFERENCES `genero` (`ID`) ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=5 AVG_ROW_LENGTH=4096 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `paciente` table : 
#

CREATE TABLE `paciente` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `id_persona` INTEGER(11) NOT NULL,
  `numero_historia` INTEGER(11) NOT NULL,
  `fecha_historia` DATE NOT NULL,
  `peso` FLOAT(9,2) DEFAULT NULL COMMENT 'PESO EN KILOS',
  PRIMARY KEY (`id`),
  UNIQUE KEY `NUMERO_HISTORIA` (`numero_historia`),
  UNIQUE KEY `ID_PERSONA` (`id_persona`),
  UNIQUE KEY `ID_PERSONA_2` (`id_persona`),
  UNIQUE KEY `id_persona_3` (`id_persona`),
  UNIQUE KEY `numero_historia_2` (`numero_historia`),
  CONSTRAINT `paciente_fk1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=5 AVG_ROW_LENGTH=5461 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `tipo_especialidad` table : 
#

CREATE TABLE `tipo_especialidad` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `DESCRIPCION` (`descripcion`),
  UNIQUE KEY `descripcion_2` (`descripcion`)
)ENGINE=InnoDB
AVG_ROW_LENGTH=264 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `medico` table : 
#

CREATE TABLE `medico` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `id_persona` INTEGER(11) NOT NULL,
  `id_tipo_especialidad` INTEGER(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID_PERSONA_2` (`id_persona`),
  UNIQUE KEY `ID_PERSONA_3` (`id_persona`),
  UNIQUE KEY `id_persona_4` (`id_persona`),
  KEY `ID_TIPO_ESPECIALIDAD` (`id_tipo_especialidad`),
  KEY `ID_PERSONA` (`id_persona`),
  CONSTRAINT `medico_fk1` FOREIGN KEY (`id_tipo_especialidad`) REFERENCES `tipo_especialidad` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `medico_fk2` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=3 AVG_ROW_LENGTH=8192 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `tipo_examen` table : 
#

CREATE TABLE `tipo_examen` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL,
  `tipo_icono` ENUM('type1','type2','type3','type4') NOT NULL DEFAULT 'type1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `descripcion` (`descripcion`)
)ENGINE=InnoDB
AUTO_INCREMENT=3 AVG_ROW_LENGTH=8192 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `examen_tomografia` table : 
#

CREATE TABLE `examen_tomografia` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `id_paciente` INTEGER(11) NOT NULL,
  `id_medico` INTEGER(11) NOT NULL,
  `diagnostico` VARCHAR(200) COLLATE latin1_swedish_ci NOT NULL,
  `fecha_examen` DATETIME NOT NULL,
  `ruta_archivo_examen` VARCHAR(200) COLLATE latin1_swedish_ci NOT NULL,
  `activo` TINYINT(1) NOT NULL DEFAULT 1,
  `id_tipo_examen` INTEGER(11) NOT NULL,
  `observaciones` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `RUTA_ARCHIVO_EXAMEN` (`ruta_archivo_examen`),
  UNIQUE KEY `RUTA_ARCHIVO_EXAMEN_2` (`ruta_archivo_examen`),
  UNIQUE KEY `ruta_archivo_examen_3` (`ruta_archivo_examen`),
  KEY `id_paciente` (`id_paciente`),
  KEY `id_medico` (`id_medico`),
  KEY `id_tipo_examen` (`id_tipo_examen`),
  CONSTRAINT `examen_tomografia_fk1` FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `examen_tomografia_fk2` FOREIGN KEY (`id_medico`) REFERENCES `medico` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `examen_tomografia_fk3` FOREIGN KEY (`id_tipo_examen`) REFERENCES `tipo_examen` (`id`) ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=17 AVG_ROW_LENGTH=1170 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `usuario` table : 
#

CREATE TABLE `usuario` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(40) COLLATE latin1_swedish_ci NOT NULL,
  `clave` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL,
  `activo` TINYINT(1) NOT NULL DEFAULT 0,
  `id_persona` INTEGER(11) NOT NULL,
  `fecha_registro` DATETIME NOT NULL,
  `tipo_usuario` ENUM('1','2') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `NOMBRE_USUARIO` (`nombre_usuario`),
  UNIQUE KEY `nombre_usuario_2` (`nombre_usuario`),
  KEY `id_persona` (`id_persona`),
  CONSTRAINT `usuario_fk1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`ID`) ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=4 AVG_ROW_LENGTH=16384 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

CREATE DEFINER = 'root'@'localhost' TRIGGER `usuario_before_ins_tr1` BEFORE INSERT ON `usuario`
  FOR EACH ROW
BEGIN
SET NEW.clave = MD5(CONCAT(NEW.clave, NEW.fecha_registro));
END;

CREATE DEFINER = 'root'@'localhost' TRIGGER `usuario_before_upd_tr1` BEFORE UPDATE ON `usuario`
  FOR EACH ROW
BEGIN
SET NEW.clave = MD5(CONCAT(NEW.clave, NEW.fecha_registro));
END;

#
# Definition for the `vista_medico` view : 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `vista_medico`
AS
select 
    concat(`persona`.`codigo`,' ',`persona`.`nombres`,' ',`persona`.`apellidos`,' ',`tipo_especialidad`.`descripcion`) AS `nombre`,
    `tipo_especialidad`.`descripcion` AS `especialidad`,
    `medico`.`id` AS `id_medico`,
    `persona`.`fecha_nacimiento` AS `fecha_nacimiento` 
  from 
    ((`medico` join `persona` on((`medico`.`id_persona` = `persona`.`id`))) join `tipo_especialidad` on((`medico`.`id_tipo_especialidad` = `tipo_especialidad`.`id`)));

#
# Definition for the `vista_paciente` view : 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `vista_paciente`
AS
select 
    concat(`persona`.`codigo`,' ',`persona`.`nombres`,' ',`persona`.`apellidos`) AS `nombre`,
    `paciente`.`id` AS `id_paciente` 
  from 
    (`paciente` join `persona` on((`paciente`.`id_persona` = `persona`.`id`)));

#
# Definition for the `vista_persona` view : 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `vista_persona`
AS
select 
    `persona`.`id` AS `id_persona`,
    concat(`persona`.`codigo`,' ',`persona`.`nombres`,' ',`persona`.`apellidos`) AS `nombre`,
    `persona`.`fecha_nacimiento` AS `fecha_nacimiento` 
  from 
    `persona`;

#
# Definition for the `vista_usuario` view : 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `vista_usuario`
AS
select 
    `usuario`.`nombre_usuario` AS `nombre_usuario`,
    `usuario`.`clave` AS `clave` 
  from 
    `usuario` 
  where 
    ((`usuario`.`activo` = 1) and (`usuario`.`tipo_usuario` = '2'));



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;