<div class="modal fade" id="add-otherinformation" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Add Learning Development</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <form action="{{ route('AddOtherInformation') }}" method="POST" id="frm-add-otherinformation">
        <input type="hidden" value="{{ $UserID[0] }}" name="EmployeeID" id="EmployeeID">
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Special Skill and Hobbies</label>
              <input type="text" class="form-control border-input" name="Skills" value="">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Non-Academic Distinction/ Recognition</label>
              <input type="text" class="form-control border-input"  name="Recognition" value="">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Membership in Association/ Organization</label>
              <input type="text" class="form-control border-input"  name="Organization" value="">
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