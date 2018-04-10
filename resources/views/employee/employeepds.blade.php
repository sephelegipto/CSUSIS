@extends('master')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card">

                <div class="content table-responsive "">

                   <ul id="tabs" class="nav nav-tabs">
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


                    <li class="next-tab"><a href="">&gt;</a></li>
                </ul>
                <div class="tab-content ">
                    <div class="tab-pane active" id="tab1">
                       <form class="form-signin" name="add_name" id="add_name" method="post" action="update/updatepersonal.php">
                        <table class="table table-bordered">
                          <tbody>
                            <tr>
                              <td width="21%" class="col-lg-2" scope="row">
                                <label for="">SURNAME:</label>
                            </td>
                            <td colspan="5">
                                <input type="text" name="surname" value="{{ $empDetails[0]->LastName }}" class="form-control">
                            </td>
                        </tr>
                        <tr>
                            <td scope="row" class="col-lg-2 text-capitalize">
                                <label for="">FIRST NAME:</label>
                            </td>
                            <td colspan="3">
                                <input type="text" name="firstname" value="{{ $empDetails[0]->FirstName }}" class="form-control">
                            </td>
                            <td width="22%" class="col-lg-2 text-capitalize" scope="row">
                                <label for="">EXTENSION NAME:</label>
                            </td>
                            <td width="17%">
                                <input type="text" placeholder="Extension Name" class="form-control col-lg-2" name="extensionname" value="{{ $empDetails[0]->ExtensionName }} ">
                            </td>
                        </tr> 
                        <tr>
                          <td scope="row" class="col-lg-2">
                            <label for="">MIDDLE NAME:</label>
                        </td>
                        <td colspan="5">
                            <input type="text" name="middlename" value="{{ $empDetails[0]->MiddleName }}" class="form-control">
                        </td>
                    </tr>
                    <tr>
                      <td scope="row" class="col-lg-2">
                        <label for="">DATE OF BIRTH:</label>
                    </td>
                    <td colspan="2"> 
                        <input type="date" name="dateofbirth" value="{{ $empDetails[0]->DOB }}" class="form-control " >
                    </td>
                    <td width="22%" rowspan="3" class="col-lg-2" scope="row">
                        <label for="">CITIZENSHIP:</label> <br><br><br><span style="color: red; font-weight: normal;">If holder of Dual Citizenship, <br> Please indicate the details.</span></td>
                        <td rowspan="3" colspan="2">

                          <div class="col-lg-6"> 
                             <select class="form-control col-lg-2" id="citizenship" name="citizenship">
                                <option>Dual Citizenship </option>
                                <option value="Filipino">Filipino </option>
                                <option value="Dual Citizenship">Dual Citizenship</option>
                                <option value="By Birth">by birth</option>
                                <option value="By Naturalization">by naturalization</option>
                            </select>
                        </div>
                        <br> <br><br> <br><br> 

                        <div class="col-lg-6">
                            <select name="country" class="form-control" style="width:100%">
                              <option>Benin</option>
                              <option value="Algeria">Algeria</option>

                              <option value="Adorra">Adorra</option>

                              <option value="Angola">Angola</option>

                              <option value="Antigua and Barbuda">Antigua and Barbuda</option>

                              <option value="Argentina">Argentina</option>

                              <option value="Armenia">Armenia</option>

                              <option value="Aruba">Aruba</option>

                              <option value="Australia">Australia</option>

                              <option value="Austria">Austria</option>

                              <option value="Azerbaijan">Azerbaijan</option>

                              <option value="Bahamas, The">Bahamas, The</option>

                              <option value="Bahrain">Bahrain</option>

                              <option value="Bangladesh">Bangladesh</option>

                              <option value="Barbados">Barbados</option>

                              <option value="Belarus">Belarus</option>

                              <option value="Belguim">Belguim</option>

                              <option value="Belize">Belize</option>

                              <option value="Benin">Benin</option>

                              <option value="Bhutan">Bhutan</option>

                              <option value="Bolivia">Bolivia</option>

                              <option value="Bosnia and Herzegovina">Bosnia and Herzegovina</option>

                              <option value="Botswana">Botswana</option>

                              <option value="Brazil">Brazil</option>

                              <option value="Brunei">Brunei</option>

                              <option value="Bulgaria">Bulgaria</option>

                              <option value="Burkina Faso">Burkina Faso</option>

                              <option value="Burma">Burma</option>

                              <option value="Burundi">Burundi</option>

                              <option value="Cambodia">Cambodia</option>

                              <option value="Cameroon">Cameroon</option>

                              <option value="Canada">Canada</option>

                              <option value="Cape Verde">Cape Verde</option>

                              <option value="Central Africa Republic">Central Africa Republic</option>

                              <option value="Chad">Chad</option>

                              <option value="Chile">Chile</option>

                              <option value="China">China</option>

                              <option value="Colombia">Colombia</option>

                              <option value="Comoros">Comoros</option>

                              <option value="Congo, Democratic Republic of the ">Congo, Democratic Republic of the </option>

                              <option value="Congo, Republic of the">Congo, Republic of the</option>

                              <option value="Costa Rica">Costa Rica</option>

                              <option value="Cote d'Ivoire">Cote d'Ivoire</option>

                              <option value="Croatia">Croatia</option>

                              <option value="Cuba">Cuba</option>

                              <option value="Curacao">Curacao</option>

                              <option value="Cyprus">Cyprus</option>

                              <option value="Czech Rebuplic">Czech Rebuplic</option>

                              <option value="Djibouti">Djibouti</option>

                              <option value="Dominica">Dominica</option>

                              <option value="Dominican Republic">Dominican Republic</option>

                              <option value="East Timor">East Timor</option>

                              <option value="Ecuador">Ecuador</option>

                              <option value="Egypt">Egypt</option>

                              <option value="El Salvador">El Salvador</option>

                              <option value="Equatorial Guinea">Equatorial Guinea</option>

                              <option value="Eritrea">Eritrea</option>

                              <option value="Estonia">Estonia</option>

                              <option value="Ethiopia">Ethiopia</option>

                              <option value="Fiji">Fiji</option>

                              <option value="Finland">Finland</option>

                              <option value="France">France</option>

                              <option value="Gabon">Gabon</option>

                              <option value="Gambia, The">Gambia, The</option>

                              <option value="Georgia">Georgia</option>

                              <option value="Germany">Germany</option>

                              <option value="Ghana">Ghana</option>

                              <option value="Greence">Greence</option>

                              <option value="Grenada">Grenada</option>

                              <option value="Guatemala">Guatemala</option>

                              <option value="Guinea">Guinea</option>

                              <option value="Guinea-Bissau">Guinea-Bissau</option>

                              <option value="Guyana">Guyana</option>

                              <option value="Haiti">Haiti</option>

                              <option value="Holy See">Holy See</option>

                              <option value="Honduras">Honduras</option>

                              <option value="Hong Kong">Hong Kong</option>

                              <option value="Hungary">Hungary</option>

                              <option value="Iceland">Iceland</option>

                              <option value="India">India</option>

                              <option value="Indonesia">Indonesia</option>

                              <option value="Iran">Iran</option>

                              <option value="Iraq">Iraq</option>

                              <option value="Ireland">Ireland</option>

                              <option value="Israel">Israel</option>

                              <option value="Italy">Italy</option>

                              <option value="Jamaica">Jamaica</option>

                              <option value="Japan">Japan</option>

                              <option value="Jordan">Jordan</option>

                              <option value="kazakhstan">kazakhstan</option>

                              <option value="Kenya">Kenya</option>

                              <option value="Kiribati">Kiribati</option>

                              <option value="Korea, North">Korea, North</option>

                              <option value="Korea, South">Korea, South</option>

                              <option value="Kosovo">Kosovo</option>

                              <option value="Kuwait">Kuwait</option>

                              <option value="Kyrgyzstan">Kyrgyzstan</option>

                              <option value="Laos">Laos</option>

                              <option value="Latvia">Latvia</option>

                              <option value="Lebanon">Lebanon</option>

                              <option value="Lesotho">Lesotho</option>

                              <option value="Liberia">Liberia</option>

                              <option value="Libya">Libya</option>

                              <option value="Lietchtenstein">Lietchtenstein</option>

                              <option value="Lithuania">Lithuania</option>

                              <option value="Luxembourg">Luxembourg</option>

                              <option value="Macau">Macau</option>

                              <option value="Macedonia">Macedonia</option>

                              <option value="Madagascar">Madagascar</option>

                              <option value="Malawi">Malawi</option>

                              <option value="Malaysia">Malaysia</option>

                              <option value="Maldives">Maldives</option>

                              <option value="Mali">Mali</option>

                              <option value="Malta">Malta</option>

                              <option value="Marshall Islands">Marshall Islands</option>

                              <option value="Mauritania">Mauritania</option>

                              <option value="Mauritius">Mauritius</option>

                              <option value="Mexico">Mexico</option>

                              <option value="Micronesia">Micronesia</option>

                              <option value="Moldova">Moldova</option>

                              <option value="Monaco">Monaco</option>

                              <option value="Mongolia">Mongolia</option>

                              <option value="Montenegro">Montenegro</option>

                              <option value="Morocco">Morocco</option>

                              <option value="Mozambique">Mozambique</option>

                              <option value="Namibia">Namibia</option>

                              <option value="Nauru">Nauru</option>

                              <option value="Nepal">Nepal</option>

                              <option value="Netherlands">Netherlands</option>

                              <option value="Netherlands Antilles">Netherlands Antilles</option>

                              <option value="New Zealand">New Zealand</option>

                              <option value="Nicaragua">Nicaragua</option>

                              <option value="Niger">Niger</option>

                              <option value="Nigeria">Nigeria</option>

                              <option value="North Korea">North Korea</option>

                              <option value="Norway">Norway</option>

                              <option value="Oman">Oman</option>

                              <option value="Pakistan">Pakistan</option>

                              <option value="Palau">Palau</option>

                              <option value="Palestinian Territories">Palestinian Territories</option>

                              <option value="Panama">Panama</option>

                              <option value="Papua New Guinea">Papua New Guinea</option>

                              <option value="Paraguay">Paraguay</option>

                              <option value="Peru">Peru</option>

                              <option value="Philippines">Philippines</option>

                              <option value="Poland">Poland</option>

                              <option value="Portugal">Portugal</option>

                              <option value="Qatar">Qatar</option>

                              <option value="Romania">Romania</option>

                              <option value="Russia">Russia</option>

                              <option value="Rwanda">Rwanda</option>

                              <option value="Saint Kitts and Nevis">Saint Kitts and Nevis</option>

                              <option value="Saint Lucia">Saint Lucia</option>

                              <option value="Saint Vincent and the Grenadines">Saint Vincent and the Grenadines</option>

                              <option value="Samoa">Samoa</option>

                              <option value="San Marino">San Marino</option>

                              <option value="Sao Tome and Principe">Sao Tome and Principe</option>

                              <option value="Saudi Arabia">Saudi Arabia</option>

                              <option value="Senegal">Senegal</option>

                              <option value="Serbia">Serbia</option>

                              <option value="Seychelles">Seychelles</option>

                              <option value="Sierra Leone">Sierra Leone</option>

                              <option value="Singapore">Singapore</option>

                              <option value="Sint Maarten">Sint Maarten</option>

                              <option value="Slovokia">Slovokia</option>

                              <option value="Slovenia">Slovenia</option>

                              <option value="Solomon Islands">Solomon Islands</option>

                              <option value="South Africa">South Africa</option>

                              <option value="South Korea">South Korea</option>

                              <option value="South Sudan">South Sudan</option>

                              <option value="Spain">Spain</option>

                              <option value="Sri Lanka ">Sri Lanka </option>

                              <option value="Sudan">Sudan</option>

                              <option value="Suriname">Suriname</option>

                              <option value="Swaziland">Swaziland</option>

                              <option value="Sweden">Sweden</option>

                              <option value="Switzerland">Switzerland</option>

                              <option value="Syria">Syria</option>

                              <option value="Taiwan">Taiwan</option>

                              <option value="Tajikistan">Tajikistan</option>

                              <option value="Tanzania">Tanzania</option>

                              <option value="Thailand">Thailand</option>

                              <option value="Timor-Letse">Timor-Letse</option>

                              <option value="Tongo">Tongo</option>

                              <option value="Trinidad and Tobago">Trinidad and Tobago</option>

                              <option value="Tunisia">Tunisia</option>

                              <option value="Turkey">Turkey</option>

                              <option value="Turkmenistan">Turkmenistan</option>

                              <option value="Tuvalu">Tuvalu</option>

                              <option value="Uganda">Uganda</option>

                              <option value="Ukraine">Ukraine</option>

                              <option value="United Arab Emirates">United Arab Emirates</option>

                              <option value="United Kingdom">United Kingdom</option>

                              <option value="Uruguay">Uruguay</option>

                              <option value="Uzbekistan">Uzbekistan</option>

                              <option value="Vanuatu">Vanuatu</option>

                              <option value="Venezuela">Venezuela</option>

                              <option value="Vietnam">Vietnam</option>

                              <option value="Yemen">Yemen</option>

                              <option value="Zambia">Zambia</option>

                              <option value="Zimbabwe">Zimbabwe</option>

                              <option value=""></option>

                              <option value=""></option>


                          </select>
                      </div>
                  </td>
              </tr>
              <tr>
                  <td scope="row" class="col-lg-2">
                    <label for="">PLACE OF BIRTH:</label>
                </td>
                <td colspan="2"> 
                    <input type="text" name="placeofbirth" value="{{ $empDetails[0]->POB }}" class="form-control " >
                </td>
            </tr>
            <tr>
               <td scope="row" class="col-lg-2"> <label for="">SEX:</label></td>
               <td colspan="2">
                <select class="form-control col-lg-2" name="sex">                                 
                   <option {{  $empDetails[0]->Gender == 'MALE'  ? 'SELECTED' : '' }} value="Male">Male</option>                              
                   <option {{ $empDetails[0]->Gender == 'FEMALE'  ? 'SELECTED' : '' }} value="Female">Female</option>
               </select>
           </td>
       </tr>
       <tr>
           <td scope="row" class="col-lg-2">
            <label for="">CIVIL STATUS:</label>
        </td>
        <td colspan="2"> 
           <select class="form-control col-lg-2" name="civilstatus">

            <option {{  $empDetails[0]->CivilStatus == 'Single'  ? 'SELECTED' : '' }} value="Single">Single</option>                  
            <option {{  $empDetails[0]->CivilStatus == 'Married'  ? 'SELECTED' : '' }} value="Married">Married</option>                                       
            <option {{  $empDetails[0]->CivilStatus == 'Widowed'  ? 'SELECTED' : '' }} value="Widowed">Widowed</option>
            <option {{  $empDetails[0]->CivilStatus == 'Seperated'  ? 'SELECTED' : '' }} value="Seperated">Seperated</option>
        </select>
    </td>
    <td rowspan="3">
        <label for="">RESIDENTIAL ADDRESS:</label>
        <br><br><br><br><br>
        <input type="text" name="zip1" value="{{ $empDetails[0]->ResZipCode }}" class="form-control" >
        <center>
            <label for="" style="font-size:12px; text-align:center">ZIP CODE</label>
        </center>
    </td>
    <td> 
        <input type="text" name="house1" value="{{ $empDetails[0]->ResHouseBlockLotNo }}" class="form-control " >
        <label for="" style="font-size:12px; text-align:center">HOUSE/BLOCK/LOT NO.</label>
    </td>
    <td>
        <input type="text" name="street1" value="{{ $empDetails[0]->ResStreet }}" class="form-control  " >
        <center>
            <label for="" style="font-size:12px; text-align:center">STREET</label>
        </center>
    </td>
