    <div class="tab-pane content content table-responsive " id="tab8">
      <table class="table table-striped table-hover" id="othinfo-table">
        <tbody><tr>
          <th class="success  text-center col-lg-3">Special Skill and Hobbies</th>
          <th class="success  text-center col-lg-3">Non-Academic Distinction/ Recognition</th>
          <th class="success  text-center col-lg-3">Membership in Association/ Organization</th>
          <th colspan="2" class="text-center success  col-lg-1">Action</th>
        </tr>
        @foreach($otherinfo as $info)
        <tr class="empotherinfo{{$info->ID}}">
         <td class="col-lg-2 ">{{$info->Skills}}</td>
         <td class="col-lg-2 ">{{$info->Recognition}}</td>
         <td class="col-lg-2 ">{{$info->Organization}}</td>
         <td>
          <button class="edit-otherinformation-button btn btn-info" data-id="{{$info}}">
            <span class="glyphicon glyphicon-edit"></span> 
          </button>
        </td>
        <td>
          <button id="delete-otherinformation-button" class="delete-modal btn btn-danger" data-id="{{$info}}">
            <span class="glyphicon glyphicon-trash"></span> 
          </button>
        </td>


      </tr>
      @endforeach
    </tbody></table>
    <button type="button" class="btn btn-primary pull-right" id="add-otherinformation-button">
      Add
    </button>
  </div>