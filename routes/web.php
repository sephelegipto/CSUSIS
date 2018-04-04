<?php


Auth::routes();
Route::get('/', ['as'=>'/', 'uses'=>'LoginController@getLogin']);
Route::post('/login',['as'=>'login','uses'=>'LoginController@postLogin']);










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
	Route::get('/students', ['as'=>'students', 'uses'=>'Controller@student']);
	Route::get('/curriculumlist', ['as'=>'curriculumlist', 'uses'=>'curriculumController@index']);

	Route::get('/checklist/{id}/{title}/{years}/{major}', ['as'=>'checklist', 'uses'=>'curriculumController@viewchecklist']);


	Route::get('/studentlist/{id}', [ 'uses'=>'StudentController@adminstudentchecklist']);
	Route::post('/Student/Checklist/AddUpdateGrade', ['as'=>'AddUpdateGrade', 'uses'=>'StudentController@AddUpdateGrade']);

	
});

Route::group(['middleware'=>['authen','roles'],'roles'=>['student']],function(){
	Route::get('/student/checklist', ['as'=>'student/checklist', 'uses'=>'StudentController@Checklist']);
	Route::get('/student/enroll', ['as'=>'student/enroll', 'uses'=>'StudentController@Enroll']);
	
});

Route::get('/noPermission',function(){
	return "403 Forbidden or No Permission to Access";
});