</tr>
<tr>
   <td scope="row" class="col-lg-2"> <label for="">HEIGHT (m):</label></td>
   <td colspan="2">  
    <input type="text" name="height" value="{{ $empDetails[0]->Height }}" class="form-control" > 
</td>
<td>
    <input type="text" name="subdi1" value="{{ $empDetails[0]->ResSubDiv }}" class="form-control  " >
    <center>
        <label for="" style="font-size:12px; text-align:center">SUBDIVISION/VILLAGE</label>
    </center>
</td>
<td>
    <input type="text" name="barangay1" value="{{ $empDetails[0]->ResBrngy }}" class="form-control  " >
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
    <input type="text" name="weight" value="{{ $empDetails[0]->Weight }}" class="form-control">
</td>
<td>
    <input type="text" name="city1" value="{{ $empDetails[0]->ResCity }}" class="form-control">
    <center>
        <label for="" style="font-size:12px; text-align:center">CITY/MUNICIPALITY
        </label>
    </center>
</td>
<td>
    <input type="text" name="province1" value="{{ $empDetails[0]->ResProvince }}" class="form-control">
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
        <select class="form-control col-lg-2" name="bloodtype">
          <option value="A+" {{  $empDetails[0]->BloodType == 'A+'  ? 'SELECTED' : '' }} >A+</option>
          <option value="B+" {{  $empDetails[0]->BloodType == 'B+'  ? 'SELECTED' : '' }}>B+</option>
          <option value="AB+" {{  $empDetails[0]->BloodType == 'AB+'  ? 'SELECTED' : '' }}>AB+</option>
          <option value="O+" {{  $empDetails[0]->BloodType == 'O+'  ? 'SELECTED' : '' }}>O+</option>
      </select>
  </td>
  <td rowspan="3">
    <label for="">PERMANENT ADDRESS:</label>
    <br><br><br><br><br>
    <input type="text" name="zip2" value="{{ $empDetails[0]->PermZipCode }}" class="form-control" placeholder="Zip Code" >
    <center>
        <label for="" style="font-size:12px; text-align:center">ZIP CODE</label>
    </center>
