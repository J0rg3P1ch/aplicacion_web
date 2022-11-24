def register_stock(key,cursor,db,quantity = 0):
    """register_stock
    Esta funcion guarda en el inventario la informacion

    Args:
        key (str): clave del producto
        quantity (int, optional): cantidad del producto. Defaults to 0.

    Returns:
        menssage: mensaje que funciona como alerta
    """
    if quantity != 0:
        cursor.execute("SELECT cantidad_producto FROM `prueba`.`inventario` WHERE producto_id ="+key+";")
        cantidad = cursor.fetchone()
        if cantidad[0] == None:
            total_cant = int(quantity)
        else:
            total_cant = int(quantity) + cantidad[0]
            print(total_cant)
        smtp_inventario = "UPDATE `prueba`.`inventario` SET cantidad_producto = "+str(total_cant)+" WHERE producto_id ="+key+";"
        try:
            cursor.execute(smtp_inventario)
            db.commit()
            message = 'Guardado exitoso'
        except Exception as ex:
            message = str(ex)
            if message.find('Duplicate entry') == -1:
                message = 'No se puedo guardar la informacion, intentelo nuevamente'
            else:
                message = "Valor 'Clave' esta siendo duplicada, intentelo nuevamente"
    else:
        smtp_inventario = "INSERT INTO `prueba`.`inventario`(producto_id) VALUES("+key+");"
        try:
            cursor.execute(smtp_inventario)
            db.commit()
            message = 'Guardado exitoso'
        except Exception as ex:
            message = str(ex)
            if message.find('Duplicate entry') == -1:
                message = 'No se puedo guardar la informacion, intentelo nuevamente'
            else:
                message = "Valor 'Clave' esta siendo duplicada, intentelo nuevamente"
    return message