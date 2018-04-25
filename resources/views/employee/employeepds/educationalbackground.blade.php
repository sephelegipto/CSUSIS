          <div class="tab-pane content content table-responsive  " id="tab3">
           <form class="form-signin" id="frm-personal-information" method="POST" action="{{ route('UpdatePersonalInfo') }}">




             <table class="table table-bordered" id="dynamic-graduate">

              <thead>
                <tr class="success">
                  <th scope="row" rowspan="2" >
                    <center>
                      <label for="">LEVEL</label>
                    </center>
                  </th>
                  <th rowspan="2" style="width: 16.66%">
                    <center>
                      <label for="">NAME OF SCHOOL<br>(Write in full)</label>
                    </center>
                  </th>
                  <th scope="row" rowspan="2" >
                    <label for="">BASIC EDUCATIONAL/DEGREE/COURSE<br>(Write in full)</label>
                  </th>
                  <th scope="row"  colspan="2" >
                    <label for="">PERIOD OF ATTENDANCE</label>
                  </th>
                  <th scope="row" rowspan="2" >
                    <label for="">HIGHEST LEVEL/ UNITS EARNED <br>(If not graduated)</label>
                  </th>
                  <th scope="row" rowspan="2" >
                    <label for=""> YEAR GRADUATED</label>
                  </th>
                  <th scope="row" rowspan="2" >
                    <label for="">SCHOLARSHIP/ ACADEMIC HONORS RECEIVED</label>
                  </th>

                </tr>
                <tr class="success" colspan='4'">
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
                  <input type="text" name="elemname" class="form-control" value="{{$ELEMENTARY[0]->NameOfSchool}}">
                </td>
                <td>
                  <input type="text" name="elembasic" class="form-control" value="{{$ELEMENTARY[0]->EducationDegreeCourse}}">
                </td>
                <td>
                  <input type="text" name="elemfrom" class="form-control col-lg-3" value="{{$ELEMENTARY[0]->From}}">
                </td>
                <td>
                  <input type="text" name="elemto" class="form-control col-lg-3"   value="{{$ELEMENTARY[0]->To}}">
                </td>
                <td>
                  <input type="text" name="elemhigh" class="form-control" value="{{$ELEMENTARY[0]->UnitsEarned}}"> 
                </td>
                <td>
                  <input type="text" name="elemgrad" class="form-control col-lg-3" value="{{$ELEMENTARY[0]->YearGraduated}}">
                </td>
                <td>
                  <input type="text" name="elemscholar" class="form-control col-lg-3" value="{{$ELEMENTARY[0]->AcademicHonors}}">
                </td>
              </tr>

              <tr>
                <th class="success">
                  <label for="">SECONDARY</label>
                </th>
                <td>
                  <input type="text" name="secname" class="form-control" value="{{$SECONDARY[0]->NameOfSchool}}">
                </td>

                <td> 
                  <input type="text" name="secbasic" class="form-control" value="{{$SECONDARY[0]->EducationDegreeCourse}}"> 
                </td>
                <td>
                  <input type="text" name="secfrom" class="form-control col-lg-3 " value="{{$SECONDARY[0]->From}}">
                </td>

                <td><input type="text" name="secto" class="form-control col-lg-3 "  value="{{$SECONDARY[0]->To}}"></td>

                <td><input type="text" name="sechigh" class="form-control "  value="{{$SECONDARY[0]->UnitsEarned}}"> </td>

                <td><input type="text" name="secgrad" class="form-control col-lg-3 "  value="{{$SECONDARY[0]->YearGraduated}}" ></td>

                <td><input type="text" name="secscholar" class="form-control col-lg-3 "  value="{{$SECONDARY[0]->AcademicHonors}}" ></td>
              </tr>

              <tr>
                <th class="success" scope="row">
                  <label for="">VOCATIONAL/TRADE COURSE</label>
                </th>
                <td>
                  <input type="text" name="vocname" class="form-control "  value="{{$VOCATIONAL[0]->NameOfSchool}}" >
                </td>

                <td> <input type="text" name="vocbasic" class="form-control " value="{{$VOCATIONAL[0]->EducationDegreeCourse}}"> </td>

                <td><input type="text" name="vocfrom" class="form-control col-lg-3 " value="{{$VOCATIONAL[0]->From}}"></td>

                <td><input type="text" name="vocto" class="form-control col-lg-3 " value="{{$VOCATIONAL[0]->To}}"></td>

                <td><input type="text" name="vochigh" class="form-control " value="{{$VOCATIONAL[0]->UnitsEarned}}"></td>

                <td><input type="text" name="vocgrad" class="form-control col-lg-3 "   value="{{$VOCATIONAL[0]->YearGraduated}}"></td>

                <td> <input type="text" name="vocscholar" class="form-control col-lg-3 " value="{{$VOCATIONAL[0]->AcademicHonors}}"></td>
              </tr>


              <tr>
                <th class="success" scope="row">
                 <label for="">COLLEGE</label>
               </th>
               <td><input type="text" name="colname" class="form-control "  value="{{$COLLEGE[0]->NameOfSchool}}"></td>

               <td> <input type="text" name="colbasic" class="form-control " value="{{$COLLEGE[0]->EducationDegreeCourse}}"></td>

               <td><input type="text" name="colfrom" class="form-control col-lg-3 " value="{{$COLLEGE[0]->From}}"></td>

               <td><input type="text" name="colto" class="form-control col-lg-3 " value="{{$COLLEGE[0]->To}}"></td>

               <td><input type="text" name="colhigh" class="form-control " value="{{$COLLEGE[0]->UnitsEarned}}"></td>

               <td><input type="text" name="colgrad" class="form-control col-lg-3 "  value="{{$COLLEGE[0]->YearGraduated}}"></td>

               <td> <input type="text" name="colscholar" class="form-control col-lg-3 "  value="{{$COLLEGE[0]->AcademicHonors}}"></td>
             </tr>
             <tr>
              <th class="success" scope="row">
               <label for="">GRADUATE STUDIES </label>
             </th>
             <td>
              <input  type="text"  name="gradname" id="gradname" placeholder=""  class="form-control" value="{{$GRADUATE[0]->NameOfSchool}}"/>
            </td>

            <td>
              <input type="text" name="gradbasic" id="gradbasic" placeholder=""  class="form-control" value="{{$GRADUATE[0]->EducationDegreeCourse}}"/>
            </td> 

            <td>
              <input  type="text"  name="gradfrom" id="gradfrom" placeholder=""  class="form-control" value="{{$GRADUATE[0]->From}}"/>
            </td>

            <td>
              <input type="text" name="gradto" id="gradto" placeholder=""  class="form-control" value="{{$GRADUATE[0]->To}}"/>
            </td> 

            <td>
              <input  type="text"  name="gradhigh" id="gradhigh" placeholder=""  class="form-control" value="{{$GRADUATE[0]->UnitsEarned}}"/>
            </td>

            <td>
              <input type="text" name="gradgrad" id="gradgrad" placeholder=""  class="form-control" value="{{$GRADUATE[0]->YearGraduated}}"/>
            </td> 

            <td>
              <input  type="text"  name="gradscholar" id="gradscholar" placeholder=""  class="form-control" value="{{$GRADUATE[0]->AcademicHonors}}"/>
            </td>

          </tr>

        </table> 
        <div class="row">
          <div class="col-xs-12">
            <div class="text-right">
              <button type="submit" class="btn btn-default next-tab" >Save</button>
          
            </div>
          </div>
        </div> 
      </form>
    </div>