</td>
<td>
    <input type="text" name="house2" value="{{ $empDetails[0]->PermHouseBlockLotNo }}" class="form-control " >
    <center>
        <label for="" style="font-size:12px; text-align:center">HOUSE/BLOCK/LOT NO.</label>
    </center>
</td>
<td>
    <input type="text" name="street2" value="{{ $empDetails[0]->PermStreet }}" class="form-control " >
    <center>
        <label for="" style="font-size:12px; text-align:center">STREET</label>
    </center>
</td>
</tr>
<tr>
    <td scope="row" class="col-lg-2"> <label for="">GSIS ID NO.</label></td>
    <td colspan="2"> 
        <input type="text" name="gsisidno" value="{{ $empDetails[0]->GSIS }}" class="form-control" > 
    </td>
    <td>
        <input type="text" name="subdi2" value="{{ $empDetails[0]->PermSubDiv }}" class="form-control  " >
        <center>
            <label for="" style="font-size:12px; text-align:center">SUBDIVISION/VILLAGE</label>
        </center>
    </td>
    <td>
        <input type="text" name="barangay2" value="{{ $empDetails[0]->PermBrngy }}" class="form-control">
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
    <input type="text" id="pagibig" name="pagibigidno"  value="{{ $empDetails[0]->PAGIBIG }}" class="form-control" >
