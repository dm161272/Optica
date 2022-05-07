-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optics
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optics
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optics` DEFAULT CHARACTER SET utf8 ;
USE `optics` ;

-- -----------------------------------------------------
-- Table `optics`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`city` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(25) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`id`, `country_id`),
  INDEX `fk_city_country1_idx` (`country_id` ASC) ,
  CONSTRAINT `fk_city_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `optics`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`supplier` (
  `id` INT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `street_name` VARCHAR(30) NOT NULL,
  `street_num` VARCHAR(5) NOT NULL,
  `floor_num` VARCHAR(5) NULL,
  `door_num` INT UNSIGNED NULL,
  `zip` INT UNSIGNED NOT NULL,
  `telephone` INT UNSIGNED NOT NULL,
  `fax` INT UNSIGNED NULL,
  `nif` VARCHAR(10) NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`id`, `city_id`),
  CONSTRAINT `fk_supplier_city1`
    FOREIGN KEY (`id` , `city_id`)
    REFERENCES `optics`.`city` (`id` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`brand` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `id_supplier` INT NOT NULL,
  PRIMARY KEY (`id`, `id_supplier`),
  INDEX `id_supplier_idx` (`id_supplier` ASC) ,
  CONSTRAINT `id_supplier`
    FOREIGN KEY (`id_supplier`)
    REFERENCES `optics`.`supplier` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`glasses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `garde` DECIMAL(1,1) NOT NULL DEFAULT 0,
  `frame_type` ENUM('wood', 'steel', 'mixed') NULL,
  `frame_color` VARCHAR(10) NOT NULL,
  `glass_color_right` VARCHAR(10) NOT NULL DEFAULT 'transparent',
  `glass_color_left` VARCHAR(10) NOT NULL DEFAULT 'transparent',
  `price` DECIMAL(6,2) NOT NULL DEFAULT 0,
  `quantity` INT UNSIGNED NOT NULL DEFAULT 0,
  `brand_id` INT NOT NULL,
  PRIMARY KEY (`id`, `brand_id`),
  INDEX `brand_id_idx` (`brand_id` ASC) ,
  CONSTRAINT `brand_id`
    FOREIGN KEY (`brand_id`)
    REFERENCES `optics`.`brand` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`customer` (
  `id` INT NOT NULL,
  `surname` VARCHAR(25) NULL,
  `lastname` VARCHAR(25) NULL,
  `name` VARCHAR(25) NULL,
  `street_name` VARCHAR(30) NOT NULL,
  `street_num` VARCHAR(5) NOT NULL,
  `floor_num` VARCHAR(5) NOT NULL,
  `door_num` INT UNSIGNED NOT NULL,
  `zip` INT UNSIGNED NOT NULL,
  `telephone` INT UNSIGNED NOT NULL,
  `registration_date` DATE NOT NULL,
  `referral_id` INT NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`id`, `referral_id`, `city_id`),
  INDEX `fk_customer_customer1_idx` (`referral_id` ASC) ,
  INDEX `fk_customer_city1_idx` (`city_id` ASC, `id` ASC) ,
  CONSTRAINT `fk_customer_customer1`
    FOREIGN KEY (`referral_id`)
    REFERENCES `optics`.`customer` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_customer_city1`
    FOREIGN KEY (`city_id` , `id`)
    REFERENCES `optics`.`city` (`id` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `surname` VARCHAR(25) NOT NULL,
  `lastname` VARCHAR(25) NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`sales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_employee` INT NOT NULL,
  `id_customer` INT NOT NULL,
  `id_glasses` INT NOT NULL,
  `quantity` INT NOT NULL,
  `date_of_sale` DATE NOT NULL,
  PRIMARY KEY (`id`, `id_glasses`, `id_customer`, `id_employee`),
  INDEX `id_employee_idx` (`id_employee` ASC) ,
  INDEX `id_glasses_idx` (`id_glasses` ASC) ,
  INDEX `id_customer_idx` (`id_customer` ASC) ,
  CONSTRAINT `id_employee`
    FOREIGN KEY (`id_employee`)
    REFERENCES `optics`.`employee` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `id_glasses`
    FOREIGN KEY (`id_glasses`)
    REFERENCES `optics`.`glasses` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `id_customer`
    FOREIGN KEY (`id_customer`)
    REFERENCES `optics`.`customer` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
