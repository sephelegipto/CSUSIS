
@extends('master')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2">
            <div class="card">

                <div class="content table-responsive "">

                 <ul id="tabs" class="nav nav-pills nav-stacked">
                    <li class="active"><a href="#tab1" data-toggle="tab">Personal Information</a></li>
                    <li><a href="#tab2" data-toggle="tab">Family Background</a></li>
                    <li><a href="#tab3" data-toggle="tab">Educational Background</a></li>
                    <li><a href="#tab4" data-toggle="tab">Civil Service Eligibility</a></li>
                    <li><a href="#tab5" data-toggle="tab">Work Experience</a></li>   

                    <li><a href="#tab6" data-toggle="tab">Voluntarily Work</a></li>

                    <li><a href="#tab7" data-toggle="tab">Learning and Development</a></li>
                    <li><a href="#tab8" data-toggle="tab">Other Information</a></li>
                    <li><a href="#tab9" data-toggle="tab">Other Question</a></li>   
                    <li><a href="#tab10" data-toggle="tab">Reference and Other Information</a></li>
                    <li><a href="#tab11" data-toggle="tab">Export</a></li>

                    
                </ul>

            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-9">
            <div class="card md-form">
                <div class="tab-content">

                    <div class="tab-pane active table-responsive"  id="tab1">
                        <form class="form-signin" id="frm-personal-information" method="POST" action="{{ route('UpdatePersonalInfo') }}">
                         <input type="hidden" value="{{ Auth::user()->UserID }}" name="EmployeeID" id="EmployeeID">
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
                                 <input  type="checkbox" value="">Filipino
                                 <input  type="checkbox" value="">Dual Citizenship 
                             </div>
                             <div class="row text-center"> 
                                 <input  type="checkbox" value="">By birth
                                 <input  type="checkbox" value="">By naturalization
                             </div>
                             <br> <br><br> <br><br>

                             <p>Pls. indicate country</p>
                             <select name="country" class="form-control">


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

<!-- =======================================================================================================================================================================================                     TAB 2               =============================================================================================================================================================================================================== -->





<div class="tab-pane" id="tab2">
   <form class="form-signin" id="frm-family-background" method="POST" action="{{ route('UpdateFamilyBackground') }}">
     <input type="hidden" value="{{ Auth::user()->UserID }}" name="EmployeeID" id="EmployeeID">
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
    <script>
       function meme()
       {
           var x=stel.value;
           if(x.length==4)
             stel .value=stel.value+" ";
         if(x.length==8)
          stel.value=stel.value+" ";
  }
</script>
<td colspan="2"><input type="text" id="stel" name="sTel"  value="{{ $empDetails[0]->sTel }}" class="form-control" >  </td>
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
<table class='table table-striped table-hover' >

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
<tr class=''>

    <td class=''>{{$child->Name}} </td>
    <td class=''>{{$child->Birthday}}</td>

</tr>
@endforeach

</table>
</form>

