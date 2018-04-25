        <div class="tab-pane active table-responsive"  id="tab1">
          <form class="form-signin" id="frm-addupdate-otherquestions" method="POST" action="{{ route('UpdatePersonalInfo') }}">
            <input type="hidden" value="{{ $UserID[0] }}" name="EmployeeID" id="EmployeeID">
            <table class="table table-bordered table-responsive">
             <tbody>
              <tr>
                <td class="col-lg-2" scope="row">
                  <label for="">SURNAME:</label>
                </td>
                <td colspan="5">
                  <input type="text" name="LastName" value="{{ $empDetails[0]->LastName }}" class="form-control">
                </td>
              </tr>
              <tr>
                <td  class="col-lg-2 text-capitalize">
                  <label for="">FIRST NAME:</label>
                </td>
                <td colspan="3">
                  <input type="text" name="FirstName" value="{{ $empDetails[0]->FirstName }}" class="form-control">
                </td>
                <td class="col-lg-2 text-capitalize" scope="row">
                  <label for="">EXTENSION NAME:</label>
                </td>
                <td >
                  <input type="text" placeholder="Extension Name" class="form-control col-lg-2" name="ExtensionName" value="{{ $empDetails[0]->ExtensionName }} ">
                </td>
              </tr> 
              <tr>
                <td scope="row" class="col-lg-2">
                  <label for="">MIDDLE NAME:</label>
                </td>
                <td colspan="5">
                  <input type="text" name="MiddleName" value="{{ $empDetails[0]->MiddleName }}" class="form-control">
                </td>
              </tr>
              <tr>
                <td scope="row" class="col-lg-2">
                  <label for="">DATE OF BIRTH:</label>
                </td>
                <td colspan="2"> 
                  <input type="date" name="DOB" value="{{ $empDetails[0]->DOB }}" class="form-control " >
                </td>
                <td  rowspan="3" class="col-lg-2" scope="row">
                  <label for="">CITIZENSHIP:</label> 
                  <br><br><br>
                  <span style="color: red; font-weight: normal;">
                    If holder of Dual Citizenship, <br> Please indicate the details.
                  </span>
                </td>
                <td rowspan="3" colspan="3">
                 <div class="row text-center"> 
                  <input type="hidden" id="check-a" name="Filipino" value="0" {{ $empDetails[0]->Filipino ? '' : 'CHECKED' }}/>
                  <input  type="checkbox"  value="1" {{ $empDetails[0]->Filipino ? 'CHECKED' : '' }} name="Filipino" onclick="toggleA()">Filipino
                  <input type="hidden" id="check-b" name="DualCitizenship" value="0" {{ $empDetails[0]->DualCitizenship ? '' : 'CHECKED' }}/>
                  <input  type="checkbox" value="1" {{ $empDetails[0]->DualCitizenship ? 'CHECKED' : '' }} name="DualCitizenship" onclick="toggleB()">Dual Citizenship

                  <script>
                   function toggleA() {

                    var elm = document.getElementById('check-a');
                    elm.checked = !elm.checked;
                  }
                  function toggleB() {

                    var elm = document.getElementById('check-b');
                    elm.checked = !elm.checked;
                  }
                  function toggleC() {

                    var elm = document.getElementById('check-c');
                    elm.checked = !elm.checked;
                  }
                  function toggleD() {

                    var elm = document.getElementById('check-d');
                    elm.checked = !elm.checked;
                  }
                </script>

              </div>
              <div class="row text-center"> 
               <input type="hidden" id="check-c" name="ByBirth" value="0" {{$empDetails[0]->ByBirth ? '' : 'CHECKED'}}/>
               <input  type="checkbox" value="1"  {{ $empDetails[0]->ByBirth ? 'CHECKED' : '' }} name="ByBirth" onclick="toggleC()">By Birth

               <input type="hidden" id="check-d" name="ByNaturalization" value="0" {{$empDetails[0]->Filipino ? '' : 'CHECKED'}}/>
               <input  type="checkbox" value="1"  {{ $empDetails[0]->ByNaturalization ? 'CHECKED' : '' }} name="ByNaturalization" onclick="toggleD()">By naturalization

             </div>
             <br> <br><br> <br><br>

             <p>Pls. indicate country</p>
             <select name="CountryID" class="form-control">

              <option value="">--------------------</option>
              @foreach($countries as $key => $c)
              <option value="{{ $c->ID }}" {{ $c->ID == $empDetails[0]->CountryID ? 'selected' : null }}>
                {{ $c->CountryDescription }}
              </option>
              @endforeach


            </select>


          </td>
        </tr>
        <tr>
          <td scope="row" class="col-lg-2">
            <label for="">PLACE OF BIRTH:</label>
          </td>
          <td colspan="2"> 
            <input type="text" name="POB" value="{{ $empDetails[0]->POB }}" class="form-control " >
          </td>
        </tr>
        <tr>
         <td scope="row" class="col-lg-2"> <label for="">SEX:</label></td>
         <td colspan="2">
          <select class="form-control col-lg-2" name="Gender">                                 
           <option {{  $empDetails[0]->Gender == 'MALE'  ? 'SELECTED' : '' }} value="MALE">Male</option>                              
           <option {{ $empDetails[0]->Gender == 'FEMALE'  ? 'SELECTED' : '' }} value="FEMALE">Female</option>
         </select>
       </td>
     </tr>
     <tr>
       <td scope="row" class="col-lg-2">
        <label for="">CIVIL STATUS:</label>
      </td>
      <td colspan="2"> 
       <select class="form-control col-lg-2" name="CivilStatus">

        <option {{  $empDetails[0]->CivilStatus == 'Single'  ? 'SELECTED' : '' }} value="Single">Single</option>                  
        <option {{  $empDetails[0]->CivilStatus == 'Married'  ? 'SELECTED' : '' }} value="Married">Married</option>                                       
        <option {{  $empDetails[0]->CivilStatus == 'Widowed'  ? 'SELECTED' : '' }} value="Widowed">Widowed</option>
        <option {{  $empDetails[0]->CivilStatus == 'Seperated'  ? 'SELECTED' : '' }} value="Seperated">Seperated</option>
      </select>
    </td>
    <td rowspan="3">
      <label for="">RESIDENTIAL ADDRESS:</label>
      <br><br><br><br><br>
      <input type="text" name="ResZipCode" value="{{ $empDetails[0]->ResZipCode }}" class="form-control" >
      <center>
        <label for="" style="font-size:12px; text-align:center">ZIP CODE</label>
      </center>
    </td>
    <td> 
      <input type="text" name="ResHouseBlockLotNo" value="{{ $empDetails[0]->ResHouseBlockLotNo }}" class="form-control " >
      <label for="" style="font-size:12px; text-align:center">HOUSE/BLOCK/LOT NO.</label>
    </td>
    <td>
      <input type="text" name="ResStreet" value="{{ $empDetails[0]->ResStreet }}" class="form-control  " >
      <center>
        <label for="" style="font-size:12px; text-align:center">STREET</label>
      </center>
    </td>
  </tr>
  <tr>
   <td scope="row" class="col-lg-2"> <label for="">HEIGHT (m):</label></td>
   <td colspan="2">  
    <input type="text" name="Height" value="{{ $empDetails[0]->Height }}" class="form-control" > 
  </td>
  <td>
    <input type="text" name="ResSubDiv" value="{{ $empDetails[0]->ResSubDiv }}" class="form-control  " >
    <center>
      <label for="" style="font-size:12px; text-align:center">SUBDIVISION/VILLAGE</label>
    </center>
  </td>
  <td>
    <input type="text" name="ResBrngy" value="{{ $empDetails[0]->ResBrngy }}" class="form-control  " >
    <center>
      <label for="" style="font-size:12px; text-align:center">BARANGAY</label>
    </center>
  </td>
