@extends('master')

@section('content')
<div class="container-fluid">
  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="header">
          <h4 class="title">Department Table</h4>
          <p class="category"></p>
        </div>
        <div class="content ">
         <table id="example" class="ui celled table">
          <thead>

            <th>StudentID</th>
            <th>CourseCode</th>
            <th>Action</th>

          </thead>
          <tbody>

           @foreach ($students as $stud)
           <tr>

            <td>{{ $stud->StudentID  }} </td>

            <td>{{ $stud->CurriculumCode  }} </td>
            <td>
              <a href="{{ url('studentlist/'.$stud->StudentID ) }}" title="View Checklist"><i class="fa fa-list"></i></a>
              <a href="{{ url('studentlist/'.$stud->StudentID ) }}" title="Evaluate"><i class="fa fa-files-o"></i></a>
            </td>

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
  document.getElementById("students").className += " active";

</script>
@endsection