</div>
<!-- =======================================================================================================================================================================================                     TAB 3               =============================================================================================================================================================================================================== -->
<div class="tab-pane" id="tab3">
   <form class="form-signin" id="frm-personal-information" method="POST" action="{{ route('UpdatePersonalInfo') }}">
     <table class="table table-bordered" id="dynamic-graduate">


      <tr class="success">
        <th scope="row" rowspan="2">
            <center>
                <label for="">LEVEL</label>
            </center>
        </th>
        <th scope="row" rowspan="2" class="col-lg-3">
            <center>
                <label for="">NAME OF SCHOOL<br>(Write in full)</label>
            </center>
        </th>
        <th scope="row" rowspan="2" class="col-lg-3">
            <label for="">BASIC EDUCATIONAL/DEGREE/COURSE<br>(Write in full)</label>
        </th>
        <th scope="row" class="col-lg-2" colspan="2">
            <label for="">PERIOD OF ATTENDANCE</label>
        </th>
        <th scope="row" rowspan="2" class="col-lg-2">
            <label for="">HIGHEST LEVEL/ UNITS EARNED <br>(If not graduated)</label>
        </th>
        <th scope="row" rowspan="2" class="col-lg-1">
            <label for=""> YEAR GRADUATED</label>
        </th>
        <th scope="row" rowspan="2" class="col-lg-1">
            <label for="">SCHOLARSHIP/ ACADEMIC HONORS RECEIVED</label>
        </th>

    </tr>
    <tr class="success">
        <th scope="row">
            <label for="">From</label>
        </th>
        <th scope="row">
            <label for="">To</label>
        </th>
    </tr>
    <tr>
        <th class="success" scope="row">
         <label for="">ELEMENTARY</label>
     </th>
     <td>
        <input type="text" name="elemname" class="form-control" value="{{ $ELEMENTARY[0]->NameOfSchool  }}">
    </td>
    <td>
        <input type="text" name="elembasic" class="form-control" value="{{ $ELEMENTARY[0]->EducationDegreeCourse  }}">
    </td>
    <td>
        <input type="text" name="elemfrom" class="form-control col-lg-3" value="{{ $ELEMENTARY[0]->From  }}">
    </td>
    <td>
        <input type="text" name="elemto" class="form-control col-lg-3"   value="{{ $ELEMENTARY[0]->To  }}">
    </td>
    <td>
        <input type="text" name="elemhigh" class="form-control" value="{{ $ELEMENTARY[0]->UnitsEarned  }}"> 
    </td>
    <td>
        <input type="text" name="elemgrad" class="form-control col-lg-3" value="{{ $ELEMENTARY[0]->YearGraduated  }}">
    </td>
    <td>
        <input type="text" name="elemscholar" class="form-control col-lg-3" value="{{ $ELEMENTARY[0]->AcademicHonors  }}">
    </td>
</tr>

<tr>
    <th class="success" scope="row">
      <label for="">SECONDARY</label>
  </th>
  <td>
    <input type="text" name="secname" class="form-control" value="{{ $SECONDARY[0]->NameOfSchool  }}">
</td>

<td> 
    <input type="text" name="secbasic" class="form-control" value="{{ $SECONDARY[0]->EducationDegreeCourse  }}"> 
</td>
<td>
    <input type="text" name="secfrom" class="form-control col-lg-3 " value="{{ $SECONDARY[0]->From  }}">
</td>

<td><input type="text" name="secto" class="form-control col-lg-3 "  value="{{ $SECONDARY[0]->To  }}"></td>

<td><input type="text" name="sechigh" class="form-control "  value="{{ $SECONDARY[0]->UnitsEarned  }}"> </td>

<td><input type="text" name="secgrad" class="form-control col-lg-3 "  value="{{ $SECONDARY[0]->YearGraduated  }}" ></td>

<td><input type="text" name="secscholar" class="form-control col-lg-3 "  value="{{ $SECONDARY[0]->AcademicHonors  }}" ></td>
</tr>

<tr>
    <th class="success" scope="row">
      <label for="">VOCATIONAL/TRADE COURSE</label>
  </th>
  <td>
    <input type="text" name="vocname" class="form-control "  value="{{ $VOCATIONAL[0]->NameOfSchool  }}" data-toggle="tooltip" title="{{ $VOCATIONAL[0]->AcademicHonors  }}">
</td>

<td> <input type="text" name="vocbasic" class="form-control " value="{{ $VOCATIONAL[0]->EducationDegreeCourse  }}"> </td>

<td><input type="text" name="vocfrom" class="form-control col-lg-3 " value="{{ $VOCATIONAL[0]->From  }}"></td>

<td><input type="text" name="vocto" class="form-control col-lg-3 " value="{{ $VOCATIONAL[0]->To  }}"></td>

<td><input type="text" name="vochigh" class="form-control " value="{{ $VOCATIONAL[0]->UnitsEarned  }}"></td>

<td><input type="text" name="vocgrad" class="form-control col-lg-3 "   value="{{ $VOCATIONAL[0]->YearGraduated  }}"></td>

<td> <input type="text" name="vocscholar" class="form-control col-lg-3 " value="{{ $VOCATIONAL[0]->AcademicHonors  }}"></td>
</tr>


