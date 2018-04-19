          <div class="tab-pane" id="tab2">
           <form class="form-signin" id="frm-family-background" method="POST" action="{{ route('UpdateFamilyBackground') }}">
             <input type="hidden" value="{{ $UserID[0] }}" name="EmployeeID" id="EmployeeID">
             <table class="table table-bordered table-responsive">
              <tbody><tr>
                <td  class="col-lg-3" scope="row">
                  <label for="">SPOUSE SURNAME:</label>
                </td>
                <td colspan="2"><input type="text" name="sSurname" value="{{ $empDetails[0]->sSurname }}" class="form-control " ></td>
              </tr>

              <tr>
                <td scope="row" class="col-lg-3" >
                  <label for="">FIRST NAME:</label> 
                </td>
                <td  ><input type="text" name="sFirstname" value="{{ $empDetails[0]->sFirstname }}" class="form-control " ></td>

                <td >
                  <label for="">EXTENSION NAME:</label> 
                  <input type="text" placeholder="Extension Name" class="form-control" name="sExtentionname" value="{{ $empDetails[0]->sExtentionname }}">
                </td>
              </tr>
              <tr>
                <td scope="row" class="col-lg-3">
                  <label for="">MIDDLE NAME:</label>
                </td>
                <td colspan="2"><input type="text" name="sMiddlename" value="{{ $empDetails[0]->sMiddlename }}" class="form-control " ></td>
              </tr>
              <tr>
                <td scope="row" class="col-lg-3">
                  <label for="">OCCUPATION:</label>
                </td>
                <td colspan="2"> <input type="text" name="sOccupation" value="{{ $empDetails[0]->sOccupation }}" class="form-control " ></td>
              </tr>
              <tr>
                <td scope="row" class="col-lg-3">
                  <label for="">EMPLOYER/BUSINESS NAME:</label>
                </td>
                <td colspan="2"><input type="text" name="sBusinessname" value="{{ $empDetails[0]->sBusinessname }}" class="form-control " ></td>
              </tr>
              <tr>
                <td scope="row" class="col-lg-3">
                 <label for="">BUSINESS ADDRESS:</label>
               </td>
               <td colspan="2"><input type="text" name="sBusinessaddress" value="{{ $empDetails[0]->sBusinessaddress }}" class="form-control " ></td>
             </tr>
             <tr>
              <td scope="row" class="col-lg-3">
                <label for="">TELEPHONE NO.:</label>
              </td>

              <td colspan="2"><input type="text" name="sTel"  value="{{ $empDetails[0]->sTel }}" class="form-control" >  </td>
            </tr>
            <tr>
              <td scope="row" class="col-lg-3">
               <label for="">FATHER'S  SURNAME:</label>
             </td>
             <td colspan="2"><input type="text" name="fSurname" value="{{ $empDetails[0]->fSurname }}" class="form-control " ></td>
           </tr>
           <tr>
            <td scope="row" class="col-lg-3">
             <label for="">FIRST NAME:</label>
           </td>
           <td><input type="text" name="fFirstname" value="{{ $empDetails[0]->fFirstname }}" class="form-control " ></td>

           <td>
            <label for="">EXTENSION NAME:</label> 
            <input type="text" placeholder="Extension Name" class="form-control " name="fExtensionname" value="{{ $empDetails[0]->fExtensionname }}">
          </td>
        </tr>
        <tr>
          <td scope="row" class="col-lg-3">
            <label for="">MIDDLE NAME:</label>
          </td>
          <td colspan="2"><input type="text" name="fMiddlename" value="{{ $empDetails[0]->fMiddlename }}" class="form-control " ></td>
        </tr>
        <tr>
          <td scope="row" class="col-lg-3">
           <label for="">MOTHER'S MAIDEN NAME:</label>
         </td>
         <td colspan="2"><input type="text" name="mMaidenname" value="{{ $empDetails[0]->mMaidenname }}" class="form-control " ></td>
       </tr>
       <tr>
        <td scope="row" class="col-lg-3">
         <label for="">SURNAME:</label>
       </td>
       <td colspan="2"><input type="text" name="mSurname" value="{{ $empDetails[0]->mSurname }}" class="form-control " > </td>
     </tr>
     <tr>
      <td scope="row" class="col-lg-3">
       <label for="">FIRST NAME:</label>
     </td>
     <td colspan="2"><input type="text" name="mFirstname" value="{{ $empDetails[0]->mFirstname }}" class="form-control " > </td>
   </tr>
   <tr>
    <td scope="row" class="col-lg-3">
      <label for="">MIDDLE NAME:</label>
    </td>
    <td colspan="2"> <input type="text" name="mMiddlename" value="{{ $empDetails[0]->mMiddlename }}" class="form-control " >  </td>
  </tr>
</tbody></table>

<!-- Button trigger modal -->



</form>

<table class='table table-striped table-hover' id="childrens-table" >

  <tr >
   <td class='success  col-lg-5 '>Name of Children</td>
   <td class='success  col-lg-5 '>Date of Birth</td>
   <td colspan=2 class='success  col-lg-4 text-right'>Action</td>    
 </tr>
 <div class="row">
  <div class="col-xs-12">
    <div class="text-right">
      <a href="#zxc" id="UpdateFamilyBackground"></a><button type="submit" class="btn btn-default next-tab">Save</button>
    </div>
  </div>
</div>


@foreach ($childrens as $child)
<tr class="item{{$child->ID}}">

  <td class=''>{{$child->Name}} </td>
  <td class=''>{{$child->Birthday}}</td>

  <td><button class="edit-modal btn btn-info" data-id="{{$child->ID}}"
    data-name="{{$child->Name}}" data-birthday="{{$child->Birthday}}">
    <span class="glyphicon glyphicon-edit"></span> 
  </button>
  <button id="delete-children-button" class="delete-modal btn btn-danger"
  data-id="{{$child->ID}}" data-name="{{$child->Name}}">
  <span class="glyphicon glyphicon-trash">
    
  </span> 
</button></td>

{{--   <td> 
    <button type="button" class="btn btn-primary pull-right" data-toggle="modal" data-target="#editchildren"><i class="fa fa-trash"></i></button>
    <button type="button" class="btn btn-primary pull-right" data-toggle="modal" data-target="#editchildren"><i class="fa fa-edit"></i></button> --}}
    
{{--      <td><a href="{{ url('/checklist/'.$cur->ID . '/' .$cur->CourseTitle. '/' .$cur->NoOfYears. '/' .$cur->MajorDescription) }}"><i class="fa fa-list"></i></a></td>
</td> --}}

</tr>
@endforeach

</table>
<button type="button" class="btn btn-primary pull-right" id="add-children-button">
  Add Children
</button>
</div>