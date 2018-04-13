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
          <form action="{{ route('ImportSubjects') }}" method="POST" enctype="multipart/form-data" class="form-inline">




            <label class="sr-only" for="inlineFormInput">Browse:</label>
            <input type="file" class="form-control mb-2 mr-sm-2 mb-sm-0" id="inlineFormInput" name="file">

            <label class="sr-only" for="inlineFormInputGroup">Username</label>
            <div class="input-group">
              <button type="submit" class="btn btn-primary"  value="upload">Submit</button>
            </div>

            <input type="hidden" value="{{ csrf_token() }}" name="_token">

          </form>






        </div>
      </div>
    </div>




  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="header">
          <h4 class="title">Department Table</h4>
          <p class="category"></p>
        </div>
        <div class="content table-responsive ">
         @if (isset($SubjectPeriod))
         <table id="example" class="ui celled table">
          <thead>

            <th>ClassCode</th>
            <th>SubjectCode</th>
            <th>SubjectDescription</th>
            <th>Units</th>
            <th>LBU</th>
            <th>LCU</th>
            <th>LBH</th>
            <th>LCH</th>
            <th>Teacher</th>
            <th></th>
          </thead>
          <tbody>

            <?php $count=count($SubjectPeriod) ; ?>


            @foreach ($SubjectPeriod as $sub)
            <tr>

             <td>
              {{$sub[0]['ClassCode']}}
            </td>
            <td>
              {{$sub[0]['SubjectCode']}}
           </td>
           <td>
             {{$sub[0]['SubjectDescription']}}
           </td>
           <td>
             {{$sub[0]['Units']}}
           </td>
           <td>
             {{$sub[0]['LabUnits']}}
           </td>
           <td>
             {{$sub[0]['LecUnits']}}
           </td>
           <td>
             {{$sub[0]['LabHours']}}
           </td>
           <td>
             {{$sub[0]['LecHours']}}
           </td>
           <td>
             {{$sub[0]['Teacher']}}
           </td>
           <td>
            {{$sub[0][0]['test']}}
          </td>

        </tr>
        @endforeach









      </tbody>
    </table>
    @else
    No Record Found
    @endif






  </div>
</div>
</div>




</div>

</div>
<script>
  document.getElementById("department").className += " active";

</script>
@endsection