<tr>
    <th class="success" scope="row">
     <label for="">COLLEGE</label>
 </th>
 <td><input type="text" name="colname" class="form-control "  value="{{ $COLLEGE[0]->NameOfSchool  }}"></td>

 <td> <input type="text" name="colbasic" class="form-control " value="{{ $COLLEGE[0]->EducationDegreeCourse  }}"></td>

 <td><input type="text" name="colfrom" class="form-control col-lg-3 " value="{{ $COLLEGE[0]->From  }}"></td>

 <td><input type="text" name="colto" class="form-control col-lg-3 " value="{{ $COLLEGE[0]->To  }}"></td>

 <td><input type="text" name="colhigh" class="form-control " value="{{ $COLLEGE[0]->UnitsEarned  }}"></td>

 <td><input type="text" name="colgrad" class="form-control col-lg-3 "  value="{{ $COLLEGE[0]->YearGraduated  }}"></td>

 <td> <input type="text" name="colscholar" class="form-control col-lg-3 "  value="{{ $COLLEGE[0]->AcademicHonors  }}"></td>
</tr>
<tr>
    <th class="success" scope="row">
     <label for="">GRADUATE STUDIES </label>
 </th>
 <td>
    <input  type="text"  name="gradname" id="gradname" placeholder=""  class="form-control" value="{{ $GRADUATE[0]->NameOfSchool  }}"/>
</td>

<td>
    <input type="text" name="gradbasic" id="gradbasic" placeholder=""  class="form-control" value="{{ $GRADUATE[0]->EducationDegreeCourse  }}"/>
</td> 

<td>
    <input  type="text"  name="gradfrom" id="gradfrom" placeholder=""  class="form-control" value="{{ $GRADUATE[0]->From  }}"/>
</td>

<td>
    <input type="text" name="gradto" id="gradto" placeholder=""  class="form-control" value="{{ $GRADUATE[0]->To  }}"/>
</td> 

<td>
    <input  type="text"  name="gradhigh" id="gradhigh" placeholder=""  class="form-control" value="{{ $GRADUATE[0]->UnitsEarned  }}"/>
</td>

<td>
    <input type="text" name="gradgrad" id="gradgrad" placeholder=""  class="form-control" value="{{ $GRADUATE[0]->YearGraduated  }}"/>
</td> 

<td>
    <input  type="text"  name="gradscholar" id="gradscholar" placeholder=""  class="form-control" value="{{ $GRADUATE[0]->AcademicHonors  }}"/>
</td>

</tr>

</table> 
</form>
</div>
<!-- =======================================================================================================================================================================================                     TAB 4               =============================================================================================================================================================================================================== -->
<div class="tab-pane" id="tab4">
  <table class="table table-bordered">
      <tbody><tr>
         <th class="success  text-center col-lg-2">Career Service</th>
         <th class="success  text-center col-lg-1">Rating</th>
         <th class="success  text-center col-lg-2">Date of Examination</th>
         <th class="success  text-center col-lg-3">Place of Examination</th>
         <th class="success  text-center col-lg-2">License/Number</th>
         <th class="success  text-center col-lg-2">Date of Validity</th>
         <th colspan="2" class="text-center success  col-lg-1  ">Action</th>
     </tr>
     <tr class="">
         <td class="col-lg-2 ">N/n</td>
         <td class="col-lg-1">N/n</td>
         <td class="col-lg-2 ">2017-12-08</td>
         <td class="col-lg-2 ">N/n</td>
         <td class="col-lg-2 ">1</td> 
         <td class="col-lg-2 ">2017-11-28</td> 
         <td class="text-center"> <a class="btn btn-info btn-xs"> <span class="glyphicon glyphicon-pencil" href="include/editcivil.php?id=1" data-toggle="modal" data-target="#civil"></span></a></td>

         <td><a href="include/deletecivil.php?id=1" class="btn btn-danger btn-xs"> <span class="glyphicon glyphicon-trash" aria-hidden="true" name="Delete" value="Delete"></span></a></td>

     </tr>
     <tr class="">
         <td class="col-lg-2 ">N/n</td>
         <td class="col-lg-1">N/n</td>
         <td class="col-lg-2 ">2017-12-07</td>
         <td class="col-lg-2 ">N/n</td>
         <td class="col-lg-2 ">2</td> 
         <td class="col-lg-2 ">2017-12-04</td> 
         <td class="text-center"> <a class="btn btn-info btn-xs"> <span class="glyphicon glyphicon-pencil" href="include/editcivil.php?id=2" data-toggle="modal" data-target="#civil"></span></a></td>

         <td><a href="include/deletecivil.php?id=2" class="btn btn-danger btn-xs"> <span class="glyphicon glyphicon-trash" aria-hidden="true" name="Delete" value="Delete"></span></a></td>

     </tr>
 </tbody></table>