</td>
<td>
    <input type="text" name="city2" value="{{ $empDetails[0]->PermCity }}" class="form-control  " >
    <center>
        <label for="" style="font-size:12px; text-align:center">CITY/MUNICIPALITY</label>
    </center>
</td>
<td>
    <input type="text" name="province2" value="{{ $empDetails[0]->PermProvince }}" class="form-control  " >
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
    <input type="text" id="philhealth" name="philhealthno" value="{{ $empDetails[0]->PHILHEALTH }}" class="form-control" > 
</td>
<td colspan="3">  </td>
</tr>
<tr>
   <td scope="row" class="col-lg-2"> <label for="">SSS NO.</label></td>

   <td colspan="2">
    <input type="text" id="sss" name="sssno" value="{{ $empDetails[0]->SSS }}" class="form-control" >  
</td>
<td scope="row" class="col-lg-2"> 
    <label for="">TELEPHONE NO.</label>
</td>

<td colspan="3"><input type="text" id="tel" name="telno" value="{{ $empDetails[0]->Telephone }}" class="form-control" >  </td>

</tr>
<tr>
   <td scope="row" class="col-lg-2"> <label for="">TIN:</label></td>

   <td colspan="2"> 
    <input type="text" id="tin" name="tinno" value="{{ $empDetails[0]->TIN }}" class="form-control" >   