</tr>
<tr>
 <td scope="row" class="col-lg-2">
  <label for="">WEIGHT (kg):</label>
</td>
<td colspan="2"> 
  <input type="text" name="Weight" value="{{ $empDetails[0]->Weight }}" class="form-control">
</td>
<td>
  <input type="text" name="ResCity" value="{{ $empDetails[0]->ResCity }}" class="form-control">
  <center>
    <label for="" style="font-size:12px; text-align:center">CITY/MUNICIPALITY
    </label>
  </center>
</td>
<td>
  <input type="text" name="ResProvince" value="{{ $empDetails[0]->ResProvince }}" class="form-control">
  <center>
    <label for="" style="font-size:12px; text-align:center">PROVINCE</label>
  </center>
</td>
</tr>
<tr>
  <td scope="row" class="col-lg-2"> 
    <label for="">BLOOD TYPE:</label>
  </td>
  <td colspan="2">
    <select class="form-control col-lg-2" name="BloodType">
      <option value="A+" {{  $empDetails[0]->BloodType == 'A+'  ? 'SELECTED' : '' }} >A+</option>
      <option value="B+" {{  $empDetails[0]->BloodType == 'B+'  ? 'SELECTED' : '' }}>B+</option>
      <option value="AB+" {{  $empDetails[0]->BloodType == 'AB+'  ? 'SELECTED' : '' }}>AB+</option>
      <option value="O+" {{  $empDetails[0]->BloodType == 'O+'  ? 'SELECTED' : '' }}>O+</option>
    </select>
  </td>
  <td rowspan="3">
    <label for="">PERMANENT ADDRESS:</label>
    <br><br><br><br><br>
    <input type="text" name="PermZipCode" value="{{ $empDetails[0]->PermZipCode }}" class="form-control" placeholder="Zip Code" >
    <center>
      <label for="" style="font-size:12px; text-align:center">ZIP CODE</label>
    </center>
  </td>
  <td>
    <input type="text" name="PermHouseBlockLotNo" value="{{ $empDetails[0]->PermHouseBlockLotNo }}" class="form-control " >
    <center>
      <label for="" style="font-size:12px; text-align:center">HOUSE/BLOCK/LOT NO.</label>
    </center>
  </td>
  <td>
    <input type="text" name="PermStreet" value="{{ $empDetails[0]->PermStreet }}" class="form-control " >
    <center>
      <label for="" style="font-size:12px; text-align:center">STREET</label>
    </center>
  </td>