</div>
<!-- =======================================================================================================================================================================================                     TAB 5               =============================================================================================================================================================================================================== -->
<div class="tab-pane" id="tab5">
  <table class="table table-bordered">

   <tbody><tr>
       <th class="success  text-center col-lg-2 ">Inclusive Dates From</th>
       <th class="success  text-center col-lg-2 ">Inclusive Dates To</th>
       <th class="success  text-center col-lg-2 ">Position Title</th>
       <th class="success  text-center col-lg-2">Departmnet/Agency/Office/Company</th>
       <th class="success  text-center col-lg-2 ">Monthly Salary</th>
       <th class="success  text-center col-lg-2 ">Salary /Job Pay</th>
       <th class="success  text-center col-lg-3 ">Status Appointment</th>
       <th class="success  text-center col-lg-2 ">Gov't Service</th>
       <th colspan="2" class="success  text-center col-lg-2">Action</th>
   </tr>
   <tr class="">
       <td class="">2017-11-30</td>
       <td class="">2017-11-29</td>
       <td class="">N/n</td>
       <td class="">N/n</td>
       <td class="">1</td>
       <td class="">1</td>
       <td class="">N/n</td>
       <td class="">YES</td>
       <td class="text-center"> <a class="btn btn-info btn-xs"> <span class="glyphicon glyphicon-pencil" href="include/editwork.php?id=1" data-toggle="modal" data-target="#work"></span></a></td>


       <td><a href="include/deletework.php?id=1" class="btn btn-danger btn-xs"> <span class="glyphicon glyphicon-trash" aria-hidden="true" name="Delete" value="Delete"></span></a></td>


   </tr>
   <tr class="">
       <td class="">2017-11-30</td>
       <td class="">2017-11-30</td>
       <td class="">N/n</td>
       <td class="">N/n</td>
       <td class="">2</td>
       <td class="">2</td>
       <td class="">N/n</td>
       <td class="">NO</td>
       <td class="text-center"> <a class="btn btn-info btn-xs"> <span class="glyphicon glyphicon-pencil" href="include/editwork.php?id=2" data-toggle="modal" data-target="#work"></span></a></td>


       <td><a href="include/deletework.php?id=2" class="btn btn-danger btn-xs"> <span class="glyphicon glyphicon-trash" aria-hidden="true" name="Delete" value="Delete"></span></a></td>


   </tr>
</tbody></table>
</div>
<!-- =======================================================================================================================================================================================                     TAB 6               =============================================================================================================================================================================================================== -->
<div class="tab-pane" id="tab6">
    <table class="table table-bordered">
     <tbody><tr>
       <th class="success  text-center col-lg-4 ">Name and Address of Organization</th>
       <th class="success  text-center col-lg-1 ">Inclusive Dates From</th>
       <th class="success  text-center col-lg-1 ">Inclusive Dates To</th>
       <th class="success  text-center col-lg-2 ">Number of Hours</th>
       <th class="success  text-center col-lg-3 ">Position / Nature of Work</th>
       <th colspan="2" class="success  text-center col-lg-1 text-center ">Action</th>
   </tr>

   <tr class="">
       <td class="col-lg-2 ">N/n</td>
       <td class="col-lg-2 ">2017-12-06</td> 
       <td class="col-lg-2 ">2017-12-12</td> 
       <td class="col-lg-2 ">1</td>
       <td class="col-lg-2 ">N/n</td>

       <td class="text-center"> <a class="btn btn-info btn-xs"> <span class="glyphicon glyphicon-pencil" href="include/editvoluntary.php?id=1" data-toggle="modal" data-target="#voluntary"></span></a></td>


       <td><a href="include/deletevoluntary.php?id=1" class="btn btn-danger btn-xs"> <span class="glyphicon glyphicon-trash" aria-hidden="true" name="Delete" value="Delete"></span></a></td>

   </tr>

   <tr class="">
       <td class="col-lg-2 ">N/n</td>
       <td class="col-lg-2 ">2017-12-14</td> 
       <td class="col-lg-2 ">2017-12-01</td> 
       <td class="col-lg-2 ">2</td>
       <td class="col-lg-2 ">N/n</td>

       <td class="text-center"> <a class="btn btn-info btn-xs"> <span class="glyphicon glyphicon-pencil" href="include/editvoluntary.php?id=2" data-toggle="modal" data-target="#voluntary"></span></a></td>


       <td><a href="include/deletevoluntary.php?id=2" class="btn btn-danger btn-xs"> <span class="glyphicon glyphicon-trash" aria-hidden="true" name="Delete" value="Delete"></span></a></td>

   </tr>
