<div class="modal fade" id="add-voluntarilywork" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Add Voluntary Work</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <form action="{{ route('AddVoluntarilyWork') }}" method="POST" id="frm-add-voluntarywork">
        <input type="hidden" value="{{ $UserID[0] }}" name="EmployeeID" id="EmployeeID">
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Name and Address of Organization</label>
              <input type="text" class="form-control border-input" name="NameOfOrg" value="">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Inclusive Dates From</label>
              <input type="date" class="form-control border-input"  name="InclusiveDateFrom" value="">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Inclusive Dates To</label>
              <input type="date" class="form-control border-input"  name="InclusiveDateTo" value="">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Number of Hours</label>
              <input type="text" class="form-control border-input"  name="NoOfHours" value="">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Position / Nature of Work</label>
              <input type="text" class="form-control border-input"  name="Position" value="">
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