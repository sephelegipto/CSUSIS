<div class="modal fade" id="deletelearningdevelopment" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Delete Learning and Development</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="{{ route('DeleteLearningAndDevelopment')}}" method="POST" id="frm-del-learningdevelopment">
          {{ csrf_field() }}
          <input class="form-control" type="hidden" value="" id="delete-learningdev-id" name="ID">
          <div class="deleteContent">
            Are you sure you want to remove <span id="deletelearningdev"></span> ?
          </div>
          <div class="row">

            <div class="col-xs-12">
              <div class="text-right">
                <button type="submit" class="btn btn-default next-tab">Yes</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>

              </div>
            </div>
          </div>
        </form>
      </div>

    </div>
  </div>
</div>