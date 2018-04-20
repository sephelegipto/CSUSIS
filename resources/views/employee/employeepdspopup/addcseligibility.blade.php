<div class="modal fade" id="add-cseligibility" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <form action="{{ route('AddCSEligibility') }}" method="POST" id="frm-add-cseligibility">
        <input type="hidden" value="{{ $UserID[0] }}" name="EmployeeID" id="EmployeeID">
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Career Service</label>
              <input type="text" class="form-control border-input" name="CareerService" value="">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Rating</label>
              <input type="text" class="form-control border-input"  name="Rating" value="">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Date of Examination</label>
              <input type="date" class="form-control border-input"  name="DateOfExamination" value="">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Place of Examination</label>
              <input type="text" class="form-control border-input"  name="PlaceOfExamination" value="">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>License Number</label>
              <input type="text" class="form-control border-input"  name="LicenseNumber" value="">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Date of Validity</label>
              <input type="date" class="form-control border-input" name="DateValidity"  value="">
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