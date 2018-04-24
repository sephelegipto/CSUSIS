        <div class="tab-pane" id="tab10">
        <form class="form-signin" id="frm-references" method="POST" action="{{ route('UpdateReferences') }}">
         <input type="hidden" value="{{ $UserID[0] }}" name="EmployeeID" id="EmployeeID">
         <input type="hidden" name="ID[0]" value="{{$references[0]->ID}}" id="" placeholder="" class="form-control name_list">
         <input type="hidden" name="ID[1]" value="{{$references[1]->ID}}" id="" placeholder="" class="form-control name_list">
         <input type="hidden" name="ID[2]" value="{{$references[2]->ID}}" id="" placeholder="" class="form-control name_list">

         <table class="table table-bordered" id="dynamic-ref">
          <tbody><tr>
            <td colspan="12"><b>REFERENCES</b><small class="red"> (Person not related by consanguinity or affinity to applicant/appointee)</small></td>
          </tr>
          <tr>
            <th scope="row" class="col-lg-2">
              <label for="">NAME</label>
            </th>
            <th scope="row" class="col-lg-3">
              <label for="">ADDRESS</label>
            </th>
            <th scope="row" class="col-lg-2">
              <label for="">TELEPHONE NO</label>
            </th>

          </tr>

          <tr>
            <td>
              <input type="text" name="Name[0]" value="{{$references[0]->Name}}" id="" placeholder="" class="form-control name_list">
            </td>

            <td>
              <input type="text" name="Address[0]" value="{{$references[0]->Address}}" id="" placeholder="" class="form-control bday_list">
            </td> 

            <td>

              <input type="text" name="ContactNumber[0]"  value="{{$references[0]->ContactNumber}}" placeholder="" class="form-control name_list">
            </td>                                                                
          </tr>
          <tr>
            <td>
              <input type="text" name="Name[1]" value="{{$references[1]->Name}}" id="" placeholder="" class="form-control name_list">
            </td>

            <td>
              <input type="text" name="Address[1]" value="{{$references[1]->Address}}" id="" placeholder="" class="form-control bday_list">
            </td> 

            <td>

              <input type="text" id="tel2" name="ContactNumber[1]"  value="{{$references[1]->ContactNumber}}" placeholder="" class="form-control name_list">
            </td>                                                                
          </tr>
          <tr>
            <td>
              <input type="text" name="Name[2]" value="{{$references[2]->Name}}" id="" placeholder="" class="form-control name_list">
            </td>

            <td>
              <input type="text" name="Address[2]" value="{{$references[2]->Address}}" id="" placeholder="" class="form-control bday_list">
            </td> 

            <td>

              <input type="text" id="tel3" name="ContactNumber[2]"  value="{{$references[2]->ContactNumber}}" placeholder="" class="form-control name_list">
            </td>                                                                
          </tr>

        </tbody></table>
        <div class="row">
          <div class="col-xs-12">
            <div class="text-right">
              <a href="#zxc" id="references"></a><button type="submit" class="btn btn-default next-tab">Save</button>
            </div>
          </div>
        </div>
      </form>
    </div>