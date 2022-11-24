from bottle import route,request,jinja2_view,template,redirect


@route('/')
def inicio():
    return template('templates/index')