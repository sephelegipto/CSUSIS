@extends('master')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="header">
                    <h4 class="title">Curriculums</h4>
                    <p class="category"></p>
                </div>
                <div class="content content table-responsive ">
                 <table id="example" class="ui celled table">
                    <thead>
                       <th>Curriculum Code</th>
                       <th>Entry Year</th>
                       <th>Course Code</th>
                       <th>College Description</th>
                       <th>Major Code</th>
<th></th>

                   </thead>
                   <tbody>

                     @foreach ($curriculums as $cur)
                     <tr>
                         <td>{{ $cur->CurriculumCode }}</td>
                         <td>{{ $cur->EntryYear }}</td>
                         <td>{{ $cur->CourseCode }}</td>
                         <td>{{ $cur->CollegeCode }}</td>
                         <td>{{ $cur->MajorCode }}</td>
                         <td><a href="{{ url('/checklist/'.$cur->ID . '/' .$cur->CourseTitle. '/' .$cur->NoOfYears. '/' .$cur->MajorDescription) }}"><i class="fa fa-list"></i></a></td>

                     </tr>

                     @endforeach



                 </tbody>
             </table>

         </div>
     </div>
 </div>




</div>
</div>
<script>
    document.getElementById("curriculumlist").className += " active";

</script>
@endsection