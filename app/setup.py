from bottle import Bottle, route
from api.release.controller import release
from api.stock.controller import stock
from api.main.controller import inicio
from api.purchase.controller import purcharse
from api.sale.controller import sale
from api.salehistory.controller import salehistory



def routers_setup(app: Bottle) -> None:
    """routers_setup
    Es una función que valida que ruta se desea ingresar
    Args:
        app (Bottle): aplicacion bottle que recibe del main
    """
    app.route(routers=inicio)
    app.route(router=sale)
    app.route(router=release)
    app.route(router=stock)
    app.route(router=purcharse)
    app.route(router=salehistory)