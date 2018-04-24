<div class="modal fade" id="editotherinformation" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Edit other information</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
    <form action="{{ route('EditOtherInformation') }}" method="POST" id="frm-edit-otherinformation">
    <input type="hidden" class="form-control border-input" name="ID" value="" id="edit-otherinfo-ID">
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Title of Learning and Development</label>
              <input type="text" class="form-control border-input" name="Skills" value="" id="edit-otherinfo-Skills">
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label>Inclusive Dates From</label>
              <input type="text" class="form-control border-input"  name="Recognition" value="" id="edit-otherinfo-Recognition">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label>Inclusive Dates To</label>
              <input type="text" class="form-control border-input"  name="Organization" value="" id="edit-otherinfo-Organization">
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