CREATE SCHEMA IF NOT EXISTS `prueba` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
-- -----------------------------------------------------
-- Table `prueba`.`producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `prueba`.`producto`;
CREATE TABLE IF NOT EXISTS `prueba`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `clave` INT NOT NULL,
  `nombre_producto` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`clave`),
  UNIQUE INDEX `idproducto_UNIQUE` (`id_producto` ASC),
  UNIQUE INDEX `claveproducto_UNIQUE` (`clave` ASC)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

-- -----------------------------------------------------
-- Table `prueba`.`invetario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `prueba`.`inventario`;
CREATE TABLE IF NOT EXISTS `prueba`.`inventario` (
  `clave` INT NOT NULL AUTO_INCREMENT,
  `producto_id` INT NOT NULL,
  `cantidad_producto` INT DEFAULT 0,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`clave`),
  UNIQUE INDEX `idinventario_UNIQUE` (`clave` ASC),
  UNIQUE INDEX `idproducto_UNIQUE` (`producto_id` ASC) 
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

-- -----------------------------------------------------
-- Table `prueba`.`inventarioproducto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `prueba`.`inventarioproducto`;
CREATE TABLE IF NOT EXISTS `prueba`.`inventarioproducto` (
  `clave` INT NOT NULL AUTO_INCREMENT,
  `producto_id` INT NOT NULL,
  `inventario_id` INT NOT NULL,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`clave`),
  UNIQUE INDEX `inventarioproducto_UNIQUE` (`clave` ASC),
  INDEX `fk_inventarioproducto_product1_idx` (`producto_id` ASC),
  CONSTRAINT `fk_inventarioproducto_producto1`
    FOREIGN KEY (`producto_id`)
    REFERENCES `prueba`.`producto` (`clave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  INDEX `fk_inventarioproducto_inventario1_idx` (`inventario_id` ASC),
  CONSTRAINT `fk_inventarioproducto_inventario1`
    FOREIGN KEY (`inventario_id`)
    REFERENCES `prueba`.`inventario` (`clave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

-- -----------------------------------------------------
-- Table `prueba`.`venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `prueba`.`venta`;
CREATE TABLE IF NOT EXISTS `prueba`.`venta` (
  `clave` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT DEFAULT 0,
  `producto_id` INT NOT NULL,
  `nombre_producto` VARCHAR(50) NOT NULL,
  `precio_venta` DECIMAL DEFAULT 0.0,
  `total` DECIMAL DEFAULT 0.0,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`clave`),
  UNIQUE INDEX `idventa_UNIQUE` (`clave` ASC)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

 -----------------------------------------------------
-- Table `prueba`.`historicoventa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `prueba`.`historicoventa`;
CREATE TABLE IF NOT EXISTS `prueba`.`historicoventa` (
  `clave` INT NOT NULL AUTO_INCREMENT,
  `producto_id` INT NOT NULL,
  `gran_total` DECIMAL DEFAULT 0.0,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`clave`),
  UNIQUE INDEX `idventa_UNIQUE` (`clave` ASC),
  UNIQUE INDEX `productoid_UNIQUE` (`producto_id` ASC)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

-- -----------------------------------------------------
-- Table `prueba`.`ventashistorico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `prueba`.`ventashistorico`;
CREATE TABLE IF NOT EXISTS `prueba`.`ventashistorico` (
  `clave` INT NOT NULL AUTO_INCREMENT,
  `producto_id` INT NOT NULL,
  `venta_id` INT NOT NULL,
  `historicoventa_id` INT NOT NULL,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`clave`),
  UNIQUE INDEX `ventashistorico_UNIQUE` (`clave` ASC),
  INDEX `fk_ventashistorico_productoid1_idx` (`producto_id` ASC),
  CONSTRAINT `fk_ventashistorico_venta1`
    FOREIGN KEY (`venta_id`)
    REFERENCES `prueba`.`venta` (`producto_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  INDEX `fk_ventashistorico_historicoventa1_idx` (`historicoventa_id` ASC),
  CONSTRAINT `fk_ventashistorico_historicoventa1`
    FOREIGN KEY (`historicoventa_id`)
    REFERENCES `prueba`.`historicoventa` (`clave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

-- -----------------------------------------------------
-- Table `prueba`.`compra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `prueba`.`compra`;
CREATE TABLE IF NOT EXISTS `prueba`.`compra` (
  `clave` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT DEFAULT 0,
  `nombre_producto` VARCHAR(50) NOT NULL,
  `producto_id` INT NOT NULL,
  `precio_compra` DECIMAL DEFAULT 0.0,
  `total` DECIMAL DEFAULT 0.0,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`clave`),
  UNIQUE INDEX `idventa_UNIQUE` (`clave` ASC)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

-- -----------------------------------------------------
-- Table `prueba`.`registraventas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `prueba`.`registraventas`;
CREATE TABLE IF NOT EXISTS `prueba`.`registraventas` (
  `clave` INT NOT NULL AUTO_INCREMENT,
  `producto_id` INT NOT NULL,
  `inventario_id` INT NOT NULL,
  `ventas_id` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`clave`),
  UNIQUE INDEX `idregistraventas_UNIQUE` (`clave` ASC),
  INDEX `fk_registraventas_inventario1_idx` (`inventario_id` ASC),
  CONSTRAINT `fk_registraventas_inventario1`
    FOREIGN KEY (`inventario_id`)
    REFERENCES `prueba`.`inventario` (`producto_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  INDEX `fk_registraventas_venta1_idx` (`ventas_id` ASC),
  CONSTRAINT `fk_registraventas_venta1`
    FOREIGN KEY (`ventas_id`)
    REFERENCES `prueba`.`venta` (`clave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

-- -----------------------------------------------------
-- Table `prueba`.`registracompra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `prueba`.`registracompra`;
CREATE TABLE IF NOT EXISTS `prueba`.`registracompra` (
  `clave` INT NOT NULL AUTO_INCREMENT,
  `inventario_id` INT NOT NULL,
  `compra_id` INT NOT NULL,
  `precio_compra` DECIMAL DEFAULT 0.0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`clave`),
  UNIQUE INDEX `idregistracompra_UNIQUE` (`clave` ASC),
  INDEX `fk_registracompra_inventario1_idx` (`inventario_id` ASC),
  CONSTRAINT `fk_registracompra_inventario1`
    FOREIGN KEY (`inventario_id`)
    REFERENCES `prueba`.`inventario` (`producto_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  INDEX `fk_registracompra_compra1_idx` (`compra_id` ASC),
  CONSTRAINT `fk_registracompra_compra1`
    FOREIGN KEY (`compra_id`)
    REFERENCES `prueba`.`compra` (`clave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;