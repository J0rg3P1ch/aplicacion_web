% include('templates/index.tpl', title='ALTA DE PRODUCTOS')
        <div class="text-center">
            <h1 > ALTA DE PRODUCTOS </h1>
        </div>
        <div class="mx-auto" style="width: 200px;">
            <form action="/release" method="post" class="center">
                <div class="mb-3" class="align-middle">
                    clave: <input class="align-middle" name="clave" type="number" class="align-middle"  class="form-control" id="exampleInputNumber2"/>
                </div>
                <div class="mb-3" class="align-middle">
                    nombre producto: <input  class="align-middle" name="nombre_producto" type="text" class="align-middle" class="form-control" id="exampleInputText2"/>
                </div>
                <input value="Guardar" type="submit" id="guardar"/>
                
            </form>
        </div>
        
        
% end