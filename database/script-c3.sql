-- MySQL Script generated by MySQL Workbench
-- Fri Mar  5 12:09:53 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DATABASE_C3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DATABASE_C3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DATABASE_C3` DEFAULT CHARACTER SET utf8 ;
USE `DATABASE_C3` ;

-- -----------------------------------------------------
-- Table `DATABASE_C3`.`commerciante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DATABASE_C3`.`commerciante` (
  `ID` VARCHAR(8) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `indirizzo` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NULL,
  `ragioneSociale` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `idcommerciante_UNIQUE` (`ID` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `ragioneSociale_UNIQUE` (`ragioneSociale` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DATABASE_C3`.`prodotto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DATABASE_C3`.`prodotto` (
  `ID` VARCHAR(8) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `prezzo` DOUBLE NOT NULL,
  `quantita` INT NOT NULL,
  `commerciante_ID` VARCHAR(8) NOT NULL,
  `URL_immagine` VARCHAR(200) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_prodottoInVendita_commerciante1_idx` (`commerciante_ID` ASC) VISIBLE,
  CONSTRAINT `fk_prodottoInVendita_commerciante1`
    FOREIGN KEY (`commerciante_ID`)
    REFERENCES `DATABASE_C3`.`commerciante` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DATABASE_C3`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DATABASE_C3`.`cliente` (
  `ID` VARCHAR(8) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cognome` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `indirizzo` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DATABASE_C3`.`corriere`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DATABASE_C3`.`corriere` (
  `ID` VARCHAR(8) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `indirizzo` VARCHAR(45) NULL,
  `ragioneSociale` VARCHAR(45) NOT NULL,
  `stato` ENUM("DISPONIBILE", "NON_DISPONIBILE") NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ragione sociale_UNIQUE` (`ragioneSociale` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DATABASE_C3`.`ritiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DATABASE_C3`.`ritiro` (
  `ID` VARCHAR(8) NOT NULL,
  `destinazione` VARCHAR(45) NOT NULL,
  `codice_ritiro` VARCHAR(45) NOT NULL,
  `data_prenotazione` DATE NOT NULL,
  `data_consegna` DATE NULL,
  `ritirato` TINYINT NOT NULL,
  `tipo_consegna` ENUM("CONSEGNA_A_DOMICILIO", "CONSEGNA_PRESSO_PUNTO") NOT NULL,
  `commerciante_ID` VARCHAR(8) NOT NULL,
  `cliente_ID` VARCHAR(8) NOT NULL,
  `corriere_ID` VARCHAR(8) NOT NULL,
  `stato_tracking` ENUM("IN_ELABORAZIONE", "PRESO_IN_CARICO", "IN_TRANSITO", "IN_CONSEGNA", "CONSEGNATO") NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `codice_ritiro_UNIQUE` (`codice_ritiro` ASC) VISIBLE,
  INDEX `fk_ritiro_commerciante1_idx` (`commerciante_ID` ASC) VISIBLE,
  INDEX `fk_ritiro_cliente1_idx` (`cliente_ID` ASC) VISIBLE,
  INDEX `fk_ritiro_corriere1_idx` (`corriere_ID` ASC) VISIBLE,
  CONSTRAINT `fk_ritiro_commerciante1`
    FOREIGN KEY (`commerciante_ID`)
    REFERENCES `DATABASE_C3`.`commerciante` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ritiro_cliente1`
    FOREIGN KEY (`cliente_ID`)
    REFERENCES `DATABASE_C3`.`cliente` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ritiro_corriere1`
    FOREIGN KEY (`corriere_ID`)
    REFERENCES `DATABASE_C3`.`corriere` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DATABASE_C3`.`ritiro_has_prodotto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DATABASE_C3`.`ritiro_has_prodotto` (
  `prodottoInVendita_ID` VARCHAR(8) NOT NULL,
  `ritiro_ID` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`prodottoInVendita_ID`, `ritiro_ID`),
  INDEX `fk_prodottoInVendita_has_ritiro_ritiro1_idx` (`ritiro_ID` ASC) VISIBLE,
  INDEX `fk_prodottoInVendita_has_ritiro_prodottoInVendita1_idx` (`prodottoInVendita_ID` ASC) VISIBLE,
  CONSTRAINT `fk_prodottoInVendita_has_ritiro_prodottoInVendita1`
    FOREIGN KEY (`prodottoInVendita_ID`)
    REFERENCES `DATABASE_C3`.`prodotto` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prodottoInVendita_has_ritiro_ritiro1`
    FOREIGN KEY (`ritiro_ID`)
    REFERENCES `DATABASE_C3`.`ritiro` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DATABASE_C3`.`promozione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DATABASE_C3`.`promozione` (
  `ID` VARCHAR(8) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descrizione` VARCHAR(500) NOT NULL,
  `data_inizio` DATE NOT NULL,
  `data_scadenza` DATE NOT NULL,
  `commerciante_ID` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_promozione_commerciante1_idx` (`commerciante_ID` ASC) VISIBLE,
  CONSTRAINT `fk_promozione_commerciante1`
    FOREIGN KEY (`commerciante_ID`)
    REFERENCES `DATABASE_C3`.`commerciante` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DATABASE_C3`.`promozione_has_prodotto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DATABASE_C3`.`promozione_has_prodotto` (
  `promozione_ID` VARCHAR(8) NOT NULL,
  `prodottoInVendita_ID` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`promozione_ID`, `prodottoInVendita_ID`),
  INDEX `fk_promozione_has_prodottoInVendita_prodottoInVendita1_idx` (`prodottoInVendita_ID` ASC) VISIBLE,
  INDEX `fk_promozione_has_prodottoInVendita_promozione1_idx` (`promozione_ID` ASC) VISIBLE,
  CONSTRAINT `fk_promozione_has_prodottoInVendita_promozione1`
    FOREIGN KEY (`promozione_ID`)
    REFERENCES `DATABASE_C3`.`promozione` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_promozione_has_prodottoInVendita_prodottoInVendita1`
    FOREIGN KEY (`prodottoInVendita_ID`)
    REFERENCES `DATABASE_C3`.`prodotto` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DATABASE_C3`.`punto_ritiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DATABASE_C3`.`punto_ritiro` (
  `ID` VARCHAR(8) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `indirizzo` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `ragione_sociale` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `ragione sociale_UNIQUE` (`ragione_sociale` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DATABASE_C3`.`recensione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DATABASE_C3`.`recensione` (
  `ID` VARCHAR(8) NOT NULL,
  `titolo` VARCHAR(45) NOT NULL,
  `testo` VARCHAR(45) NULL,
  `voto_recensione` ENUM("UNA_STELLA", "DUE_STELLE", "TRE_STELLE", "QUATTRO_STELLE", "CINQUE_STELLE") NOT NULL,
  `prodottoInVendita_ID` VARCHAR(8) NOT NULL,
  `commerciante_ID` VARCHAR(8) NOT NULL,
  `cliente_ID` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_recensione_prodottoInVendita1_idx` (`prodottoInVendita_ID` ASC) VISIBLE,
  INDEX `fk_recensione_commerciante1_idx` (`commerciante_ID` ASC) VISIBLE,
  INDEX `fk_recensione_cliente1_idx` (`cliente_ID` ASC) VISIBLE,
  CONSTRAINT `fk_recensione_prodottoInVendita1`
    FOREIGN KEY (`prodottoInVendita_ID`)
    REFERENCES `DATABASE_C3`.`prodotto` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recensione_commerciante1`
    FOREIGN KEY (`commerciante_ID`)
    REFERENCES `DATABASE_C3`.`commerciante` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recensione_cliente1`
    FOREIGN KEY (`cliente_ID`)
    REFERENCES `DATABASE_C3`.`cliente` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
