from decimal import Decimal
from bottle import route,request,template

from api.DataBase.pyengineservice import EngineService


MESSAGGE = None

@route('/sale')
def sale():
    return template('templates/sale')




@route('/sale',method='POST')
def sale():
    key = request.forms.get('clave') 
    product_name = request.forms.get('nombre_producto')
    quantity = request.forms.get('cantidad')
    price = request.forms.get('precio_venta')
    if (key is None 
        or product_name is None
        or quantity is None
    ):
        MESSAGGE = "Error, valida que los campos no esten vacios"
    elif int(quantity) <= 0:
        MESSAGGE = 'Error, la cantidad del producto no debe ser negativa o igual a 0'
    elif Decimal(price) <= 0.0:
        MESSAGGE = 'Error, el precio no debe ser negativo o igual a 0'
    else:
        register_sale(key,product_name,quantity,price)
        MESSAGGE = 'La venta se realizo correctamente'
    jsonresponse={}
    jsonresponse["no_record_check"] = MESSAGGE
    return template('templates/saleresponse',dict(jsonresponse))      



def register_sale(key,product,quantity,price):
    """register_sale
    Funcion que guarda los datos en la tabla de venta

    Args:
        key (str): clave del producto
        product (str): nombre del producto
        quantity (str): cantidad vendida
        price (str): precio de venta
    """
    engine = EngineService()
    engine.set_data_config()
    db,cursor,_ = engine.get_data_engine()
    try:
        cursor.execute("SELECT clave,nombre_producto FROM `prueba`.`producto` WHERE clave ="+key+";")
        rows = cursor.fetchall()
        if rows is None:
            MESSAGGE = 'El producto no existe'
        else:
            register_stock(key,quantity,cursor,db)
            register_saledb(key,product,quantity,price,cursor,db)
    except Exception as ex:
        MESSAGGE = str(ex)
        print(MESSAGGE)
            



def register_stock(key,quantity,cursor,db):
    """register_stock
    Funcion que realiza la modificacion al inventario

    Args:
        key (str): clave del producto
        product (str): nombre del producto
        quantity (str): cantidad vendida
        price (str): precio de venta

    Returns:
        message: Alerta para el usuario
    """
    cursor.execute("SELECT cantidad_producto FROM `prueba`.`inventario` WHERE producto_id ="+key+";")
    cantidad = cursor.fetchone()
    if cantidad is not None and cantidad[0] >= int(quantity):
        total_cant = cantidad[0] - int(quantity)
        smtp_inventario = "UPDATE `prueba`.`inventario` SET cantidad_producto = "+str(total_cant)+" WHERE producto_id ="+key+";"
    else:
        MESSAGGE = "Inventario insuficiente"
    try:
        cursor.execute(smtp_inventario)
        db.commit()
        MESSAGGE = 'Guardado exitoso'
    except Exception as ex:
        MESSAGGE = str(ex)
    return MESSAGGE


def register_saledb(key,product,quantity,price,cursor,db):
    total = Decimal(price) * Decimal(quantity)
    smtp_venta = "INSERT INTO `prueba`.`venta`(cantidad,nombre_producto,producto_id,precio_venta,total) VALUES("+quantity+",'"+product+"',"+key+","+price+","+str(total)+");"
    try:
        cursor.execute(smtp_venta)
        db.commit()
        MESSAGGE = 'Guardado exitoso'
    except Exception as ex:
        MESSAGGE = str(ex)
    return MESSAGGE