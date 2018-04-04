@extends('master')

@section('content')
<div class="container-fluid">

  <div class="row">

    <div class="header">

      <p class="category"><b>{{$title}} {{$major}}</b></p>
    </div>
    <div class="content content table-responsive ">
      <div class="panel-group" id="accordion">
        @if(count($checklists))
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
                   @if ($i + 1 == $sub->SubjectYearDescription and  $z + 1  == $sub->TermDescription)
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
                      <th>SubjectCode</th>
                      <th>SubjectDescription</th>

                      <th>Units</th>
                      <th>Prerequisite</th>
                      <th>LabUnits</th>
                      <th>LecUnits</th>
                      <th>LabHours</th>
                      <th>LecHours</th>

                    </thead>
                    <tbody>

                     @foreach ($checklists as $sub)



                     @if ($i + 1 == $sub->SubjectYearDescription and $z + 1   == $sub->TermDescription)
                     <tr>
                       <td>{{ $sub->SubjectCode }}</td>
                       <td>{{ $sub->SubjectDescription }}</td>

                       <td>{{ $sub->Units }}</td>
                       <td>{{ $sub->PreRequisiteCODE }}</td>
                       <td>{{ $sub->LabUnits }}</td>
                       <td>{{ $sub->LecUnits }}</td>
                       <td>{{ $sub->LabHours }}</td>
                       <td>{{ $sub->LecHours }}</td>

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

       @else
       <div class="col-md-12">
        <div class="card">
          <div class="content table-responsive ">
            <div class="panel-heading">
              <h4 class="panel-title">
               
                No Record Found.
              </h4>
            </div>
          </div>
        </div>
      </div>

      @endif
    </div>
  </div>

</div>

</div>
<script>
    // document.getElementById("curriculumlist").className += " active";
    $('input[type="textbox"]').keyup(function(e) {
      if(e.keyCode == 13) {
        $(this).next().focus();
      }
    });
  </script>
  @endsection