
@extends('master')

@section('content')
<div class="container-fluid ">
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
          @include('employee/employeepdspopup/addcseligibility')
          @include('employee/employeepdspopup/editcseligibility')
          @include('employee/employeepdspopup/deletecseligibility')

          @include('employee/employeepds/workexperience')
          @include('employee/employeepdspopup/addworkexperience')
          @include('employee/employeepdspopup/editworkexperience')
          @include('employee/employeepdspopup/deleteworkexperience')

          @include('employee/employeepds/voluntarilywork')
          @include('employee/employeepdspopup/addvoluntarilywork')
          @include('employee/employeepdspopup/editvoluntarilywork')
          @include('employee/employeepdspopup/deletevoluntarilywork')

          @include('employee/employeepds/learningdevelopment')
          @include('employee/employeepdspopup/addlearningdevelopment')
          @include('employee/employeepdspopup/editlearningdevelopment')
          @include('employee/employeepdspopup/deletelearningdevelopment')

          @include('employee/employeepds/otherinformation')
          @include('employee/employeepdspopup/addotherinformation')
          @include('employee/employeepdspopup/editotherinformation')
          @include('employee/employeepdspopup/deleteotherinformation')

          @include('employee/employeepds/otherquestions')

          @include('employee/employeepds/references')

        </div>
      </div>
    </div>
  </div>
</div>
</div>


@section('script')

@yield('scriptfamilybackground')
@yield('scriptcivilserviceeligibility')
<script>
 $(document).on('click', '#add-otherinformation-button', function() {
  $('#add-otherinformation').modal('show');
});


 $(document).on('click', '#add-workexperience-button', function() {
  $('#add-workexperience').modal('show');
});
 $(document).on('click', '#add-learningdevelopment-button', function() {
  $('#add-learningdevelopment').modal('show');
});
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$('#frm-add-otherinformation').on('submit', function(e){
  e.preventDefault();

  var data = $(this).serialize();
  var url = $(this).attr('action');
  $.post(url,data,function(data){

    $('#othinfo-table').append(
      "<tr class='empotherinfo" + ( data.ID || '') + "'>" +
      "<td>" + ( data.Skills || '') + "</td><td> " +
      ( data.Recognition || '') + "</td><td>" +
      ( data.Organization || '') + "</td><td>" +

      "<button class='edit-otherinfo-button btn btn-info' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-edit'></span></button></td><td> <button id='delete-otherinfo-button' class='delete-modal btn btn-danger' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-trash'></span></button></td></tr>");

    $.notify({
      icon: 'ti-success',
      message: "You have successfully added " + data.Skills + " in your other information"
    },{
      type: 'success',
      timer: 4000
    });
  })
  $('#add-otherinformation').modal('hide');
})
$(document).on('click', '.edit-otherinformation-button', function() {
  $('#edit-otherinfo-ID').val($(this).data('id').ID);
  $('#edit-otherinfo-Skills').val($(this).data('id').Skills);
  $('#edit-otherinfo-Recognition').val($(this).data('id').Recognition);
  $('#edit-otherinfo-Organization').val($(this).data('id').Organization);

  $('#editotherinformation').modal('show');
});
//====
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$('#frm-edit-otherinformation').on('submit', function(e){
  e.preventDefault();

  var data = $(this).serialize();
  var url = $(this).attr('action');

  $.post(url,data,function(data){
    $('.empotherinfo' + data.ID).replaceWith("<tr class='empotherinfo" + data.ID + "'>" +
     "<td>" + ( data.Skills || '') + "</td><td> " +
     ( data.Recognition || '') + "</td><td>" +
     ( data.Organization || '') + "</td><td>" +
   
     "<button class='edit-otherinformation-button btn btn-info' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-edit'></span></button></td><td> <button id='delete-otherinformation-button' class='delete-modal btn btn-danger' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-trash'></span></button></td></tr>");

    $.notify({
      icon: 'ti-success',
      message: "You have successfully updated your Other Information."

    },{
      type: 'success',
      timer: 4000
    });
  })

  $('#editotherinformation').modal('hide');
})
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$(document).on('click', '#delete-otherinformation-button', function() {
  $('#delete-otherinformation-id').val($(this).data('id').ID);

  document.getElementById("delotherinfo").innerHTML = $(this).data('id').Skills;

  $('#deleteotherinfomation').modal('show');

});

