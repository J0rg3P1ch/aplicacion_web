import json
import bottle
from json import dumps
from bottle import route,response,jinja2_view,get,template,request

from api.DataBase.pyengineservice import EngineService


@route('/salehistory')
def salehistory():
    return template('templates/salehistory')




@route('/salehistory', method='POST')
def salehistory():
    key = request.forms.get('clave') 
    product_name = request.forms.get('nombre')
    radioclave= request.forms.get('gridRadios1')
    radionombre = request.forms.get('gridRadios2')
    print(radioclave,radionombre)
    if(radioclave is None
       and radionombre is None
    ):
        jsonresponse={}
        jsonresponse["no_record_check"] = 'Seleccione un check(clave, nombre) para realizar la busqueda'
        return template('templates/salehistoryresponse', dict(jsonresponse))
    elif (radioclave is not None 
          and radionombre is None
    ):
        return busquedaclave(key)
    elif (radionombre is not None 
          and radioclave is None
    ):
        return busquedanombre(product_name)
        
        
        

def busquedaclave(key):
    """Funcion que realiza la busqueda en la tabla ventas por clave del producto

    Args:
        key (str): Clave del producto

    Returns:
        template: renderiza la pagina /busqueda con los datos de la consulta
    """
    if (key is None or key == ''):
        jsonresponse={}
        jsonresponse["no_record_check"] = "Dato 'clave' invalido, vuelva a intentarlo"
        return template('templates/salehistoryresponse', dict(jsonresponse))
    else:
        engine = EngineService()
        engine.set_data_config()
        _,cursor,_ = engine.get_data_engine()
        smtp = "SELECT clave,producto_id,nombre_producto,precio_venta,fecha,cantidad,total FROM venta WHERE producto_id = " + key+";"
        cursor.execute(smtp)
        result = cursor.fetchall()
        cursor.close()
        return template('templates/busqueda', rows=result)
    

def busquedanombre(product_name):
    """Funcion que realiza la busqueda en la tabla ventas por nombre del producto

    Args:
        product_name (str): Nombre del producto

    Returns:
        template: renderiza la pagina /busqueda con los datos de la consulta
    """
    if (product_name is None or product_name == ''):
        jsonresponse={}
        jsonresponse["no_record_check"] = "Dato 'product_name' invalido, vuelva a intentarlo"
        return template('templates/salehistoryresponse', dict(jsonresponse))
    else:
        engine = EngineService()
        engine.set_data_config()
        _,cursor,_ = engine.get_data_engine()
        smtp = "SELECT clave,producto_id,nombre_producto,precio_venta,fecha,cantidad,total FROM venta WHERE nombre_producto = '" + product_name+"';"
        cursor.execute(smtp)
        result = cursor.fetchall()
        cursor.close()
        return template('templates/busqueda', rows=result)