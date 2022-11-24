% include('templates/salehistoryhead.tpl', title='HISTORICO VENTAS')
<div class="mx-auto">
    <table class="table table-success table-striped">
      <thead class="thead-dark">
        <tr>
          <th scope="col">#</th>
          <th scope="col">producto id</th>
          <th scope="col">nombre producto</th>
          <th scope="col">precio venta</th>
          <th scope="col">fecha</th>
          <th scope="col">cantidad</th>
          <th scope="col">total</th>
        </tr>
      </thead>
      <tbody>
        %for row in rows:
        <tr>
          %for col in row:
          <td>{{col}}</td>
          %end
        </tr>
        %end
      </tbody>
    </table>
  </div>
  <div class="text-end">
      %granTotal = 0
      %for i in range(len(rows)):
        %granTotal += rows[i][6] 
      %end
      %granTotal = str(granTotal)
      %print(granTotal)
      <div class="text-center">
      <label for="inputText3">Gran total</label>
      
      <input type="number" placeholder="{{granTotal}}", disabled>
  </div
%end