</tr>
<tr>
  <td scope="row" class="col-lg-2"> <label for="">GSIS ID NO.</label></td>
  <td colspan="2"> 
    <input type="text" name="GSIS" value="{{ $empDetails[0]->GSIS }}" class="form-control" > 
  </td>
  <td>
    <input type="text" name="PermSubDiv" value="{{ $empDetails[0]->PermSubDiv }}" class="form-control  " >
    <center>
      <label for="" style="font-size:12px; text-align:center">SUBDIVISION/VILLAGE</label>
    </center>
  </td>
  <td>
    <input type="text" name="PermBrngy" value="{{ $empDetails[0]->PermBrngy }}" class="form-control">
    <center>
      <label for="" style="font-size:12px; text-align:center">BARANGAY</label>
    </center>
  </td>
</tr>
<tr>
 <td scope="row" class="col-lg-2">
  <label for="">PAG-IBIG ID NO.</label>
</td>

<td colspan="2">  
  <input type="text" id="pagibig" name="PAGIBIG"  value="{{ $empDetails[0]->PAGIBIG }}" class="form-control" >
</td>
<td>
  <input type="text" name="PermCity" value="{{ $empDetails[0]->PermCity }}" class="form-control  " >
  <center>
    <label for="" style="font-size:12px; text-align:center">CITY/MUNICIPALITY</label>
  </center>
</td>
<td>
  <input type="text" name="PermProvince" value="{{ $empDetails[0]->PermProvince }}" class="form-control  " >
  <center>
    <label for="" style="font-size:12px; text-align:center">PROVINCE</label>
  </center>
</td>
</tr>
<tr>
 <td scope="row" class="col-lg-2">
  <label for="">PHILHEALTH NO.</label>
</td>

<td colspan="2">
  <input type="text" id="philhealth" name="PHILHEALTH" value="{{ $empDetails[0]->PHILHEALTH }}" class="form-control" > 
</td>
<td colspan="3">  </td>
</tr>
<tr>
 <td scope="row" class="col-lg-2"> <label for="">SSS NO.</label></td>

 <td colspan="2">
  <input type="text" id="sss" name="SSS" value="{{ $empDetails[0]->SSS }}" class="form-control" >  
</td>
<td scope="row" class="col-lg-2"> 
  <label for="">TELEPHONE NO.</label>
</td>

<td colspan="3"><input type="text" id="Telephone" name="Telephone" value="{{ $empDetails[0]->Telephone }}" class="form-control" >  </td>

</tr>
<tr>
 <td scope="row" class="col-lg-2"> 
  <label for="">TIN:</label>
</td>

<td colspan="2"> 
  <input type="text" id="tin" name="TIN" value="{{ $empDetails[0]->TIN }}" class="form-control" >   
</td>
<td scope="row" class="col-lg-2"><label for="">MOBILE NO.</label></td>

<td colspan="2">
  <input type="text" id="mobile" name="PhoneNumber" value="{{ $empDetails[0]->PhoneNumber }}" class="form-control" >
</td>
</tr>
<tr>
 <td scope="row" class="col-lg-2"> 
  <label for="">AGENCY EMPLOYEE NO:</label>
</td>
<td colspan="2"> 
  <input type="text" name="AGENCYEMPLOYEENO" value="{{ $empDetails[0]->AGENCYEMPLOYEENO }}" class="form-control" > 
</td>
<td scope="row" class="col-lg-2"> <label for="">E-MAIL ADDRESS (if any):</label></td>
<td colspan="2">
  <input type="text" name="Email" value="{{ $empDetails[0]->Email }}" class="form-control" >
</td>
</tr>
</tbody>
</table>
<div class="row">
  <div class="col-xs-12">
    <div class="text-right">
      <a href="#zxc" id="zxc"></a><button type="submit" class="btn btn-default next-tab">Save</button>
    </div>
  </div>
</div>
</form>
</div>