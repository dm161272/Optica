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
-- Table `optics`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`supplier` (
  `id` INT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `street_name` VARCHAR(30) NOT NULL,
  `street_num` INT UNSIGNED NOT NULL,
  `floor_num` INT UNSIGNED NULL,
  `door_num` INT UNSIGNED NULL,
  `zip` INT UNSIGNED NOT NULL,
  `country` VARCHAR(30) NOT NULL,
  `telephone` INT UNSIGNED NOT NULL,
  `fax` INT UNSIGNED NULL,
  `nif` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`brand` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `id_supplier` INT NOT NULL,
  PRIMARY KEY (`id`, `id_supplier`),
  INDEX `id_supplier_idx` (`id_supplier` ASC) VISIBLE,
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
  `frame_type` VARCHAR(10) NOT NULL,
  `frame_color` VARCHAR(10) NOT NULL,
  `glass_color` VARCHAR(10) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL DEFAULT 0,
  `quantity` INT UNSIGNED NOT NULL DEFAULT 0,
  `brand_id` INT NOT NULL,
  PRIMARY KEY (`id`, `brand_id`),
  INDEX `brand_id_idx` (`brand_id` ASC) VISIBLE,
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
  `street_num` INT UNSIGNED NOT NULL,
  `floor_num` INT UNSIGNED NOT NULL,
  `door_num` INT UNSIGNED NOT NULL,
  `country` VARCHAR(30) NOT NULL,
  `zip` INT UNSIGNED NOT NULL,
  `telephone` INT UNSIGNED NOT NULL,
  `registration_date` DATE NOT NULL,
  `referral_id` INT NOT NULL,
  PRIMARY KEY (`id`, `referral_id`),
  INDEX `fk_customer_customer1_idx` (`referral_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_customer1`
    FOREIGN KEY (`referral_id`)
    REFERENCES `optics`.`customer` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
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
  INDEX `id_employee_idx` (`id_employee` ASC) VISIBLE,
  INDEX `id_glasses_idx` (`id_glasses` ASC) VISIBLE,
  INDEX `id_customer_idx` (`id_customer` ASC) VISIBLE,
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
