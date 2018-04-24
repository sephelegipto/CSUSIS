<div class="modal fade" id="editlearningdevelopment" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Edit Learning Development</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
    <form action="{{ route('EditLearningDevelopment') }}" method="POST" id="frm-edit-learningdevelopment">
    <input type="hidden" class="form-control border-input" name="ID" value="" id="edit-learningdevelopment-ID">
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Title of Learning and Development</label>
              <input type="text" class="form-control border-input" name="Title" value="" id="edit-learningdevelopment-Title">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Inclusive Dates From</label>
              <input type="date" class="form-control border-input"  name="InclusiveDateFrom" value="" id="edit-learningdevelopment-InclusiveDateFrom">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Inclusive Dates To</label>
              <input type="date" class="form-control border-input"  name="InclusiveDateTo" value="" id="edit-learningdevelopment-InclusiveDateTo">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Number of Hours</label>
              <input type="text" class="form-control border-input"  name="NoOfHours" value="" id="edit-learningdevelopment-NoOfHours">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Type of LD</label>
              <input type="text" class="form-control border-input"  name="TypeOfLD" value="" id="edit-learningdevelopment-TypeOfLD">
            </div>
          </div>
     <div class="col-md-6">
            <div class="form-group">
              <label>PConducted /Sponsored by</label>
              <input type="text" class="form-control border-input"  name="ConductedBy" value="" id="edit-learningdevelopment-ConductedBy">
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