</td>
<td scope="row" class="col-lg-2"><label for="">MOBILE NO.</label></td>

<td colspan="2">
    <input type="text" id="mobile" name="mobileno" value="{{ $empDetails[0]->PhoneNumber }}" class="form-control" >
</td>
</tr>
<tr>
   <td scope="row" class="col-lg-2"> 
    <label for="">AGENCY EMPLOYEE NO:</label>
</td>
<td colspan="2"> 
    <input type="text" name="agencyemployeeno" value="{{ $empDetails[0]->AGENCYEMPLOYEENO }}" class="form-control" > 
</td>
<td scope="row" class="col-lg-2"> <label for="">E-MAIL ADDRESS (if any):</label></td>
<td colspan="2">
    <input type="text" name="emailadd" value="{{ $empDetails[0]->Email }}" class="form-control" >
</td>
</tr>

</tbody>
</table>

<br>

<input type="submit" name="submit" value="SAVE" style=" height:35px;  background-color:#09f; border-color:#09f; margin-top:20px; margin-bottom:20px; padding:5px 20px; border:#09f 1px solid; border-radius: 4px; color:#fff;"> <br><br><br>
</form>
</div>

<!-- =======================================================================================================================================================================================                     TAB 2               =============================================================================================================================================================================================================== -->