//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$('#frm-del-otherinformation').on('submit', function(e){

  e.preventDefault();


  var data = $(this).serialize();
  var url = $(this).attr('action');

  $.post(url,data,function(data){


  
    $.notify({
      icon: 'ti-success',
      message: "You have successfully removed " + data.Skills

    },{
      type: 'success',
      timer: 4000
    });

  $(".empotherinfo" + data.ID).remove();
  })


  $('#deleteotherinfomation').modal('hide');
})
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================

$('#frm-add-learningdevelopment').on('submit', function(e){
  e.preventDefault();

  var data = $(this).serialize();
  var url = $(this).attr('action');
  $.post(url,data,function(data){

    $('#learndev-table').append(
      "<tr class='learndev" + ( data.ID || '') + "'>" +
      "<td>" + ( data.Title || '') + "</td><td> " +
      ( data.InclusiveDateFrom || '') + "</td><td>" +
      ( data.InclusiveDateTo || '') + "</td><td>" +
      ( data.NoOfHours || '') + "</td><td>" +
      ( data.TypeOfLD || '') + "</td><td>" +
      ( data.ConductedBy || '') + "</td><td>" +
      "<button class='edit-learningdevelopment-button btn btn-info' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-edit'></span></button></td><td> <button id='delete-learningdevelopment-button' class='delete-modal btn btn-danger' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-trash'></span></button></td></tr>");

    $.notify({
      icon: 'ti-success',
      message: "You have successfully added " + data.Title + " in your Learning and Development"
    },{
      type: 'success',
      timer: 4000
    });
  })
  $('#add-learningdevelopment').modal('hide');
})
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$(document).on('click', '#add-voluntarilywork-button', function() {
  $('#add-voluntarilywork').modal('show');
});
 //===============================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$('#frm-add-voluntarywork').on('submit', function(e){
  e.preventDefault();

  var data = $(this).serialize();
  var url = $(this).attr('action');
  $.post(url,data,function(data){

    $('#voluntarywork-table').append(
      "<tr class='voluntary" + ( data.ID || '') + "'>" +
      "<td>" + ( data.NameOfOrg || '') + "</td><td> " +
      ( data.InclusiveDateFrom || '') + "</td><td>" +
      ( data.InclusiveDateTo || '') + "</td><td>" +
      ( data.NoOfHours || '') + "</td><td>" +
      ( data.Position || '') + "</td><td>" +

      "<button class='edit-voluntarywork-button btn btn-info' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-edit'></span></button></td><td> <button id='delete-voluntarywork-button' class='delete-modal btn btn-danger' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-trash'></span></button></td></tr>");

    $.notify({
      icon: 'ti-success',
      message: "You have successfully added " + data.NameOfOrg + " in your Voluntarily Work"


    },{
      type: 'success',
      timer: 4000
    });
  })
  $('#add-voluntarilywork').modal('hide');
})
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$(document).on('click', '.edit-voluntarywork-button', function() {

  $('#edit-voluntary-ID').val($(this).data('id').ID);
  $('#edit-voluntary-NameOfOrg').val($(this).data('id').NameOfOrg);
  $('#edit-voluntary-InclusiveDateFrom').val($(this).data('id').InclusiveDateFrom);
  $('#edit-voluntary-InclusiveDateTo').val($(this).data('id').InclusiveDateTo);
  $('#edit-voluntary-NoOfHours').val($(this).data('id').NoOfHours);
  $('#edit-voluntary-Position').val($(this).data('id').Position);


  $('#editvoluntarilywork').modal('show');
});
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$(document).on('click', '.edit-learningdevelopment-button', function() {
  $('#edit-learningdevelopment-ID').val($(this).data('id').ID);
  $('#edit-learningdevelopment-Title').val($(this).data('id').Title);
  $('#edit-learningdevelopment-InclusiveDateFrom').val($(this).data('id').InclusiveDateFrom);
  $('#edit-learningdevelopment-InclusiveDateTo').val($(this).data('id').InclusiveDateTo);
  $('#edit-learningdevelopment-NoOfHours').val($(this).data('id').NoOfHours);
  $('#edit-learningdevelopment-TypeOfLD').val($(this).data('id').TypeOfLD);
  $('#edit-learningdevelopment-ConductedBy').val($(this).data('id').ConductedBy);
  $('#editlearningdevelopment').modal('show');
});
//====
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$('#frm-edit-learningdevelopment').on('submit', function(e){
  e.preventDefault();

  var data = $(this).serialize();
  var url = $(this).attr('action');

  $.post(url,data,function(data){
    $('.learndev' + data.ID).replaceWith("<tr class='learndev" + data.ID + "'>" +
     "<td>" + ( data.Title || '') + "</td><td> " +
     ( data.InclusiveDateFrom || '') + "</td><td>" +
     ( data.InclusiveDateTo || '') + "</td><td>" +
     ( data.NoOfHours || '') + "</td><td>" +
     ( data.TypeOfLD || '') + "</td><td>" +
     ( data.ConductedBy || '') + "</td><td>" +
     "<button class='edit-learningdevelopment-button btn btn-info' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-edit'></span></button></td><td> <button id='delete-learningdevelopment-button' class='delete-modal btn btn-danger' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-trash'></span></button></td></tr>");

    $.notify({
      icon: 'ti-success',
      message: "You have successfully updated your Learning and Development."

    },{
      type: 'success',
      timer: 4000
    });
  })

  $('#editlearningdevelopment').modal('hide');
})
//====
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$('#frm-edit-voluntarywork').on('submit', function(e){
  e.preventDefault();

  var data = $(this).serialize();
  var url = $(this).attr('action');

  $.post(url,data,function(data){
    $('.voluntary' + data.ID).replaceWith("<tr class='voluntary" + data.ID + "'>" +
     "<td>" + ( data.NameOfOrg || '') + "</td><td> " +
     ( data.InclusiveDateFrom || '') + "</td><td>" +
     ( data.InclusiveDateTo || '') + "</td><td>" +
     ( data.NoOfHours || '') + "</td><td>" +
     ( data.Position || '') + "</td><td>" +
     
     "<button class='edit-voluntarywork-button btn btn-info' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-edit'></span></button></td><td> <button id='delete-voluntarywork-button' class='delete-modal btn btn-danger' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-trash'></span></button></td></tr>");

    $.notify({
      icon: 'ti-success',
      message: "You have successfully updated your learning development."

    },{
      type: 'success',
      timer: 4000
    });
  })

  $('#editvoluntarilywork').modal('hide');
})
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$(document).on('click', '#delete-voluntarywork-button', function() {
  $('#delete-voluntary-id').val($(this).data('id').ID);

  document.getElementById("voluntary").innerHTML = $(this).data('id').NameOfOrg;

  $('#deletevoluntarywork').modal('show');

});
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================

