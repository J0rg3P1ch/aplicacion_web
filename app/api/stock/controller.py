import json
import bottle
from json import dumps
from bottle import route,response,jinja2_view,get,template

from api.DataBase.pyengineservice import EngineService


@route('/stock')
def stock():
    """Funcion que realiza la consulta a la tabla inventario

    Returns:
        template: Se renderiza la pagina /stock con el resultado de la consulta
    """
    engine = EngineService()
    engine.set_data_config()
    _,cursor,_ = engine.get_data_engine()
    cursor.execute("SELECT clave,producto_id,cantidad_producto FROM `prueba`.`inventario`;")
    result = cursor.fetchall()
    cursor.close()
    return template('templates/stock', rows=result)