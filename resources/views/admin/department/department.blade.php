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
                        <th>DepartmentID</th>
                        <th>Code</th>
                        <th>Description</th>


                    </thead>
                    <tbody>

                     @foreach ($departments as $dept)
                     <tr>
                        <td>{{ $dept->ID }}</td>
                        <td>{{ $dept->DepartmentCode  }} </td>
                        <td>{{ ucwords(strtolower($dept->DepartmentDescription))  }}</td>

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
    document.getElementById("department").className += " active";

</script>
@endsection