$(document).on('click', '#delete-learningdevelopment-button', function() {

  $('#delete-learningdev-id').val($(this).data('id').ID);

  document.getElementById("deletelearningdev").innerHTML = $(this).data('id').Title;

  $('#deletelearningdevelopment').modal('show');

});
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$('#frm-del-learningdevelopment').on('submit', function(e){

  e.preventDefault();


  var data = $(this).serialize();
  var url = $(this).attr('action');

  $.post(url,data,function(data){


    $(".learndev" + data.ID).remove();
    $.notify({
      icon: 'ti-success',
      message: "You have successfully removed " + data.Title

    },{
      type: 'success',
      timer: 4000
    });


  })


  $('#deletelearningdevelopment').modal('hide');
})
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$(document).on('click', '#delete-voluntarywork-button', function() {
  $('#delete-voluntary-id').val($(this).data('id').ID);

  document.getElementById("voluntary").innerHTML = $(this).data('id').NameOfOrg;

  $('#deletevoluntarywork').modal('show');

});
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$('#frm-del-voluntary').on('submit', function(e){

  e.preventDefault();


  var data = $(this).serialize();
  var url = $(this).attr('action');

  $.post(url,data,function(data){


    $(".voluntary" + data.ID).remove();
    $.notify({
      icon: 'ti-success',
      message: "You have successfully removed " + data.NameOfOrg

    },{
      type: 'success',
      timer: 4000
    });


  })


  $('#deletevoluntarywork').modal('hide');
})
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$('#frm-add-workexperience').on('submit', function(e){
  e.preventDefault();

  var data = $(this).serialize();
  var url = $(this).attr('action');
  $.post(url,data,function(data){

    $('#workexperience-table').append(
      "<tr class='workexperience" + ( data.ID || '') + "'>" +
      "<td>" + ( data.InclusiveDateFrom || '') + "</td><td> " +
      ( data.InclusiveDateTo || '') + "</td><td>" +
      ( data.Position || '') + "</td><td>" +
      ( data.Department || '') + "</td><td>" +
      ( data.MonthlySalary || '') + "</td><td>" +
      ( data.JobPay || '') + "</td><td>" +
      ( data.StatusAppointment || '') + "</td><td>" +
      ( data.GovernmentService || '') + "</td><td>" +
      "<button class='edit-workexperience-button btn btn-info' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-edit'></span></button></td><td> <button id='delete-workexperience-button' class='delete-modal btn btn-danger' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-trash'></span></button></td></tr>");

    $.notify({
      icon: 'ti-success',
      message: "You have successfully added " + data.Title + " in your Work Experience"
    },{
      type: 'success',
      timer: 4000
    });
  })
  $('#add-workexperience').modal('hide');
})
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$(document).on('click', '.edit-workexperience-button', function() {

  $('#edit-workexperience-ID').val($(this).data('id').ID);
  $('#edit-workexperience-InclusiveDateFrom').val($(this).data('id').InclusiveDateFrom);
  $('#edit-workexperience-InclusiveDateTo').val($(this).data('id').InclusiveDateTo);
  $('#edit-workexperience-Position').val($(this).data('id').Position);
  $('#edit-workexperience-Department').val($(this).data('id').Department);
  $('#edit-workexperience-MonthlySalary').val($(this).data('id').MonthlySalary);
  $('#edit-workexperience-JobPay').val($(this).data('id').JobPay);
  $('#edit-workexperience-StatusAppointment').val($(this).data('id').StatusAppointment);
  $('#edit-workexperience-GovernmentService').val($(this).data('id').GovernmentService);

  $('#editworkexperience').modal('show');
});
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$('#frm-edit-workexperience').on('submit', function(e){
  e.preventDefault();

  var data = $(this).serialize();
  var url = $(this).attr('action');

  $.post(url,data,function(data){
    $('.workexperience' + data.ID).replaceWith("<tr class='workexperience" + data.ID + "'>" +
     "<td>" + ( data.InclusiveDateFrom || '') + "</td><td> " +
     ( data.InclusiveDateTo || '') + "</td><td>" +
     ( data.Position || '') + "</td><td>" +
     ( data.Department || '') + "</td><td>" +
     ( data.MonthlySalary || '') + "</td><td>" +
     ( data.JobPay || '') + "</td><td>" +
     ( data.StatusAppointment || '') + "</td><td>" +
     ( data.GovernmentService || '') + "</td><td>" +
     "<button class='edit-workexperience-button btn btn-info' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-edit'></span></button></td><td> <button id='delete-workexperience-button' class='delete-modal btn btn-danger' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-trash'></span></button></td></tr>");

    $.notify({
      icon: 'ti-success',
      message: "You have successfully updated your work experience."

    },{
      type: 'success',
      timer: 4000
    });
  })

  $('#editworkexperience').modal('hide');
})
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$(document).on('click', '#delete-workexperience-button', function() {
  $('#delete-workexperience-id').val($(this).data('id').ID);

  document.getElementById("workexp").innerHTML = $(this).data('id').Position;

  $('#deleteworkexperience').modal('show');

});
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
//================================================================================================
$('#frm-del-workexperience').on('submit', function(e){

  e.preventDefault();


  var data = $(this).serialize();
  var url = $(this).attr('action');

  $.post(url,data,function(data){


    $(".workexperience" + data.ID).remove();
    $.notify({
      icon: 'ti-success',
      message: "You have successfully removed " + data.CareerService

    },{
      type: 'success',
      timer: 4000
    });


  })


  $('#deleteworkexperience').modal('hide');
})
</script>
@endsection
@endsection