</tbody></table>
</div>
<!-- =======================================================================================================================================================================================                     TAB 7               =============================================================================================================================================================================================================== -->
<div class="tab-pane" id="tab7">
  <table class="table table-striped table-hover">
   <tbody><tr>
       <th class="success text-center  col-lg-4">Title of Learning and Development Intervention/Training Programs</th>
       <th class="success text-center  col-lg-1 ">Inclusive Dates of Attendance From</th>
       <th class="success text-center  col-lg-1 ">Inclusive Dates of Attendance To</th>
       <th class="success text-center  col-lg-1 ">Number of Hours</th>
       <th class="success text-center  col-lg-3 ">Type of LD( Managerial/ Supervisory/Technical/etc)</th>
       <th class="success text-center  col-lg-3 ">Conducted /Sponsored by</th>
       <th colspan="2" class="success text-center  col-lg-1 text-center">Action</th>    
   </tr> 

   <tr class="">
       <td class="col-lg-2 ">N/n</td>
       <td class="col-lg-2 ">2017-12-07</td>
       <td class="col-lg-2 ">2017-12-13</td>
       <td class="col-lg-2 ">1</td>
       <td class="col-lg-2 ">N/n</td>
       <td class="col-lg-2 ">N/n</td>


       <td class="text-center"> <a class="btn btn-info btn-xs"> <span class="glyphicon glyphicon-pencil" href="include/editlearning.php?id=1" data-toggle="modal" data-target="#learn"></span></a></td>


       <td><a href="include/deletelearning.php?id=1" class="btn btn-danger btn-xs"> <span class="glyphicon glyphicon-trash" aria-hidden="true" name="Delete" value="Delete"></span></a></td>

   </tr>

   <tr class="">
       <td class="col-lg-2 ">N/n</td>
       <td class="col-lg-2 ">2017-11-30</td>
       <td class="col-lg-2 ">2017-12-06</td>
       <td class="col-lg-2 ">2</td>
       <td class="col-lg-2 ">N/n</td>
       <td class="col-lg-2 ">N/n</td>


       <td class="text-center"> <a class="btn btn-info btn-xs"> <span class="glyphicon glyphicon-pencil" href="include/editlearning.php?id=2" data-toggle="modal" data-target="#learn"></span></a></td>


       <td><a href="include/deletelearning.php?id=2" class="btn btn-danger btn-xs"> <span class="glyphicon glyphicon-trash" aria-hidden="true" name="Delete" value="Delete"></span></a></td>

   </tr>

</tbody></table>
</div>
<!-- =======================================================================================================================================================================================                     TAB 8               =============================================================================================================================================================================================================== -->
<div class="tab-pane" id="tab8">
  <table class="table table-striped table-hover">
      <tbody><tr>
          <th class="success  text-center col-lg-3">Special Skill and Hobbies</th>
          <th class="success  text-center col-lg-3">Non-Academic Distinction/ Recognition</th>
          <th class="success  text-center col-lg-3">Membership in Association/ Organization</th>
          <th colspan="2" class="text-center success  col-lg-1">Action</th>
      </tr>
      <tr class="">
       <td class="col-lg-2 ">N/n</td>
       <td class="col-lg-2 ">N/n</td>
       <td class="col-lg-2 ">N/n</td>
       <td class="text-center"> <a class="btn btn-info btn-xs"> <span class="glyphicon glyphicon-pencil" href="include/editother.php?id=1" data-toggle="modal" data-target="#otherinfo"></span></a></td>


       <td><a href="include/deleteother.php?id=1" class="btn btn-danger btn-xs"> <span class="glyphicon glyphicon-trash" aria-hidden="true" name="Delete" value="Delete"></span></a></td>


   </tr>
   <tr class="">
       <td class="col-lg-2 ">N/ns</td>
       <td class="col-lg-2 ">N/ns</td>
       <td class="col-lg-2 ">N/ns</td>
       <td class="text-center"> <a class="btn btn-info btn-xs"> <span class="glyphicon glyphicon-pencil" href="include/editother.php?id=2" data-toggle="modal" data-target="#otherinfo"></span></a></td>


       <td><a href="include/deleteother.php?id=2" class="btn btn-danger btn-xs"> <span class="glyphicon glyphicon-trash" aria-hidden="true" name="Delete" value="Delete"></span></a></td>


   </tr>
