@extends('master')

@section('content')
<div class="container-fluid">

  <div class="row">

    <div class="header">

      <p class="category" id="StudentID">{{ $StudentID}}</p>
    </div>
    <div class="content content table-responsive ">
      <div class="panel-group" id="accordion">

        @for ($i = 0; $i < 4  ; $i++)
        <div class="col-md-12">
          <div class="card">
            <div class="content table-responsive ">
              <div class="panel-heading">
                <h4 class="panel-title">
                  <a data-toggle="collapse" data-parent="#accordion" href="#collapse{{ $i }}">
                  {{$collection[$i]}}</a>
                </h4>
              </div>
              <!--        <div id="collapse{{ $i }}" class="panel-collapse collapse out"> -->
                <div id="collapse{{ $i }}" >
                  <div class="panel-body " >

                   @for ($z = 0; $z < 3; $z++)




                   <?php $count = 0; ?>



                   @foreach ($checklists as $sub)
                   @if ($i + 1 == $sub->SubjectYearDescription and  $z + 1    == $sub->TermDescription)
                   <?php $count += 1; ?>

                   @endif

                   @endforeach





                   @if ($count >= 1)
                   <h5 class="panel-title">
                    <b>
                      {{ $sem[$z] }}
                    </b>
                  </h5>
                  <table class="ui celled table" >
                    <thead>
                     <th style="display:none""></th>
                     <th>SubjectCode</th>
                     <th>SubjectDescription</th>

                     <th>Units</th>
                     <th>Prerequisite</th>
                     <th>LabUnits</th>
                     <th>LecUnits</th>
                     <th>LabHours</th>
                     <th>LecHours</th>
                     <th>Grade</th>
                   </thead>
                   <tbody>

                     @foreach ($checklists as $sub)



                     @if ($i+ 1 == $sub->SubjectYearDescription and  $z + 1    == $sub->TermDescription)
                     <tr>
                      <td style="display:none">{{ $sub->SubjectID }}</td>
                      <td>{{ $sub->SubjectCode }}</td>
                      <td>{{ $sub->SubjectDescription }}</td>

                      <td>{{ $sub->Units }}</td>
                      <td>{{ $sub->PreRequisiteCODE }}</td>
                      <td>{{ $sub->LabUnits }}</td>
                      <td>{{ $sub->LecUnits }}</td>
                      <td>{{ $sub->LabHours }}</td>
                      <td>{{ $sub->LecHours }}</td>
                      <td style="width:  8.33%">
                        <div class="col-2">
                          <input class="form-control" type="text" value="{{ $sub->Grade }}" id="example-text-input">

                        </div>

                      </td>
                    </tr>
                    @endif


                    @endforeach





                  </tbody>
                </table>
                @endif
                <?php $count = 0; ?>
                @endfor

              </div>
            </div>
          </div>
        </div>
      </div>
      @endfor
      
    </div>
  </div>

</div>

</div>
@section('scriptsko')
<script>


  $(document).ready(function() {
    $('input').keyup(function(e) {
      if(e.keyCode == 13) {

        var StudentID = $('#StudentID').text();
        var SubjectID = $(this).closest("tr").find('td:eq(0)').text();
        var Grade = $(this).val();
        var index = $('input').index(this) + 1;


        $.post("{{ route('AddUpdateGrade') }}", { StudentID: StudentID, SubjectID: SubjectID, Grade: Grade }, function(data){

           // value : data.academic_id,
           // text : data.academic
           
         })



        $('input').eq(index).focus();
      }
    });

    $('input').bind("keyup focusout", function () {
      var StudentID = $('#StudentID').text();
      var SubjectID = $(this).closest("tr").find('td:eq(0)').text();
      var Grade = $(this).val();
      var index = $('input').index(this) + 1;


      $.post("{{ route('AddUpdateGrade') }}", { StudentID: StudentID, SubjectID: SubjectID, Grade: Grade }, function(data){

           // value : data.academic_id,
           // text : data.academic
           
         })
    });
  });
</script>


@endsection

@endsection
