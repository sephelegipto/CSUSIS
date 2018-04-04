@extends('master')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="header">
                    <h4 class="title">Employee Table</h4>
                    <p class="category"></p>
                </div>
                <div class="content">
                 <table id="example" class="ui celled table">
                    <thead>
                        <th>EmployeeID</th>
                        <th>Name</th>
                        <th>Position</th>
                        <th>Department</th>
                        <th>Profile Picture</th>
                    </thead>
                    <tbody>

                     @foreach ($employees as $employee)
                     <tr>
                        <td>{{ $employee->EmployeeID }}</td>
                        <td>{{ $employee->FullName  }} </td>
                        <td>{{ ucwords(strtolower($employee->PositionDescription))  }}</td>

                        <td>{{ ucwords(strtolower($employee->DepartmentDescription))  }}</td>

                     
<td>


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
    document.getElementById("employee").className += " active";
</script>
@endsection