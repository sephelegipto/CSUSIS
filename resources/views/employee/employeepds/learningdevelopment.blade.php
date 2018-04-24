         <div class="tab-pane content content table-responsive " id="tab7">
          <table class="table table-striped table-hover" id="learndev-table">
           <tbody><tr>
             <th class="success text-center  col-lg-4">Title of Learning and Development Intervention/Training Programs</th>
             <th class="success text-center  col-lg-1 ">Inclusive Dates of Attendance From</th>
             <th class="success text-center  col-lg-1 ">Inclusive Dates of Attendance To</th>
             <th class="success text-center  col-lg-1 ">Number of Hours</th>
             <th class="success text-center  col-lg-3 ">Type of LD( Managerial/ Supervisory/Technical/etc)</th>
             <th class="success text-center  col-lg-3 ">Conducted /Sponsored by</th>
             <th colspan="2" class="success text-center  col-lg-1 text-center">Action</th>    
           </tr> 

           @foreach($learningdev as $learndev)
           <tr class="learndev{{$learndev->ID}}">
             <td class="col-lg-2 ">{{$learndev->Title}}</td>
             <td class="col-lg-2 ">{{$learndev->InclusiveDateFrom}}</td> 
             <td class="col-lg-2 ">{{$learndev->InclusiveDateTo}}</td>
             <td class="col-lg-2 ">{{$learndev->NoOfHours}}</td> 
             <td class="col-lg-2 ">{{$learndev->TypeOfLD}}</td>
             <td class="col-lg-2 ">{{$learndev->ConductedBy}}</td>
             <td>
              <button class="edit-learningdevelopment-button btn btn-info" data-id="{{$learndev}}">
                <span class="glyphicon glyphicon-edit"></span> 
              </button>
            </td>
            <td>
              <button id="delete-learningdevelopment-button" class="delete-modal btn btn-danger" data-id="{{$learndev}}">
                <span class="glyphicon glyphicon-trash"></span> 
              </button>
            </td>

          </tr>
          @endforeach
        </tbody></table>
        <button type="button" class="btn btn-primary pull-right" id="add-learningdevelopment-button">
          Add
        </button>
      </div>