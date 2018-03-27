<?php


Auth::routes();
Route::get('/', ['as'=>'/', 'uses'=>'LoginController@getLogin']);
Route::post('/login',['as'=>'login','uses'=>'LoginController@postLogin']);
Route::get('/read', function () {
	$temployees = DB::select("call spContactViewAllORSearch('')");
	dump($temployees);
});

Route::get('/read/{id}', function ($id) {
	$temployees = DB::select("call spContactViewAllORSearch(?)", [$id]);
	dump($temployees);
});

Route::get('/insert', function () {
	$ContactID = 0;
	$ContactName = 0;
	$Address = 0;
	$Contact = 0;
	$temployees = DB::select("call spContactsAddOREdit(?,?,?,?)",[$ContactID, $ContactName, $Address, $Contact]);
	echo 'success';
});

Route::get('/delete/{id}', function ($id) {
	$temployees = DB::select("call spContactDeletebyID(?)",[$id]);
	echo 'deleted';
});




Route::get('test/{id}', function ($id)
{
	$employee = DB::select("call spLibraryViewAllORSearch('Employees','$id')");
	dump($employee);
	return response()->make($employee[0]->ProfilePicture, 200, array(
		'Content-Type' => (new finfo(FILEINFO_MIME))->buffer($employee[0]->ProfilePicture)
	));	
});


Route::group(['middleware'=>['authen']], function(){
	Route::get('/dashboard', ['as'=>'dashboard', 'uses'=>'Controller@dashboard']);
	Route::get('/logout',['as'=>'logout', 'uses'=>'LoginController@getLogout']);
	Route::get('/admin',['as'=>'admin', 'uses'=>'AdminController@dashboard']);
	Route::get('/studentPage',['as'=>'studentPage', 'uses'=>'AdminController@student']);
	Route::get('/login/index', 'LoginController@index');
});

Route::group(['middleware'=>['authen','roles'],'roles'=>['admin']],function(){
	Route::get('/employee', ['as'=>'employee', 'uses'=>'Controller@employee']);
	Route::get('/department', ['as'=>'department', 'uses'=>'Controller@department']);
	Route::get('/building', ['as'=>'building', 'uses'=>'Controller@building']);
	Route::get('/courses', ['as'=>'courses', 'uses'=>'CourseController@index']);

	Route::get('/curriculumlist', ['as'=>'curriculumlist', 'uses'=>'curriculumController@index']);

	Route::get('/checklist/{id}/{title}/{years}/{major}', ['as'=>'checklist', 'uses'=>'curriculumController@viewchecklist']);

	
});

Route::group(['middleware'=>['authen','roles'],'roles'=>['student']],function(){
	Route::get('/student/checklist', ['as'=>'student/checklist', 'uses'=>'StudentController@Checklist']);

	
});

Route::get('/noPermission',function(){
	return "403 Forbidden or No Permission to Access";
});