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
                        <th>Name</th>
                        <th>Position</th>


                    </thead>
                    <tbody>

                       @foreach ($buildings as $build)
                       <tr>
                        <td>{{ $build->ID }}</td>
                        <td>{{ $build->BuildingCode  }} </td>
                        <td>{{ ucwords(strtolower($build->BuildingDescription))  }}</td>

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
    document.getElementById("building").className += " active";

</script>
@endsection