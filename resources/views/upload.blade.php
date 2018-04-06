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
                  <form action="ImportSubjects" method="POST" enctype="multipart/form-data">
                      <label for="">Upload file:</label>
                      <input type="file" name="file" />
                      <input type="hidden" value="{{ csrf_token() }}" name="_token">
                      <input type="submit" value="upload">
                  </form>
                </div>
            </div>
        </div>




    </div>
</div>
<script>
    document.getElementById("department").className += " active";

</script>
@endsection