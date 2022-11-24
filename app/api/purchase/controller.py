from decimal import Decimal
from bottle import route,request,jinja2_view,template,redirect

from api.DataBase.pyengineservice import EngineService
from complementos.complementos import register_stock

@route('/purchase')
def purcharse():
    return template('templates/purchase')

@route('/purchase', method='POST')
def purchase():
    key = request.forms.get('clave') 
    product_name = request.forms.get('nombre_producto')
    quantity = request.forms.get('cantidad')
    price = request.forms.get('precio_compra')
    print(type(quantity))
    if ((key is None or key == '') 
        or (product_name is None or product_name == '')
        or (quantity is None or quantity == '')
    ):
        message = "Error, valida que los campos no esten vacios"
    else:
        message= register_purchase(key,product_name,quantity,price)
    jsonresponse={}
    jsonresponse["no_record_check"] = message
    return template('templates/purchaseresponse',dict(jsonresponse))


def register_purchase(key,product,quantity,price):
    """register_purchase

    Args:
        key (str): clave del producto
        product (str): nombre del producto
        quantity (str): cantidad
        price (str): precio de la compra

    Returns:
        Message: Alertas para el usuario
    """
    engine = EngineService()
    engine.set_data_config()
    db,cursor,_ = engine.get_data_engine()
    try:
        cursor.execute("SELECT clave,nombre_producto FROM `prueba`.`producto` WHERE clave ="+key+";")
        rows = cursor.fetchall()
        if rows is  not None:
            message = register_stock(key,cursor,db,quantity)
            message = register_purchasedb(key,product,quantity,price,cursor,db)
    except Exception as ex:
        message = 'Error, valide los datos de la compra'
    return message
        




def register_purchasedb(key,product,quantity,price,cursor,db):
    """register_purchasedb
    PAra guardar informacion en base de datos de compras
    Args:
        key (str): clave del producto
        product (str): nombre del producto
        quantity (str): cantidad
        price (str): precio de la compra

    Returns:
        Message: Alertas para el usuario
    """
    total = Decimal(price) * Decimal(quantity)
    smtp_compras = "INSERT INTO `prueba`.`compra`(cantidad,nombre_producto,producto_id,precio_compra,total) VALUES("+quantity+",'"+product+"',"+key+","+price+","+str(total)+");"
    try:
        cursor.execute(smtp_compras)
        db.commit()
        message = 'Guardado exitoso'
    except Exception as ex:
        message = str(ex)
    return message