          <div class="tab-pane" id="tab2">
           <form class="form-signin" id="frm-family-background" method="POST" action="{{ route('UpdateFamilyBackground') }}">
             <input type="hidden" value="{{ $UserID[0] }}" name="EmployeeID" id="EmployeeID">
             <table class="table table-bordered table-responsive">
              <tbody><tr>
                <td  class="col-lg-3" scope="row">
                  <label for="">SPOUSE SURNAME:</label>
                </td>
                <td colspan="2"><input type="text" name="sSurname" value="{{ $empDetails[0]->sSurname }}" class="form-control " ></td>
              </tr>

              <tr>
                <td scope="row" class="col-lg-3" >
                  <label for="">FIRST NAME:</label> 
                </td>
                <td  ><input type="text" name="sFirstname" value="{{ $empDetails[0]->sFirstname }}" class="form-control " ></td>

                <td >
                  <label for="">EXTENSION NAME:</label> 
                  <input type="text" placeholder="Extension Name" class="form-control" name="sExtentionname" value="{{ $empDetails[0]->sExtentionname }}">
                </td>
              </tr>
              <tr>
                <td scope="row" class="col-lg-3">
                  <label for="">MIDDLE NAME:</label>
                </td>
                <td colspan="2"><input type="text" name="sMiddlename" value="{{ $empDetails[0]->sMiddlename }}" class="form-control " ></td>
              </tr>
              <tr>
                <td scope="row" class="col-lg-3">
                  <label for="">OCCUPATION:</label>
                </td>
                <td colspan="2"> <input type="text" name="sOccupation" value="{{ $empDetails[0]->sOccupation }}" class="form-control " ></td>
              </tr>
              <tr>
                <td scope="row" class="col-lg-3">
                  <label for="">EMPLOYER/BUSINESS NAME:</label>
                </td>
                <td colspan="2"><input type="text" name="sBusinessname" value="{{ $empDetails[0]->sBusinessname }}" class="form-control " ></td>
              </tr>
              <tr>
                <td scope="row" class="col-lg-3">
                 <label for="">BUSINESS ADDRESS:</label>
               </td>
               <td colspan="2"><input type="text" name="sBusinessaddress" value="{{ $empDetails[0]->sBusinessaddress }}" class="form-control " ></td>
             </tr>
             <tr>
              <td scope="row" class="col-lg-3">
                <label for="">TELEPHONE NO.:</label>
              </td>

              <td colspan="2"><input type="text" name="sTel"  value="{{ $empDetails[0]->sTel }}" class="form-control" >  </td>
            </tr>
            <tr>
              <td scope="row" class="col-lg-3">
               <label for="">FATHER'S  SURNAME:</label>
             </td>
             <td colspan="2"><input type="text" name="fSurname" value="{{ $empDetails[0]->fSurname }}" class="form-control " ></td>
           </tr>
           <tr>
            <td scope="row" class="col-lg-3">
             <label for="">FIRST NAME:</label>
           </td>
           <td><input type="text" name="fFirstname" value="{{ $empDetails[0]->fFirstname }}" class="form-control " ></td>

           <td>
            <label for="">EXTENSION NAME:</label> 
            <input type="text" placeholder="Extension Name" class="form-control " name="fExtensionname" value="{{ $empDetails[0]->fExtensionname }}">
          </td>
        </tr>
        <tr>
          <td scope="row" class="col-lg-3">
            <label for="">MIDDLE NAME:</label>
          </td>
          <td colspan="2"><input type="text" name="fMiddlename" value="{{ $empDetails[0]->fMiddlename }}" class="form-control " ></td>
        </tr>
        <tr>
          <td scope="row" class="col-lg-3">
           <label for="">MOTHER'S MAIDEN NAME:</label>
         </td>
         <td colspan="2"><input type="text" name="mMaidenname" value="{{ $empDetails[0]->mMaidenname }}" class="form-control " ></td>
       </tr>
       <tr>
        <td scope="row" class="col-lg-3">
         <label for="">SURNAME:</label>
       </td>
       <td colspan="2"><input type="text" name="mSurname" value="{{ $empDetails[0]->mSurname }}" class="form-control " > </td>
     </tr>
     <tr>
      <td scope="row" class="col-lg-3">
       <label for="">FIRST NAME:</label>
     </td>
     <td colspan="2"><input type="text" name="mFirstname" value="{{ $empDetails[0]->mFirstname }}" class="form-control " > </td>
   </tr>
   <tr>
    <td scope="row" class="col-lg-3">
      <label for="">MIDDLE NAME:</label>
    </td>
    <td colspan="2"> <input type="text" name="mMiddlename" value="{{ $empDetails[0]->mMiddlename }}" class="form-control " >  </td>
  </tr>
</tbody></table>

<!-- Button trigger modal -->

<div class="row">
  <div class="col-xs-12">
    <div class="text-right">
      <a href="#zxc" id="UpdateFamilyBackground"></a><button type="submit" class="btn btn-default next-tab">Save</button>
    </div>
  </div>
</div>

</form>

