import json
from bottle import route,request,template

from api.DataBase.pyengineservice import EngineService
from complementos.complementos import register_stock



@route('/release')
def release():
    return template('templates/release')



@route('/release', method='POST')
def release():
    key = request.forms.get('clave') 
    product_name = request.forms.get('nombre_producto')
    message = insertdb(key,product_name)
    jsonresponse={}
    jsonresponse["no_record_check"] = message
    return template('templates/releaseresponse',dict(jsonresponse))




def insertdb(key,product):
    """insertdb

    Args:
        key (str): clave de producto
        product (str): nombre de producto

    Returns:
        str: mensaje que funciona como alerta
    """
    smtp = "INSERT INTO `prueba`.`producto`(clave,nombre_producto) VALUES("+key+",'"+product+"');"
    engine = EngineService()
    engine.set_data_config()
    db,cursor,_ = engine.get_data_engine()
    try:
        cursor.execute(smtp)
        db.commit()
        message =  register_stock(key,cursor,db)
        cursor.close()
    except Exception as ex:
        message = str(ex)
        if message.find('Duplicate entry') == -1:
            message = 'No se puedo guardar la informacion, intentelo nuevamente'
        else:
            message = "Valor 'Clave' esta siendo duplicada, intentelo nuevamente"
    return message    

        
        