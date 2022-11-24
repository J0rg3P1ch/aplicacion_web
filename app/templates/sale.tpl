% include('templates/index.tpl', title='VENTA')
    <br>
    <h1 class="text-center"> VENTA </h1>
    <div class="container-fluid">
      <form class="row gx-3 gy-2 align-items-center" method="post">
        <div class="col-auto">
          <label class="visually-hidden" for="specificSizeInputNumber">Cantidad</label>
          <input type="number" class="form-control"  name="cantidad" placeholder="0" id="numero1" onchange="operacion();" >
        </div>
        <div class="col-auto">
          <label class="visually-hidden" for="specificSizeInputNumber">clave</label>
          <input type="number" class="form-control" id="specificSizeInputNumber" name="clave" placeholder="clave">
        </div>
        <div class="col-auto">
          <label class="visually-hidden" for="specificSizeInputName">Nombre producto</label>
          <input type="text" class="form-control" id="specificSizeInputName" name="nombre_producto" placeholder="nombre del producto">
        </div>
        <div class="col-auto" class="input-group mb-3">
          <input type="text" class="form-control"  aria-label="Precio Compra" name="precio_venta" placeholder="Precio venta $0.0" id="numero2" onchange="sumar();">
        </div>
        <div class="col-auto" class="input-group mb-3">
          <input class="form-control" type="text" placeholder="Total" aria-label="Total" name="total" id="total" disabled>
        </div>
        <div class="col-auto">
          <button type="submit" class="btn btn-primary">Vender</button>
        </div>
      </form>
    </div>
      <script>
        // si la respuesta que se espera es 
        function operacion(){
          var numero1 = document.getElementById('numero1').value;
          var numero2 = document.getElementById('numero2').value;
    
            if(numero1!=='' && numero2!==''){
                var suma = parseFloat(numero1)*parseFloat(numero2);
                document.getElementById('total').value = suma;
            }
        }
      </script>
%