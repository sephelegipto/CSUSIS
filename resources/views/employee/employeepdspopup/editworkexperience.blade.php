<div class="modal fade" id="editcseligibility" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
      <form action="{{ route('EditCSEligibility') }}" method="POST" id="frm-edit-cseligibility">
        <input type="hidden" value="" name="ID" id="edit-cseligibility-ID">
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Career Service</label>
              <input type="text" class="form-control border-input" name="CareerService" value="" id="edit-cseligibility-CareerService">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Rating</label>
              <input type="text" class="form-control border-input"  name="Rating" value="" id="edit-cseligibility-Rating">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Date of Examination</label>
              <input type="date" class="form-control border-input"  name="DateOfExamination" value="" id="edit-cseligibility-DateOfExamination">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Place of Examination</label>
              <input type="text" class="form-control border-input"  name="PlaceOfExamination" value="" id="edit-cseligibility-PlaceOfExamination">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>License Number</label>
              <input type="text" class="form-control border-input"  name="LicenseNumber" value="" id="edit-cseligibility-LicenseNumber">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Date of Validity</label>
              <input type="date" class="form-control border-input" name="DateValidity"  value="" id="edit-cseligibility-DateValidity">
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