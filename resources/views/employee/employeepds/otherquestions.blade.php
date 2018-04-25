        <div class="tab-pane" id="tab9">
          <form class="form-signin" id="frm-a-otherquestions" method="POST" action="{{ route('AddUpdateOtherQuestion') }}">
            <table class="table table-bordered">
              <tbody>
                <tr>
                  <td scope="row" class="col-lg-8">
                   Are you related by consanguinity or affinity to the appointing orrecommending authority, or to the chief of bureau or office or to the person who has immediate supervision over you in the office, Bureau or Department where you will be appointed,<br><br>
                   a. within the third degree?<br>
                   b. within the fourth degree (for Local Government Unit- Career Employees)?
                 </td>
                 <td scope="row" class="col-lg-1">
                  <br><br><br>


                </span>
              </span>
              <input type="radio" name="Question1" value="1"  {{ $answers[0]->Question1 ? 'CHECKED' : '' }}>
              <label>YES</label>
              <br>  

              <input type="radio" name="Question2" value="1" {{ $answers[0]->Question2 ? 'CHECKED' : '' }}>
              <label>YES</label> 
              <br>  
            </td>
            <td scope="row" class="col-lg-1"> 
              <br><br><br><span class="icons"><span class="first-icon fa fa-circle-o fa-base"></span><span class="second-icon fa fa-dot-circle-o fa-base"></span></span>
              <input type="radio" name="Question1" value="0" {{ $answers[0]->Question1 ? '' : 'CHECKED' }}>
              <label>NO</label><br> 
              <span class="icons"><span class="first-icon fa fa-circle-o fa-base"></span><span class="second-icon fa fa-dot-circle-o fa-base"></span></span>
              <input type="radio" name="Question2" value="0" {{ $answers[0]->Question2 ? '' : 'CHECKED' }}>
              <label>NO</label> <br>            
            </td>
            <td scope="row" class="col-lg-3">
              <br><br>If YES, give details:<br>
              <input type="text" value="{{ $answers[0]->Remark1}}"  name="Remark1" class="form-control">   
            </td>
          </tr>
          <tr>
            <td>
              <br> a. Have you ever been found guilty of any administrative offense?<br>
            </td>

            <td>
              <br><input type="radio" name="Question3" value="1" {{ $answers[0]->Question3 ? 'CHECKED' : '' }}><label>YES</label><br> 
            </td>
            <td>
              <br><input type="radio" name="Question3" value="0" {{ $answers[0]->Question3 ? '' : 'CHECKED' }}><label>NO</label><br>
            </td>     
            <td>
              If YES, give details:<br>
              <input type="text" value="{{ $answers[0]->Remark2}}"  name="Remark2" class="form-control">
            </td> 
          </tr>

          <tr>   
            <td>
              <br><br>b. Have you been criminally charged before any court?
            </td>

            <td>
              <br><br><input type="radio" name="Question4" value="1" {{ $answers[0]->Question4 ? 'CHECKED' : '' }}><label>YES</label>
            </td>
            <td>
              <br><br><input type="radio" name="Question4"  value="0" {{ $answers[0]->Question4 ? '' : 'CHECKED' }}><label>NO</label><br>
            </td>

            <td>          
              If YES, give details:<br>
              Date Filed:
              <input type="date" value="{{ $answers[0]->Remark3}}"  name="Remark3" class="form-control">
              Status of Case/s:
              <input type="text" value="{{ $answers[0]->Remark4}}" name="Remark4" class="form-control"> 
            </td>
          </tr>

          <tr>
            <td>
              <br> Have you ever been convicted of any crime or violation of any law, decree, ordinance or regulation by any court or tribunal?
            </td>

            <td>
              <input type="radio" name="Question5"  value="1" {{ $answers[0]->Question5 ? 'CHECKED' : '' }}><label>YES</label>
            </td> 
            <td>
              <input type="radio" name="Question5" value="0" {{ $answers[0]->Question5 ? '' : 'CHECKED' }}><label>NO</label><br>
            </td>

            <td>
              If YES, give details:<br>
              <input type="text" value="{{ $answers[0]->Remark5}}"  name="Remark5" class="form-control">
            </td>           
          </tr>

          <tr>
            <td>
             Have you ever been separated from the service in any of the following modes: resignation, retirement, dropped from the rolls, dismissal, termination, end of term, finished contract or phased out (abolition) in the public or private sector?
           </td>

           <td>
            <br><input type="radio" name="Question6" value="1" {{ $answers[0]->Question6 ? 'CHECKED' : '' }}><label>YES</label> 
          </td>

          <td>
            <br><input type="radio" name="Question6" value="0" {{ $answers[0]->Question6 ? '' : 'CHECKED' }}><label>NO</label>
          </td> 

          <td>
            If YES, give details:<br>
            <input type="text" value="{{ $answers[0]->Remark6}}"  name="Remark6" class="form-control">   
          </td>                   
        </tr>

        <tr>
          <td>
            <br>a. Have you ever been a candidate in a national or local election held within the last year (except Barangay election)?
          </td> 

          <td>
            <br><input type="radio" name="Question7"  value="1" {{ $answers[0]->Question7 ? 'CHECKED' : '' }}><label>YES</label><br>
          </td>
          <td>
            <br><input type="radio" name="Question7"  value="0" {{ $answers[0]->Question7 ? '' : 'CHECKED' }}><label>NO</label><br>
          </td>

          <td>
            If YES, give details:<br>
            <input type="text" value="{{ $answers[0]->Remark7}}"  name="Remark7" class="form-control">   
          </td>
        </tr> 
        <tr>
          <td>
            b. Have you resigned from the government service during the three (3)-month period before the last election to promote/actively campaign for a national or local candidate?
          </td>

          <td>
            <br><input type="radio" name="Question8"  value="1" {{ $answers[0]->Question8 ? 'CHECKED' : '' }}><label>YES</label><br>
          </td> 

          <td>
            <br><input type="radio" name="Question8"  value="0" {{ $answers[0]->Question8 ? '' : 'CHECKED' }}><label>NO</label><br>
          </td> 
          <td>
            If YES, give details:<br>
            <input type="text" value="{{ $answers[0]->Remark8}}"  name="Remark8" class="form-control">
          </td>     
        </tr> 

        <tr>
          <td>
            <br> Have you acquired the status of an immigrant or permanent resident of another country?<br>
          </td>
          <td>
            <br><input type="radio" name="Question9"  value="1" {{ $answers[0]->Question9 ? 'CHECKED' : '' }}><label>YES</label><br>
          </td>
          <td>
            <br><input type="radio" name="Question9"  value="0" {{ $answers[0]->Question9 ? '' : 'CHECKED' }}><label>NO</label><br>
          </td>
          <td>
            If YES, give details(country):<br>
            <input type="text" value="{{ $answers[0]->Remark9}}" name="Remark9"  class="form-control">   
          </td>
        </tr> 

        <tr>
          <td>
            <br> Pursuant to: (a) Indigenous People's Act (RA 8371); (b) Magna Carta for Disabled Persons (RA 7277); and (c) Solo Parents Welfare Act of 2000 (RA 8972), please answer the following items:  <br>  
            <br>a. Are you a member of any indigenous group?<br>
          </td>

          <td>
            <br><br><br><br><input type="radio" name="Question10"  value="1" {{ $answers[0]->Question10 ? 'CHECKED' : '' }}><label>YES</label><br>    
          </td>     

          <td>
            <br><br><br><br><input type="radio" name="Question10"  value="0" {{ $answers[0]->Question10 ? '' : 'CHECKED' }}><label>NO</label><br>
          </td>

          <td>
            <br><br>If YES, please specify:<br>
            <input type="text" value="{{ $answers[0]->Remark10}}"  name="Remark10" class="form-control"> 
          </td>
        </tr>

        <tr>
          <td>
            <br>b.Are you a person with disability?
          </td>
          <td>
            <br><input type="radio" name="Question11"  value="1" {{ $answers[0]->Question11 ? 'CHECKED' : '' }}><label>YES</label><br>
          </td>
          <td>
            <br><input type="radio" name="Question11"  value="0" {{ $answers[0]->Question11 ? '' : 'CHECKED' }}><label>NO</label><br>
          </td>
          <td>
            If YES, please specify ID No.:<br>
            <input type="text" value="{{ $answers[0]->Remark11}}"  name="Remark11" class="form-control">
          </td>
        </tr>     

        <tr>
          <td>
            <br>c. Are you a solo parent?
          </td>
          <td>
            <br><input type="radio" name="Question12"  value="1" {{ $answers[0]->Question12 ? 'CHECKED' : '' }}><label>YES</label><br>
          </td>
          <td>
            <br><input type="radio" name="Question12"  value="0" {{ $answers[0]->Question12 ? '' : 'CHECKED' }}><label>NO</label><br>
          </td>
          <td>
            If YES, please specify ID No.:<br>
            <input type="text" value="{{ $answers[0]->Remark12}}"  name="Remark12" class="form-control">
          </td>
        </tr>
      </tbody></table>
      <button type="submit" class="btn btn-primary pull-right">
        Save
      </button>
    </form>
  </div>