</tbody></table>
</div>
<!-- =======================================================================================================================================================================================                     TAB 9               =============================================================================================================================================================================================================== -->
<div class="tab-pane" id="tab9">
    <table class="table table-bordered">
        <tbody><tr>
          <td scope="row" class="col-lg-8">
             Are you related by consanguinity or affinity to the appointing orrecommending authority, or to the chief of bureau or office or to the person who has immediate supervision over you in the office, Bureau or Department where you will be appointed,<br><br>
             a. within the third degree?<br>
             b. within the fourth degree (for Local Government Unit- Career Employees)?
         </td>
         <td scope="row" class="col-lg-1">
            <br><br><br><span class="icons"><span class="first-icon fa fa-circle-o fa-base"></span><span class="second-icon fa fa-dot-circle-o fa-base"></span></span><input type="radio" checked="" name="34a" value="YES"><label>YES</label><br>  
            <span class="icons"><span class="first-icon fa fa-circle-o fa-base"></span><span class="second-icon fa fa-dot-circle-o fa-base"></span></span><input type="radio" onclick="myFunction()" checked="" name="34b" value="YES"><label>YES</label>  <br>  
        </td>
        <td scope="row" class="col-lg-1"> 
            <br><br><br><span class="icons"><span class="first-icon fa fa-circle-o fa-base"></span><span class="second-icon fa fa-dot-circle-o fa-base"></span></span><input type="radio" name="34a" value="NO"><label>NO</label><br> 
            <span class="icons"><span class="first-icon fa fa-circle-o fa-base"></span><span class="second-icon fa fa-dot-circle-o fa-base"></span></span><input type="radio" onclick="myFunction1()" name="34b" value="NO"><label>NO</label> <br>            
        </td>
        <td scope="row" class="col-lg-3">
            <br><br>If YES, give details:<br>
            <input type="text" value="N/n" id="34detail" name="34detail" class="form-control">   
        </td>
    </tr>
    <tr>
      <td>
        <br> a. Have you ever been found guilty of any administrative offense?<br>
    </td>

    <td>
        <br><input type="radio" name="35a" onclick="myFunction2()" value="YES"><label>YES</label><br> 
    </td>
    <td>
        <br><input type="radio" name="35a" onclick="myFunction3()" checked="" value="NO"><label>NO</label><br>
    </td>     
    <td>
        If YES, give details:<br>
        <input type="text" value="" id="35detail" name="35detail" class="form-control">
    </td> 
</tr>

<tr>   
  <td>
    <br><br>b. Have you been criminally charged before any court?
</td>

<td>
    <br><br><input type="radio" name="35b" onclick="myFunction02()" value="YES"><label>YES</label>
</td>
<td>
    <br><br><input type="radio" name="35b" onclick="myFunction03()" checked="" value="NO"><label>NO</label><br>
</td>

<td>          
    If YES, give details:<br>
    Date Filed:
    <input type="date" value="" id="35bdate" name="35bdate" class="form-control">
    Status of Case/s:
    <input type="text" value="" id="35bstat" dis="" name="35bstat" class="form-control"> 
</td>
</tr>

<tr>
  <td>
    <br> Have you ever been convicted of any crime or violation of any law, decree, ordinance or regulation by any court or tribunal?
</td>

<td>
    <input type="radio" name="36a" onclick="myFunction4()" checked="" value="YES"><label>YES</label>
</td> 
<td>
    <input type="radio" name="36a" onclick="myFunction5()" value="NO"><label>NO</label><br>
</td>

