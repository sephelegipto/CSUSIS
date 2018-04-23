   <div class="tab-pane content content table-responsive " id="tab6">
    <table class="table table-bordered" id="voluntarywork-table">
     <tbody>
      <tr>
       <th class="success  text-center col-lg-4 ">Name and Address of Organization</th>
       <th class="success  text-center col-lg-1 ">Inclusive Dates From</th>
       <th class="success  text-center col-lg-1 ">Inclusive Dates To</th>
       <th class="success  text-center col-lg-2 ">Number of Hours</th>
       <th class="success  text-center col-lg-3 ">Position / Nature of Work</th>
       <th colspan="2" class="success  text-center col-lg-1 text-center ">Action</th>
     </tr>
     @foreach($voluntarywork as $voluntawork)
     <tr class="voluntary{{$voluntawork->ID}}">
      <td class="col-lg-2 ">{{$voluntawork->NameOfOrg}}</td>
       <td class="col-lg-2 ">{{$voluntawork->InclusiveDateFrom}}</td> 
       <td class="col-lg-2 ">{{$voluntawork->InclusiveDateTo}}</td>
       <td class="col-lg-2 ">{{$voluntawork->NoOfHours}}</td> 
       <td class="col-lg-2 ">{{$voluntawork->Position}}</td>

       <td>
        <button class="edit-voluntarywork-button btn btn-info" data-id="{{$voluntawork}}">
          <span class="glyphicon glyphicon-edit"></span> 
        </button>
      </td>
      <td>
        <button id="delete-voluntarywork-button" class="delete-modal btn btn-danger" data-id="{{$voluntawork}}">
          <span class="glyphicon glyphicon-trash"></span> 
        </button>
      </td>
    </tr>
    @endforeach
  </tbody>
</table>
<button type="button" class="btn btn-primary pull-right" id="add-voluntarilywork-button">
  Add
</button>
</div>