<div class="tab-pane" id="tab2">
    <table class="table table-bordered">
      <tbody><tr>
        <th width="40%" class="col-lg-3" scope="row">
            <label for="">SPOUSE SURNAME:</label>
        </th>
        <td colspan="2"><input type="text" name="ssurname" value="{{ $empDetails[0]->sSurname }}" class="form-control " autofocus=""></td>
    </tr>
    <tr>
        <th scope="row" class="col-lg-3">
          <label for="">FIRST NAME:</label> 
      </th>
      <td width="43%"><input type="text" name="sfirstname" value="{{ $empDetails[0]->sFirstname }}" class="form-control " autofocus=""></td>

      <td width="17%">
        <label for="">EXTENSION NAME:</label> 
        <input type="text" placeholder="Extension Name" class="form-control" name="sextensionname" value="{{ $empDetails[0]->sExtentionname }}">
    </td>
</tr>
<tr>
    <th scope="row" class="col-lg-3">
        <label for="">MIDDLE NAME:</label>
    </th>
    <td colspan="2"><input type="text" name="smiddlename" value="{{ $empDetails[0]->sMiddlename }}" class="form-control " autofocus=""></td>
</tr>
<tr>
    <th scope="row" class="col-lg-3">
        <label for="">OCCUPATION:</label>
    </th>
    <td colspan="2"> <input type="text" name="occupation" value="{{ $empDetails[0]->sOccupation }}" class="form-control " autofocus=""></td>
</tr>
<tr>
    <th scope="row" class="col-lg-3">
        <label for="">EMPLOYER/BUSINESS NAME:</label>
    </th>
    <td colspan="2"><input type="text" name="businessname" value="{{ $empDetails[0]->sBusinessname }}" class="form-control " autofocus=""></td>
</tr>
<tr>
    <th scope="row" class="col-lg-3">
     <label for="">BUSINESS ADDRESS:</label>
 </th>
 <td colspan="2"><input type="text" name="businessaddress" value="{{ $empDetails[0]->sBusinessaddress }}" class="form-control " autofocus=""></td>
</tr>
<tr>
    <th scope="row" class="col-lg-3">
        <label for="">TELEPHONE NO.:</label>
    </th>
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
<td colspan="2"><input type="text" id="stel" name="stelno" onkeyup="meme()" value="{{ $empDetails[0]->sTel }}" class="form-control" autofocus="">  </td>
</tr>
<tr>
    <th scope="row" class="col-lg-3">
     <label for="">FATHER'S  SURNAME:</label>
 </th>
 <td colspan="2"><input type="text" name="fsurname" value="{{ $empDetails[0]->fSurname }}" class="form-control " autofocus=""></td>
</tr>
<tr>
    <th scope="row" class="col-lg-3">
     <label for="">FIRST NAME:</label>
 </th>
 <td><input type="text" name="ffirstname" value="{{ $empDetails[0]->fFirstname }}" class="form-control " autofocus=""></td>

 <td>
    <label for="">EXTENSION NAME:</label> 
    <input type="text" placeholder="Extension Name" class="form-control " name="fextensionname" value="{{ $empDetails[0]->fExtensionname }}">
</td>
</tr>
<tr>
    <th scope="row" class="col-lg-3">
        <label for="">MIDDLE NAME:</label>
    </th>
    <td colspan="2"><input type="text" name="fmiddlename" value="{{ $empDetails[0]->fMiddlename }}" class="form-control " autofocus=""></td>
</tr>
<tr>
    <th scope="row" class="col-lg-3">
     <label for="">MOTHER'S MAIDEN NAME:</label>
 </th>
 <td colspan="2"><input type="text" name="mmaidenname" value="{{ $empDetails[0]->mMaidenname }}" class="form-control " autofocus=""></td>
