-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema erdtest
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema indi2db
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema test
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema test
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `test` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `test` ;

-- -----------------------------------------------------
-- Table `test`.`problems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`problems` ;

CREATE TABLE IF NOT EXISTS `test`.`problems` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `content` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `rank` INT NULL DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT NULL,
  `category` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `input` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `output` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `remarks` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `auto` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `test`.`projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`projects` ;

CREATE TABLE IF NOT EXISTS `test`.`projects` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `category` VARCHAR(45) NULL DEFAULT NULL,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user` INT NOT NULL,
  `path` TEXT NOT NULL,
  `enabled` TINYINT NULL DEFAULT '1',
  `problem` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 43
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `test`.`submitresult`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`submitresult` ;

CREATE TABLE IF NOT EXISTS `test`.`submitresult` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `problem` INT NULL DEFAULT NULL,
  `createDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `is_success` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `test`.`testcases`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`testcases` ;

CREATE TABLE IF NOT EXISTS `test`.`testcases` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `input` VARCHAR(45) NULL DEFAULT NULL,
  `output` VARCHAR(45) NULL DEFAULT NULL,
  `problem` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `test`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`users` ;

CREATE TABLE IF NOT EXISTS `test`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `password` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `student_id` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `email` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `birth` DATE NULL DEFAULT NULL,
  `grade` INT NULL DEFAULT NULL,
  `school` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `test`.`auto_testcases`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`auto_testcases` ;

CREATE TABLE IF NOT EXISTS `test`.`auto_testcases` (
  `problems_id` INT NOT NULL,
  PRIMARY KEY (`problems_id`),
  INDEX `fk_auto_testcases_problems1_idx` (`problems_id` ASC) VISIBLE,
  CONSTRAINT `fk_auto_testcases_problems1`
    FOREIGN KEY (`problems_id`)
    REFERENCES `test`.`problems` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`blocks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`blocks` ;

CREATE TABLE IF NOT EXISTS `test`.`blocks` (
  `id` INT NOT NULL,
  `box` JSON NOT NULL,
  `vertical_rep` INT NOT NULL,
  `horizon_rep` INT NOT NULL,
  `space` TINYINT NOT NULL,
  `problems_id` INT NOT NULL,
  PRIMARY KEY (`id`, `problems_id`),
  INDEX `fk_blocks_auto_testcases1_idx` (`problems_id` ASC) VISIBLE,
  CONSTRAINT `fk_blocks_auto_testcases1`
    FOREIGN KEY (`problems_id`)
    REFERENCES `test`.`auto_testcases` (`problems_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`char_variables`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`char_variables` ;

CREATE TABLE IF NOT EXISTS `test`.`char_variables` (
  `name` VARCHAR(1) NOT NULL,
  `candidates` JSON NOT NULL,
  `problems_id` INT NOT NULL,
  PRIMARY KEY (`name`, `problems_id`),
  INDEX `fk_char_variables_auto_testcases1_idx` (`problems_id` ASC) VISIBLE,
  CONSTRAINT `fk_char_variables_auto_testcases1`
    FOREIGN KEY (`problems_id`)
    REFERENCES `test`.`auto_testcases` (`problems_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`int_variables`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`int_variables` ;

CREATE TABLE IF NOT EXISTS `test`.`int_variables` (
  `name` VARCHAR(1) NOT NULL,
  `min` INT NULL DEFAULT NULL,
  `max` INT NULL DEFAULT NULL,
  `fix` TINYINT NULL DEFAULT NULL,
  `Intcol` VARCHAR(45) NULL DEFAULT NULL,
  `problems_id` INT NOT NULL,
  PRIMARY KEY (`name`, `problems_id`),
  INDEX `fk_int_variables_auto_testcases1_idx` (`problems_id` ASC) VISIBLE,
  CONSTRAINT `fk_int_variables_auto_testcases1`
    FOREIGN KEY (`problems_id`)
    REFERENCES `test`.`auto_testcases` (`problems_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`answer_codes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`answer_codes` ;

CREATE TABLE IF NOT EXISTS `test`.`answer_codes` (
  `id` INT NOT NULL,
  `language` VARCHAR(45) NULL DEFAULT NULL,
  `code` VARCHAR(10000) NULL DEFAULT NULL,
  `problems_id` INT NOT NULL,
  PRIMARY KEY (`id`, `problems_id`),
  INDEX `fk_answer_codes_auto_testcases1_idx` (`problems_id` ASC) VISIBLE,
  CONSTRAINT `fk_answer_codes_auto_testcases1`
    FOREIGN KEY (`problems_id`)
    REFERENCES `test`.`auto_testcases` (`problems_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
