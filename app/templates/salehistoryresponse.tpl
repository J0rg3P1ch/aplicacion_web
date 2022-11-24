% include('templates/salehistory.tpl', title='HISTORICO VENTAS')
% if len(no_record_check) != 0:
    <div class="alert alert-primary" role="alert">
        <strong>{{no_record_check}}</strong>
    </div>
    % end
% end