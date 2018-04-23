<div class="modal fade" id="addchildren" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <form action="{{ route('AddChildren') }}" method="POST" id="frm-add-children">
        

        <div class="form-group row">
          <label for="example-text-input" class="col-2 col-form-label">Text</label>
          <div class="col-10">
            <input class="form-control" name="Name" type="text" value="" id="example-text-input">
          </div>
        </div>
        <div class="form-group row">
          <label for="example-search-input" class="col-2 col-form-label">Search</label>
          <div class="col-10">
            <input class="form-control" name="Birthday" type="date" value="" id="example-search-input">
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