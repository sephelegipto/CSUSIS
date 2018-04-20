            <div class="tab-pane content content table-responsive " id="tab4">
              <table class="table table-bordered" id="civilserviceelegibility-table">
                <tbody><tr>
                 <th class="success  text-center col-lg-2">Career Service</th>
                 <th class="success  text-center col-lg-1">Rating</th>
                 <th class="success  text-center col-lg-2">Date of Examination</th>
                 <th class="success  text-center col-lg-3">Place of Examination</th>
                 <th class="success  text-center col-lg-2">License/Number</th>
                 <th class="success  text-center col-lg-2">Date of Validity</th>
                 <th colspan="2" class="text-center success  col-lg-1  ">Action</th>
               </tr>

               @foreach ($CSEligibilities as $CSEligibility)
               <tr class="CSEligibility{{$CSEligibility->ID}}">
                <td class="col-lg-2 ">{{ $CSEligibility->CareerService }}</td>
                <td class="col-lg-1">{{ $CSEligibility->Rating }}</td>
                <td class="col-lg-2 ">{{ $CSEligibility->DateOfExamination }}</td>
                <td class="col-lg-2 ">{{ $CSEligibility->PlaceOfExamination }}</td>
                <td class="col-lg-2 ">{{ $CSEligibility->LicenseNumber }}</td> 
                <td class="col-lg-2 ">{{ $CSEligibility->DateValidity }}</td> 
                <td>
                  <button class="edit-cseligibility-button btn btn-info" data-id="{{$CSEligibility}}">
                    <span class="glyphicon glyphicon-edit"></span> 
                  </button>
                </td>
                <td>
                  <button id="delete-cseligibility-button" class="delete-modal btn btn-danger" data-id="{{$CSEligibility}}">
                    <span class="glyphicon glyphicon-trash"></span> 
                  </button>
                </td>

              </tr>
              @endforeach
            </tbody></table>
            <button type="button" class="btn btn-primary pull-right" id="add-cseligibility-button">
              Add
            </button>
          </div>
          @section('scriptcivilserviceeligibility')
          <script>

            $(document).on('click', '#add-cseligibility-button', function() {
              $('#add-cseligibility').modal('show');
            });

            $('#frm-add-cseligibility').on('submit', function(e){
              e.preventDefault();

              var data = $(this).serialize();
              var url = $(this).attr('action');
              $.post(url,data,function(data){

                JSON.stringify(data, function(key, value) {
    // if value is null, return "" as a replacement
    if(value === null) {
      return "";
    }

    // otherwise, leave the value unchanged
    return value;
  });

                $('#civilserviceelegibility-table').append(
                  "<tr class='CSEligibility" + data.ID + "'>" +
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