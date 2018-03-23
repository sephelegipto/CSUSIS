<div class="sidebar-wrapper">
    <div class="logo">
        <a href="{{ route('dashboard') }}" class="simple-text">

            <img src="{{ asset('images/csu.png') }}" alt="">

        </a>

    </div>
    @if (Auth::user()->role_id === 1)
    <ul class="nav">
        <li id="dashboard">
            <a  href="{{ route('dashboard') }}">
                <i class="ti-panel"></i>
                <p>Dashboard</p>
            </a>
        </li>
        <li id="employee">
            <a  href="{{ route('employee') }}">
                <i class="ti-user"></i>
                <p>Employee</p>
            </a>
        </li>
        <li id="department">
            <a href="{{ route('department') }}">
                <i class="ti-view-list-alt"></i>
                <p>Department</p>
            </a>
        </li>
        <li id="building">
            <a href="{{ route('building') }}">
                <i class="ti-layout-grid3"></i>
                <p>Building</p>
            </a>
        </li>
        <li id="courses">
            <a href="{{ route('courses') }}">
                <i class="ti-layout-grid3"></i>
                <p>Courses</p>
            </a>
        </li>
        <li id="curriculumlist">
            <a href="{{ route('curriculumlist') }}">
                <i class="ti-layout-grid3"></i>
                <p>Curriculums</p>
            </a>
        </li>
        <li>
            <a href="{{route('log-viewer::dashboard')}}">
                <i class="ti-pencil-alt2"></i>
                <p>Logs</p>
            </a>
        </li>
        <li>
            <a href="maps.html">
                <i class="ti-map"></i>
                <p>Maps</p>
            </a>
        </li>
        <li>
            <a href="notifications.html">
                <i class="ti-bell"></i>
                <p>Notifications</p>
            </a>
        </li>

    </ul>
    @elseif (Auth::user()->role_id === 2)
    <ul class="nav">
     
        <li id="employee">
            <a  href="{{ route('employee') }}">
                <i class="ti-user"></i>
                <p>Class List</p>
            </a>
        </li>
   
    </ul>

    @elseif (Auth::user()->role_id === 3)
    <ul class="nav">
        <li id="dashboard">
            <a  href="{{ route('dashboard') }}">
                <i class="ti-panel"></i>
                <p>Checklist</p>
            </a>
        </li>
        <li id="employee">
            <a  href="{{ route('employee') }}">
                <i class="ti-user"></i>
                <p>Certificate of Grades</p>
            </a>
        </li>
      
        
      
     
    
   

    </ul>
    @endif

</div>