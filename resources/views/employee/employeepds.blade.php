
@extends('master')

@section('content')
<div class="container-fluid">
  <div class="row">
    <div class="col-md-2">
      <div class="card">

        <div class="content table-responsive "">

         <ul id="tabs" class="nav nav-pills nav-stacked">
          <li class="active"><a href="#tab1" data-toggle="tab">Personal Information</a></li>
          <li><a href="#tab2" data-toggle="tab">Family Background</a></li>
          <li><a href="#tab3" data-toggle="tab">Educational Background</a></li>
          <li><a href="#tab4" data-toggle="tab">Civil Service Eligibility</a></li>
          <li><a href="#tab5" data-toggle="tab">Work Experience</a></li>   

          <li><a href="#tab6" data-toggle="tab">Voluntarily Work</a></li>

          <li><a href="#tab7" data-toggle="tab">Learning and Development</a></li>
          <li><a href="#tab8" data-toggle="tab">Other Information</a></li>
          <li><a href="#tab9" data-toggle="tab">Other Question</a></li>   
          <li><a href="#tab10" data-toggle="tab">Reference and Other Information</a></li>
          <li><a href="#tab11" data-toggle="tab">Export</a></li>


        </ul>

      </div>
    </div>
  </div>
  <div class="row" >
    <div class="col-sm-9">
      <div class="card md-form">
        <div class="tab-content">

          @include('employee/employeepds/personalinformation')

          @include('employee/employeepds/familybackground')

          @include('employee/employeepdspopup/addchildren')
          @include('employee/employeepdspopup/editchildren')
          @include('employee/employeepdspopup/deletechildren')

          @include('employee/employeepds/educationalbackground')

          @include('employee/employeepds/civilserviceelegibility')

          @include('employee/employeepds/workexperience')

          @include('employee/employeepds/voluntarilywork')

          @include('employee/employeepds/learningdevelopment')

          @include('employee/employeepds/otherinformation')

          @include('employee/employeepds/otherquestions')

          @include('employee/employeepds/references')

        </div>
      </div>
    </div>
  </div>
</div>
</div>

@section('script')
<script type="text/javascript">

  $(document).ready(function() {
    var table = $('#example').DataTable( {
      scrollY:        "300px",
      scrollX:        true,
      scrollCollapse: true,
      paging:         false,
      fixedColumns:   {
        leftColumns: 2
      }
    } );
  } );
//=====================================================================
//=====================================================================
//=====================================================================
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
    $('#childrens-table').append("<tr class='item" + data.ID + "'><td>" + data.Name + "</td><td>" + data.Birthday + "</td><td><button class='edit-modal btn btn-info' data-id='" + data.ID + "' data-name='" + data.Name + "' data-birthday='" + data.Birthday + "'><span class='glyphicon glyphicon-edit'></span></button> <button class='delete-modal btn btn-danger' data-id='" + data.ID + "' data-name='" + data.name + "'><span class='glyphicon glyphicon-trash'></span></button></td></tr>");

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



    $('.item' + data.ID).replaceWith("<tr class='item" + data.ID + "'><td>" + data.Name + "</td><td>" + data.Birthday + "</td><td><button class='edit-modal btn btn-info' data-id='" + data.ID + "' data-name='" + data.Name + "' data-birthday='" + data.Birthday + "'><span class='glyphicon glyphicon-edit'></span></button> <button class='delete-modal btn btn-danger' data-id='" + data.id + "' data-name='" + data.Name + "' ><span class='glyphicon glyphicon-trash'></span></button></td></tr>");


    $.notify({
      icon: 'ti-success',
      message: "You have successfully updated your child's name."

    },{
      type: 'success',
      timer: 4000
    });


  })



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
@endsection