<div class="modal fade" id="editworkexperience" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Edit Work Experience</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
      <form action="{{ route('editworkexperience') }}" method="POST" id="frm-edit-workexperience">
        <input type="hidden" value="" name="ID" id="edit-workexperience-ID">
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>InclusiveDateFrom</label>
              <input type="date" class="form-control border-input" name="InclusiveDateFrom" value="" id="edit-workexperience-InclusiveDateFrom">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>InclusiveDateTo</label>
              <input type="date" class="form-control border-input"  name="InclusiveDateTo" value="" id="edit-workexperience-InclusiveDateTo">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Position</label>
              <input type="text" class="form-control border-input"  name="Position" value="" id="edit-workexperience-Position">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Department</label>
              <input type="text" class="form-control border-input"  name="Department" value="" id="edit-workexperience-Department">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>MonthlySalary</label>
              <input type="text" class="form-control border-input"  name="MonthlySalary" value="" id="edit-workexperience-MonthlySalary">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>JobPay</label>
              <input type="text" class="form-control border-input" name="JobPay"  value="" id="edit-workexperience-JobPay">
            </div>
          </div>
        </div>
            <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>StatusAppointment</label>
              <input type="text" class="form-control border-input"  name="StatusAppointment" value="" id="edit-workexperience-StatusAppointment">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>GovernmentService</label>
              <input type="text" class="form-control border-input" name="GovernmentService"  value="" id="edit-workexperience-GovernmentService">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-xs-12">
            <div class="text-right">
              <button type="submit" class="btn btn-default next-tab" >Save</button>
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
           </div>
          </div>
        </div>        
      </form>
    </div>

  </div>
</div>
</div>