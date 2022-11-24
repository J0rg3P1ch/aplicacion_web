% include('templates/salehistoryhead.tpl', title='HISTORICO VENTAS')
    <div class="container-fluid">
        <form  method="post" class="mx-auto" style="width: 800px;">
        <fieldset class="row mb-3">
            <legend class="col-form-label col-sm-2 pt-0">Seleccione como desea la busqueda del historico:</legend>
            <div class="col-sm-10">
            <div class="form-check">
                <input class="form-check-input" type="radio" name="gridRadios1" id="claves" value="option1"  onchange="operacionhabilitar()">
                <label class="form-check-label" for="gridRadios1">
                Clave del producto
                </label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="gridRadios2" id="nombres" value="option2"  onchange="operacionhabilitarnombre()">
                <label class="form-check-label" for="gridRadios2">
                Nombre del producto
                </label>
            </div>
            </div>
        </fieldset>
        <div class="row mb-3" id="clave">
            <label for="inputText3" class="col-sm-2 col-form-label">Clave</label>
            <div class="col-sm-10">
            <input type="text" class="form-control" id="clave" name="clave">
            </div>
        </div>
        <div class="row mb-3" id="nombre">
            <label for="inputText3" class="col-sm-2 col-form-label">Nombre producto</label>
            <div class="col-sm-10">
            <input type="nombre_producto" class="form-control" name="nombre" id="nombre" >
            </div>
        </div>
        <button type="submit" class="btn btn-primary" id="reinicio">Mostrar</button>
        </form>

        <script>
        function operacionhabilitar(){
            document.getElementById('nombre').style.display = 'none';
            document.getElementById('clave').style.display = 'block';
        }
        function operacionhabilitarnombre(){
            document.getElementById('clave').style.display = 'none';
            document.getElementById('nombre').style.display = 'block';
        }
    </script>
    </div>
%end