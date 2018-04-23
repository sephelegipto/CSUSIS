<div class="modal fade" id="editvoluntarilywork" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Edit Voluntarily Work</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
    <form action="{{ route('EditVoluntarilyWork') }}" method="POST" id="frm-edit-voluntarywork">
    <input type="hidden" class="form-control border-input" name="ID" value="" id="edit-voluntary-ID">
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Name and Address of Organization</label>
              <input type="text" class="form-control border-input" name="NameOfOrg" value="" id="edit-voluntary-NameOfOrg">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Inclusive Dates From</label>
              <input type="date" class="form-control border-input"  name="InclusiveDateFrom" value="" id="edit-voluntary-InclusiveDateFrom">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Inclusive Dates To</label>
              <input type="date" class="form-control border-input"  name="InclusiveDateTo" value="" id="edit-voluntary-InclusiveDateTo">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Number of Hours</label>
              <input type="text" class="form-control border-input"  name="NoOfHours" value="" id="edit-voluntary-NoOfHours">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Position / Nature of Work</label>
              <input type="text" class="form-control border-input"  name="Position" value="" id="edit-voluntary-Position">
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