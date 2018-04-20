<div class="modal fade" id="add-workexperience" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <form action="{{ route('AddWorkExperience') }}" method="POST" id="frm-add-workexperience">
        <input type="hidden" value="{{ $UserID[0] }}" name="EmployeeID" id="EmployeeID">
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Inclusive Dates From</label>
              <input type="date" class="form-control border-input" name="InclusiveDateFrom" value="">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Inclusive Dates To</label>
              <input type="date" class="form-control border-input"  name="InclusiveDateTo" value="">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Position Title</label>
              <input type="text" class="form-control border-input"  name="Position" value="">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Departmnet/Agency/Office/Company</label>
              <input type="text" class="form-control border-input"  name="Department" value="">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Monthly Salary</label>
              <input type="text" class="form-control border-input"  name="MonthlySalary" value="">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Salary /Job Pay</label>
              <input type="text" class="form-control border-input" name="JobPay"  value="">
            </div>
          </div>
        </div>
         <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Status Appointment</label>
              <input type="text" class="form-control border-input"  name="StatusAppointment" value="">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Gov't Service</label>
              <input type="text" class="form-control border-input" name="GovernmentService"  value="">
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