<table class='table table-striped table-hover' id="childrens-table" >

  <tr >
   <td class='success  col-lg-5 '>Name of Children</td>
   <td class='success  col-lg-5 '>Date of Birth</td>
   <td colspan=2 class='success  col-lg-4 text-right'>Action</td>    
 </tr>



 @foreach ($childrens as $child)
 <tr class="item{{$child->ID}}">

  <td class=''>{{$child->Name}} </td>
  <td class=''>{{$child->Birthday}}</td>

  <td>
    <button class="edit-modal btn btn-info" data-id="{{$child->ID}}"
      data-name="{{$child->Name}}" data-birthday="{{$child->Birthday}}">
      <span class="glyphicon glyphicon-edit"></span> 
    </button>
    <button id="delete-children-button" class="delete-modal btn btn-danger"
    data-id="{{$child->ID}}" data-name="{{$child->Name}}">
    <span class="glyphicon glyphicon-trash">

    </span> 
  </button>
</td>



</tr>
@endforeach

</table>
<button type="button" class="btn btn-primary pull-right" id="add-children-button">
  Add Children
</button>
</div>




@section('scriptfamilybackground')
<script type="text/javascript">

$('#frm-personal-information').on('submit', function(e){

  e.preventDefault();
  $("div").scrollTop(100)
  $('.nav-tabs > .active').next('li').find('a').trigger('click');

  var data = $(this).serialize();
  var url = $(this).attr('action');
  $.post(url,data,function(data){

  })
  $.notify({
    icon: 'ti-success',
    message: "Your Personal Information has been updated."

  },{
    type: 'success',
    timer: 4000
  });
})
//=====================================================================
//=====================================================================
//=====================================================================

$('#frm-family-background').on('submit', function(e){

  e.preventDefault();
  $("div").scrollTop(100)
  $('.nav-tabs > .active').next('li').find('a').trigger('click');

  var data = $(this).serialize();
  var url = $(this).attr('action');
  $.post(url,data,function(data){

  })
  $.notify({
    icon: 'ti-success',
    message: "Your Family Background has been updated."

  },{
    type: 'success',
    timer: 4000
  });
})


//=====================================================================
//=====================================================================
//=====================================================================
$('#frm-add-children').on('submit', function(e){

  e.preventDefault();


  var data = $(this).serialize();
  var url = $(this).attr('action');
  $.post(url,data,function(data){
    
    $('#childrens-table').append("<tr class='item" + data.ID + "'><td>" + data.Name + "</td><td>" + data.Birthday + "</td><td><button class='edit-modal btn btn-info' data-id='" + data.ID + "' data-name='" + data.Name + "' data-birthday='" + data.Birthday + "'><span class='glyphicon glyphicon-edit'></span></button> <button id='delete-children-button' class='delete-modal btn btn-danger' data-id='" + data.ID + "' data-name='" + data.name + "'><span class='glyphicon glyphicon-trash'></span></button></td></tr>");

    $.notify({
      icon: 'ti-success',
      message: data.Name + " with the birth date of " + data.Birthday + " has been added"

    },{
      type: 'success',
      timer: 4000
    });
  })
  $('#addchildren').modal('hide');
})

//=====================================================================
//=====================================================================
//=====================================================================
$('#frm-edit-children').on('submit', function(e){

  e.preventDefault();


  var data = $(this).serialize();
  var url = $(this).attr('action');

  $.post(url,data,function(data){   



    $('.item' + data.ID).replaceWith("<tr class='item" + data.ID + "'><td>" + data.Name + "</td><td>" + data.Birthday + "</td><td><button class='edit-modal btn btn-info' data-id='" + data.ID + "' data-name='" + data.Name + "' data-birthday='" + data.Birthday + "'><span class='glyphicon glyphicon-edit'></span></button> <button id='delete-children-button' class='delete-modal btn btn-danger' data-id='" + data.ID + "' data-name='" + data.name + "'><span class='glyphicon glyphicon-trash'></span></button></td></tr>");


    $.notify({
      icon: 'ti-success',
      message: "You have successfully updated your child's name."

    },{
      type: 'success',
      timer: 4000
    });


  })


  $('#editchildren').modal('hide');
})

//=====================================================================
//=====================================================================
//=====================================================================
$(document).on('click', '.edit-modal', function() {

  $('#edit-children-id').val($(this).data('id'));
  $('#edit-children-name').val($(this).data('name'));
  $('#edit-children-birthdate').val($(this).data('birthday'));


  $('#editchildren').modal('show');


});

$(document).on('click', '#add-children-button', function() {

  $('#addchildren').modal('show');

});


//=====================================================================
//=====================================================================
//=====================================================================
$(document).on('click', '#delete-children-button', function() {
  id = $('#delete-children-id').val($(this).data('id'));

  document.getElementById("dname").innerHTML = $(this).data('name');

  $('#delete-children').modal('show');

});



//=====================================================================
//=====================================================================
//=====================================================================









$('#frm-del-children').on('submit', function(e){

  e.preventDefault();


  var data = $(this).serialize();
  var url = $(this).attr('action');

  $.post(url,data,function(data){


    $(".item" + data.ID).remove();
    $.notify({
      icon: 'ti-success',
      message: "You have successfully removed " + data.Name

    },{
      type: 'success',
      timer: 4000
    });


  })


  $('#delete-children').modal('hide');
})


//=====================================================================
//=====================================================================
//=====================================================================
$('#frm-references').on('submit', function(e){

  e.preventDefault();
  $("div").scrollTop(100)
  $('.nav-tabs > .active').next('li').find('a').trigger('click');

  var data = $(this).serialize();
  var url = $(this).attr('action');
  $.post(url,data,function(data){

  })
  $.notify({
    icon: 'ti-success',
    message: "Your references has been updated."

  },{
    type: 'success',
    timer: 4000
  });
})
</script>
@endsection