<td>
    If YES, give details:<br>
    <input type="text" value="N/n" id="36detail" name="36detail" class="form-control">
</td>           
</tr>

<tr>
  <td>
     Have you ever been separated from the service in any of the following modes: resignation, retirement, dropped from the rolls, dismissal, termination, end of term, finished contract or phased out (abolition) in the public or private sector?
 </td>

 <td>
    <br><input type="radio" name="37a" onclick="myFunction6()" checked="" value="YES"><label>YES</label> 
</td>

<td>
    <br><input type="radio" name="37a" onclick="myFunction7()" value="NO"><label>NO</label>
</td> 

<td>
    If YES, give details:<br>
    <input type="text" value="N/n" id="37detail" name="37detail" class="form-control">   
</td>                   
</tr>

<tr>
  <td>
    <br>a. Have you ever been a candidate in a national or local election held within the last year (except Barangay election)?
</td> 

<td>
    <br><input type="radio" name="38a" onclick="myFunction8()" checked="" value="YES"><label>YES</label><br>
</td>
<td>
    <br><input type="radio" name="38a" onclick="myFunction9()" value="NO"><label>NO</label><br>
</td>

<td>
    If YES, give details:<br>
    <input type="text" value="N/n" id="38detail" name="38detail" class="form-control">   
</td>
</tr> 
<tr>
  <td>
    b. Have you resigned from the government service during the three (3)-month period before the last election to promote/actively campaign for a national or local candidate?
</td>

<td>
    <br><input type="radio" name="38b" onclick="myFunction10()" checked="" value="YES"><label>YES</label><br>
</td> 

<td>
    <br><input type="radio" name="38b" onclick="myFunction11()" value="NO"><label>NO</label><br>
</td> 
<td>
    If YES, give details:<br>
    <input type="text" value="N/n" id="38bdetail" name="38bdetail" class="form-control">
</td>     
</tr> 

<tr>
  <td>
    <br> Have you acquired the status of an immigrant or permanent resident of another country?<br>
</td>
<td>
    <br><input type="radio" name="39a" onclick="myFunction12()" checked="" value="YES"><label>YES</label><br>
</td>
<td>
    <br><input type="radio" name="39a" onclick="myFunction13()" value="NO"><label>NO</label><br>
</td>
<td>
    If YES, give details(country):<br>
    <input type="text" value="N/n" name="39detail" id="39detail" class="form-control">   
</td>
</tr> 

<tr>
  <td>
    <br> Pursuant to: (a) Indigenous People's Act (RA 8371); (b) Magna Carta for Disabled Persons (RA 7277); and (c) Solo Parents Welfare Act of 2000 (RA 8972), please answer the following items:  <br>  
    <br>a. Are you a member of any indigenous group?<br>
</td>

<td>
    <br><br><br><br><input type="radio" name="40a" onclick="myFunction14()" checked="" value="YES"><label>YES</label><br>    
</td>     

<td>
    <br><br><br><br><input type="radio" name="40a" onclick="myFunction15()" value="NO"><label>NO</label><br>
</td>

<td>
    <br><br>If YES, please specify:<br>
    <input type="text" value="N/n" id="40adetail" name="40adetail" class="form-control"> 
</td>
</tr>

<tr>
  <td>
    <br>b.Are you a person with disability?
</td>
<td>
    <br><input type="radio" name="40b" onclick="myFunction16()" checked="" value="YES"><label>YES</label><br>
</td>
<td>
    <br><input type="radio" name="40b" onclick="myFunction17()" value="NO"><label>NO</label><br>
</td>
<td>
    If YES, please specify ID No.:<br>
    <input type="text" value="N/n" id="40bdetail" name="40bdetail" class="form-control">
</td>
</tr>     

<tr>
  <td>
    <br>c. Are you a solo parent?
</td>
<td>
    <br><input type="radio" name="40b" onclick="myFunction16()" checked="" value="YES"><label>YES</label><br>
</td>
<td>
    <br><input type="radio" name="40b" onclick="myFunction17()" value="NO"><label>NO</label><br>
</td>
<td>
    If YES, please specify ID No.:<br>
    <input type="text" value="N/n" id="40cdetail" name="40cdetail" class="form-control">
