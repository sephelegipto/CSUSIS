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
                        <th>Course Code</th>
                        <th>Course Title</th>
                  
                        <th>Major</th>
                        <th>No. of years</th>
                        <th>Action</th>
                    </thead>
                    <tbody>

                       @foreach ($courses as $course)
                       <tr>
                        <td>{{ $course->CourseCode }}</td>
                        <td>{{ $course->CourseTitle }}</td>
                     
                        <td>{{ $course->MajorDescription }}</td>
                        <td>{{ $course->NoOfYears }}</td>
                        <td><a href="{{ url('/curriculumlist/'.$course->ID) }}"><i class="fa fa-list"></i></a></td>


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
    document.getElementById("courses").className += " active";

</script>
@endsection