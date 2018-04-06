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
                    
                        <th>Code</th>
                        <th>Description</th>
<th>Action</th>

                    </thead>
                    <tbody>

                     @foreach ($colleges as $col)
                     <tr>
                     
                        <td>{{ $col->CollegeCode  }} </td>
                        <td>{{ ucwords(strtolower($col->CollegeDescription))  }}</td>
 <td><a href="{{ url('/upload/'.$col->ID) }}"><i class="fa fa-list"></i></a></td>
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