</td>
</tr>
</tbody></table>
</div>
<!-- =======================================================================================================================================================================================                     TAB 10               =============================================================================================================================================================================================================== -->
<div class="tab-pane" id="tab10">
    <form class="form-signin" id="frm-references" method="POST" action="{{ route('UpdateReferences') }}">
     <input type="hidden" value="{{ Auth::user()->UserID }}" name="EmployeeID" id="EmployeeID">
     <input type="hidden" name="ID[0]" value="{{  isset($references[0]->ID)   ? $references[0]->ID : '' }}" id="" placeholder="" class="form-control name_list">
     <input type="hidden" name="ID[1]" value="{{  isset($references[1]->ID)  ? $references[1]->ID : '' }}" id="" placeholder="" class="form-control name_list">
     <input type="hidden" name="ID[2]" value="{{  isset($references[2]->ID)  ? $references[2]->ID : '' }}" id="" placeholder="" class="form-control name_list">

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
          <input type="text" name="Name[0]" value="{{  isset($references[0]->Name)  ? $references[0]->Name : '' }}" id="" placeholder="" class="form-control name_list">
      </td>

      <td>
          <input type="text" name="Address[0]" value="{{  isset($references[0]->Address) ? $references[0]->Address : '' }}" id="" placeholder="" class="form-control bday_list">
      </td> 

      <td>

        <input type="text" name="ContactNumber[0]"  value="{{  isset($references[0]->ContactNumber)  ? $references[0]->ContactNumber : '' }}" placeholder="" class="form-control name_list">
    </td>                                                                
</tr>
<tr>
    <td>
        <input type="text" name="Name[1]" value="{{  isset($references[1]->Name)   ? $references[1]->Name : '' }}" id="" placeholder="" class="form-control name_list">
    </td>

    <td>
      <input type="text" name="Address[1]" value="{{  isset($references[1]->Address)   ? $references[1]->Address : '' }}" id="" placeholder="" class="form-control bday_list">
  </td> 

  <td>

    <input type="text" id="tel2" name="ContactNumber[1]"  value="{{  isset($references[1]->ContactNumber)   ? $references[1]->ContactNumber : '' }}" placeholder="" class="form-control name_list">
</td>                                                                
</tr>
<tr>
    <td>
      <input type="text" name="Name[2]" value="{{  isset($references[2]->Name)   ? $references[2]->Name : '' }}" id="" placeholder="" class="form-control name_list">
  </td>

  <td>
      <input type="text" name="Address[2]" value="{{  isset($references[2]->Address)  ? $references[2]->Address : '' }}" id="" placeholder="" class="form-control bday_list">
  </td> 

  <td>

    <input type="text" id="tel3" name="ContactNumber[2]"  value="{{  isset($references[2]->ContactNumber)   ? $references[2]->ContactNumber : '' }}" placeholder="" class="form-control name_list">
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

</div>


</div>
</div>
</div>




</div>
</div>

@section('script')
<script type="text/javascript">


//==============================================
$('#frm-personal-information').on('submit', function(e){

    e.preventDefault();
    $("div").scrollTop(100)
    $('.nav-tabs > .active').next('li').find('a').trigger('click');

    var data = $(this).serialize();
    var url = $(this).attr('action');
    $.post(url,data,function(data){

    })
    $.notify({
        icon: 'ti-success',
        message: "Your Personal Information has been updated."

    },{
        type: 'success',
        timer: 4000
    });
})

$('#frm-family-background').on('submit', function(e){

    e.preventDefault();
    $("div").scrollTop(100)
    $('.nav-tabs > .active').next('li').find('a').trigger('click');

    var data = $(this).serialize();
    var url = $(this).attr('action');
    $.post(url,data,function(data){

    })
    $.notify({
        icon: 'ti-success',
        message: "Your Family Background has been updated."

    },{
        type: 'success',
        timer: 4000
    });
})

$('#frm-references').on('submit', function(e){

    e.preventDefault();
    $("div").scrollTop(100)
    $('.nav-tabs > .active').next('li').find('a').trigger('click');

    var data = $(this).serialize();
    var url = $(this).attr('action');
    $.post(url,data,function(data){

    })
    $.notify({
        icon: 'ti-success',
        message: "Your references has been updated."

    },{
        type: 'success',
        timer: 4000
    });
})
</script>
@endsection
@endsection