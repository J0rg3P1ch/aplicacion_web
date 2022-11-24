% include('templates/release.tpl', title='ALTA DE PRODUCTOS')
    % if len(no_record_check) != 0:
    <div class="alert alert-primary" role="alert">
        <strong>{{no_record_check}}</strong>
    </div>
    % end
% end