</tr>
<tr>
    <th scope="row" class="col-lg-3">
     <label for="">SURNAME:</label>
 </th>
 <td colspan="2"><input type="text" name="msurname" value="{{ $empDetails[0]->mSurname }}" class="form-control " autofocus=""> </td>
</tr>
<tr>
    <th scope="row" class="col-lg-3">
     <label for="">FIRST NAME:</label>
 </th>
 <td colspan="2"><input type="text" name="mfirstname" value="{{ $empDetails[0]->mFirstname }}" class="form-control " autofocus=""> </td>
</tr>
<tr>
    <th scope="row" class="col-lg-3">
        <label for="">MIDDLE NAME:</label>
    </th>
    <td colspan="2"> <input type="text" name="mmiddlename" value="{{ $empDetails[0]->mMiddlename }}" class="form-control " autofocus="">  </td>
</tr>
</tbody></table>
<table style="" class="table table-bordered" id="dynamic-feild2" >
 <tr  class="success">
   <th>CHILDREN NAME (Write in Full)</th>
   <th>CHILDREN BIRTHDAY</th>
   <th></th>
</tr>
<tr>
    <td>
      <input  type="text"  name="name[]" id="name" placeholder="Children Name"  class="form-control has-success name_list">
  </td>
  <td>
      <input type="date" name="bday[]" id="bday" placeholder=""  class="form-control bday_list">
  </td>      
  <td>
    <button type="button" name="add" id="addq" class="btn btn-success btn-block btn-block">Add More</button>

</td>
</tr>
</table>
</div>
<!-- =======================================================================================================================================================================================                     TAB 3               =============================================================================================================================================================================================================== -->
<div class="tab-pane" id="tab3">
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
       <td><input type="text" name="elemname" class="form-control"  autofocus ></td>
       <td> <input type="text" name="elembasic" class="form-control" autofocus ></td>
       <td> <input type="text" name="elemfrom" class="form-control col-lg-3"  autofocus ></td>
       <td><input type="text" name="elemto" class="form-control col-lg-3"  autofocus ></td>
       <td><input type="text" name="elemhigh" class="form-control" autofocus > </td>
       <td><input type="text" name="elemgrad" class="form-control col-lg-3"  autofocus ></td>
       <td><input type="text" name="elemscholar" class="form-control col-lg-3"  autofocus ></td>
   </tr>

   <tr>
    <th class="success" scope="row">
      <label for="">SECONDARY</label>
  </th>
  <td><input type="text" name="secname" class="form-control"  autofocus ></td>

  <td> <input type="text" name="secbasic" class="form-control" autofocus > </td>

  <td><input type="text" name="secfrom" class="form-control col-lg-3 "  autofocus ></td>

  <td><input type="text" name="secto" class="form-control col-lg-3 "  autofocus></td>

  <td><input type="text" name="sechigh" class="form-control " autofocus > </td>

  <td><input type="text" name="secgrad" class="form-control col-lg-3 "  autofocus ></td>

  <td><input type="text" name="secscholar" class="form-control col-lg-3 "  autofocus ></td>
</tr>

<tr>
    <th class="success" scope="row">
      <label for="">VOCATIONAL/TRADE COURSE</label>
  </th>
  <td><input type="text" name="vocname" class="form-control "  autofocus="" ></td>

  <td> <input type="text" name="vocbasic" class="form-control " autofocus > </td>

  <td><input type="text" name="vocfrom" class="form-control col-lg-3 " autofocus ></td>

  <td><input type="text" name="vocto" class="form-control col-lg-3 " autofocus></td>

  <td><input type="text" name="vochigh" class="form-control " autofocus ></td>

  <td><input type="text" name="vocgrad" class="form-control col-lg-3 "  autofocus="" ></td>

  <td> <input type="text" name="vocscholar" class="form-control col-lg-3 " autofocus ></td>
</tr>


