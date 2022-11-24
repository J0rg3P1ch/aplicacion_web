% include('templates/index.tpl', title='INVENTARIO')
<br>
<h1 class="text-center"> INVENTARIO </h1>
<div class="mx-auto" style="width: 500px;">
  <table class="table table-success table-striped">
    <thead class="thead-dark">
      <tr>
        <th scope="col">#</th>
        <th scope="col">clave</th>
        <th scope="col">cantidad</th>
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
%end