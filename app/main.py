from bottle import Bottle, run
from setup import routers_setup


app = Bottle()




routers_setup(app)




run(host='localhost', port=8000, debug=True, reloader=True)