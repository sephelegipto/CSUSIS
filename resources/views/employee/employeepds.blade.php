
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

@yield('scriptfamilybackground')
@yield('scriptcivilserviceeligibility')
<script>

  $(document).on('click', '#add-workexperience-button', function() {
    $('#add-workexperience').modal('show');
  });

  $('#frm-add-workexperience').on('submit', function(e){
    e.preventDefault();

    var data = $(this).serialize();
    var url = $(this).attr('action');
    $.post(url,data,function(data){

      $('#workexperience-table').append(
        "<tr class='workexperience" + data.ID + "'>" +
        "<td>" + data.InclusiveDateFrom + "</td> " +
        data.InclusiveDateTo + "</td><td>" +
        data.Position + "</td><td>" +
        data.Department + "</td><td>" +
        data.MonthlySalary + "</td><td>" +
        data.JobPay + "</td><td>" +
        data.StatusAppointment + "</td><td>" +
        data.GovernmentService + "</td><td>" +
        "<button class='edit-workexperience-button btn btn-info' data-id='" + JSON.stringify(data, replacer) + "'><span class='glyphicon glyphicon-edit'></span></button></td><td> <button id='delete-workexperience-button' class='delete-modal btn btn-danger' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-trash'></span></button></td></tr>");

      $.notify({
        icon: 'ti-success',
        message: "You have successfully added " + data.CareerService + " in your civil service eligibility"


      },{
        type: 'success',
        timer: 4000
      });
    })
    $('#add-cseligibility').modal('hide');
  })

  $(document).on('click', '.edit-cseligibility-button', function() {

    $('#edit-cseligibility-ID').val($(this).data('id').ID);
    $('#edit-cseligibility-CareerService').val($(this).data('id').CareerService);
    $('#edit-cseligibility-Rating').val($(this).data('id').Rating);
    $('#edit-cseligibility-DateOfExamination').val($(this).data('id').DateOfExamination);
    $('#edit-cseligibility-PlaceOfExamination').val($(this).data('id').PlaceOfExamination);
    $('#edit-cseligibility-LicenseNumber').val($(this).data('id').LicenseNumber);
    $('#edit-cseligibility-DateValidity').val($(this).data('id').DateValidity);

    $('#editcseligibility').modal('show');
  });

  $('#frm-edit-cseligibility').on('submit', function(e){
    e.preventDefault();

    var data = $(this).serialize();
    var url = $(this).attr('action');

    $.post(url,data,function(data){
      $('.CSEligibility' + data.ID).replaceWith("<tr class='CSEligibility" + data.ID + "'>" +
        "<td>" + data.CareerService + "</td> " +
        data.CareerService + "</td><td>" +
        data.Rating + "</td><td>" +
        data.DateOfExamination + "</td><td>" +
        data.PlaceOfExamination + "</td><td>" +
        data.LicenseNumber + "</td><td>" +
        data.DateValidity + "</td><td>" +
        "<button class='edit-cseligibility-button btn btn-info' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-edit'></span></button></td><td> <button id='delete-cseligibility-button' class='delete-modal btn btn-danger' data-id='" + JSON.stringify(data) + "'><span class='glyphicon glyphicon-trash'></span></button></td></tr>");

      $.notify({
        icon: 'ti-success',
        message: "You have successfully updated your Civil Service Eligibility."

      },{
        type: 'success',
        timer: 4000
      });
    })

    $('#editcseligibility').modal('hide');
  })

  $(document).on('click', '#delete-cseligibility-button', function() {
    $('#delete-cseligibility-id').val($(this).data('id').ID);

    document.getElementById("dname").innerHTML = $(this).data('id').CareerService;

    $('#deletecseligibility').modal('show');

  });

  $('#frm-del-cseligibility').on('submit', function(e){

    e.preventDefault();


    var data = $(this).serialize();
    var url = $(this).attr('action');

    $.post(url,data,function(data){


      $(".CSEligibility" + data.ID).remove();
      $.notify({
        icon: 'ti-success',
        message: "You have successfully removed " + data.CareerService

      },{
        type: 'success',
        timer: 4000
      });


    })


    $('#deletecseligibility').modal('hide');
  })
</script>
@endsection
@endsection