<tr>
    <th class="success" scope="row">
       <label for="">COLLEGE</label>
   </th>
   <td><input type="text" name="colname" class="form-control "  autofocus ></td>

   <td> <input type="text" name="colbasic" class="form-control " autofocus > </td>

   <td><input type="text" name="colfrom" class="form-control col-lg-3 "  autofocus ></td>

   <td><input type="text" name="colto" class="form-control col-lg-3 "  autofocus></td>

   <td><input type="text" name="colhigh" class="form-control " autofocus ></td>

   <td><input type="text" name="colgrad" class="form-control col-lg-3 "  autofocus ></td>

   <td> <input type="text" name="colscholar" class="form-control col-lg-3 "  autofocus ></td>
</tr>
<tr>
    <th class="success" scope="row">
       <label for="">GRADUATE STUDIES </label>
   </th>
   <td>
    <input  type="text"  name="gradname" id="gradname" placeholder=""  class="form-control  name_list"/>
</td>

<td>
    <input type="text" name="gradbasic" id="gradbasic" placeholder=""  class="form-control  bday_list"/>
</td> 

<td>
    <input  type="text"  name="gradfrom" id="gradfrom" placeholder=""  class="form-control  name_list"/>
</td>

<td>
    <input type="text" name="gradto" id="gradto" placeholder=""  class="form-control bday_list"/>
</td> 

<td>
    <input  type="text"  name="gradhigh" id="gradhigh" placeholder=""  class="form-control  name_list"/>
</td>

<td>
    <input type="text" name="gradgrad" id="gradgrad" placeholder=""  class="form-control bday_list"/>
</td> 

<td>
    <input  type="text"  name="gradscholar" id="gradscholar" placeholder=""  class="form-control  name_list"/>
</td>

</tr>
</table> 
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
    <label class="radio-inline">
      <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2"> <span class='color red'></span>
  </label>

  
</td>
<td>
      <label class="radio-inline">
      <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2"> <span class='color red'></span>
  </label>
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
          <input type="text" name="refname1" value="Atty. Mary Dine" id="" placeholder="" class="form-control name_list">
      </td>

      <td>
          <input type="text" name="refaddress1" value="Carig Sur, Tuguegarao City" id="" placeholder="" class="form-control bday_list">
      </td> 

      <td>
         <script>
           function lala()
           {
               var x=tel1.value;
               if(x.length==4)
                 tel1 .value=tel1.value+" ";
             if(x.length==8)
              tel1.value=tel1.value+" ";
      }
  </script>
  <input type="text" id="tel1" name="reftellno1" onkeyup="lala()" value="0925 675 8394" placeholder="" class="form-control name_list">
</td>                                                                
</tr>
<tr>
    <td>
      <input type="text" name="refname2" value="Atty. Fausto Dela Cruz" id="" placeholder="" class="form-control name_list">
  </td>

  <td>
      <input type="text" name="refaddress2" value="Atulayan Norte, Tuguegarao City" id="" placeholder="" class="form-control bday_list">
  </td> 

  <td>
     <script>
      function lele()
      {
       var x=tel2.value;
       if(x.length==4)
         tel2 .value=tel2.value+" ";
     if(x.length==8)
      tel2.value=tel2.value+" ";
}
</script>
<input type="text" id="tel2" name="reftellno2" onkeyup="lele()" value="0972 052 0423" placeholder="" class="form-control name_list">
</td>                                                                
</tr>
<tr>
    <td>
      <input type="text" name="refname3" value="Dr. Jerry B. Sagabaen III" id="" placeholder="" class="form-control name_list">
  </td>

  <td>
      <input type="text" name="refaddress3" value="Pengue Ruyu , Tuguegarao City" id="" placeholder="" class="form-control bday_list">
  </td> 

  <td>
     <script>
      function lili()
      {
       var x=tel3.value;
       if(x.length==4)
         tel3 .value=tel3.value+" ";
     if(x.length==8)
      tel3.value=tel3.value+" ";
}
</script>
<input type="text" id="tel3" name="reftellno3" onkeyup="lili()" value="0923 456 712" placeholder="" class="form-control name_list">
</td>                                                                
</tr>

</tbody></table>
</div>

</div>


</div>
</div>
</div>




</div>
</div>

@section('script')
<script type="text/javascript">
    $('.next-tab').click(function(e){
      if($('#tabs > .active').next('li').hasClass('next-tab')){
        $('#tabs > li').first('li').find('a').trigger('click');
    }else{
        $('.nav-tabs > .active').next('li').find('a').trigger('click');
    }
    e.preventDefault();
});


</script>
@endsection
@endsection