@extends('master')

@section('content')
<div class="container-fluid">

    <div class="row">
     <div class="col-md-12">
        <div class="card">
            <div class="header">
              
                <p class="category"></p>
            </div>
            <div class="content ">
                <div class="panel-group" id="accordion">
                  4
                    @for ($i = 0; $i < 4  ; $i++)

                    <div class="panel panel-default">
                        <div class="panel-heading">
                          <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse{{ $i }}">
                            {{$collection[$i]}}</a>
                        </h4>
                    </div>
                    <div id="collapse{{ $i }}" class="panel-collapse collapse out">
                      <div class="panel-body">

                         @for ($z = 0; $z < 3; $z++)




                         <?php $count = 0; ?>

                    

                         @foreach ($checklists as $sub)
                         @if ($collection[$i] == $sub->SubjectYearDescription and $sem[$z]  == $sub->TermDescription)
                           <?php $count += 1; ?>

                         @endif

                         @endforeach

                      


                      
                         @if ($count >= 1)
                         <h4 class="panel-title">

                            {{ $sem[$z] }}
                        </h4>
                        <table  class="ui celled table">
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



                               @if ($collection[$i] == $sub->SubjectYearDescription and $sem[$z]  == $sub->TermDescription)
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

           @endfor

       </div>
   </div>
</div>
</div>
</div>

</div>
<script>
    // document.getElementById("curriculumlist").className += " active";

</script>
@endsection