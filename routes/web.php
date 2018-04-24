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

	Route::get('/courses', ['as'=>'courses', 'uses'=>'AdminController@ViewCourse']);
	Route::get('/employee', ['as'=>'employee', 'uses'=>'AdminController@ViewEmployee']);
	Route::get('/colleges', ['as'=>'colleges', 'uses'=>'AdminController@ViewCollege']);
	Route::get('/building', ['as'=>'building', 'uses'=>'AdminController@ViewBuilding']);
	Route::get('/students', ['as'=>'students', 'uses'=>'AdminController@ViewStudent']);
	Route::get('/curriculumlist', ['as'=>'curriculumlist', 'uses'=>'AdminController@ViewCurriculumList']);
	Route::post('/Student/Checklist/AddUpdateGrade', ['as'=>'AddUpdateGrade', 'uses'=>'StudentController@AddUpdateGrade']);
	Route::get('/studentlist/{id}', [ 'uses'=>'AdminStudentController@ViewStudentChecklist']);
	Route::get('/evaluate/{id}', ['as'=>'evaluate', 'uses'=>'AdminStudentController@EvaluateStudent']);
	Route::get('/checklist/{id}/{title}/{years}/{major}', ['as'=>'checklist', 'uses'=>'AdminCurriculumController@ViewCurriculumChecklist']);	
	Route::get('/upload/{id}', ['as'=>'upload', 'uses'=>'AdminCollegeController@ViewUploadPage']);

	Route::post('upload/ImportSubjects', [ 'as'=>'ImportSubjects','uses'=>'AdminCollegeController@ImportSubjects']);

});

Route::group(['middleware'=>['authen','roles'],'roles'=>['FACULTY']],function(){

	Route::get('/employee/pds', ['as'=>'employee/pds', 'uses'=>'EmployeeController@ViewPds']);

	Route::post('UpdatePersonalInfo', ['as'=>'UpdatePersonalInfo', 'uses'=>'EmployeeController@UpdatePersonalInformation']);

	Route::post('UpdateFamilyBackground', ['as'=>'UpdateFamilyBackground', 'uses'=>'EmployeeController@UpdateFamilyBackground']);

	Route::post('AddChildren', ['as'=>'AddChildren', 'uses'=>'EmployeeController@AddChildren']);
	Route::post('EditChildren', ['as'=>'EditChildren', 'uses'=>'EmployeeController@EditChildren']);
	Route::post('DeleteChildren', ['as'=>'DeleteChildren', 'uses'=>'EmployeeController@DeleteChildren']);

	Route::post('AddCSEligibility', ['as'=>'AddCSEligibility', 'uses'=>'EmployeeController@AddCSEligibility']);
	Route::post('EditCSEligibility', ['as'=>'EditCSEligibility', 'uses'=>'EmployeeController@EditCSEligibility']);
	Route::post('DeleteCSEligibility', ['as'=>'DeleteCSEligibility', 'uses'=>'EmployeeController@DeleteCSEligibility']);

	Route::post('AddWorkExperience', ['as'=>'AddWorkExperience', 'uses'=>'EmployeeController@AddWorkExperience']);
	Route::post('editworkexperience', ['as'=>'editworkexperience', 'uses'=>'EmployeeController@EditWorkexperience']);
	Route::post('DeleteWorkExperience', ['as'=>'DeleteWorkExperience', 'uses'=>'EmployeeController@DeleteWorkExperience']);

	Route::post('AddVoluntarilyWork', ['as'=>'AddVoluntarilyWork', 'uses'=>'EmployeeController@AddVoluntarilyWork']);
	Route::post('EditVoluntarilyWork', ['as'=>'EditVoluntarilyWork', 'uses'=>'EmployeeController@EditVoluntarilyWork']);
	Route::post('DeleteVoluntaryWork', ['as'=>'DeleteVoluntaryWork', 'uses'=>'EmployeeController@DeleteVoluntaryWork']);

	Route::post('AddLearningDevelopment', ['as'=>'AddLearningDevelopment', 'uses'=>'EmployeeController@AddLearningDevelopment']);
	Route::post('EditLearningDevelopment', ['as'=>'EditLearningDevelopment', 'uses'=>'EmployeeController@EditLearningDevelopment']);
	Route::post('EditLearningDevelopment', ['as'=>'EditLearningDevelopment', 'uses'=>'EmployeeController@EditLearningDevelopment']);

	Route::post('AddOtherInformation', ['as'=>'AddOtherInformation', 'uses'=>'EmployeeController@AddOtherInformation']);
	Route::post('EditOtherInformation', ['as'=>'EditOtherInformation', 'uses'=>'EmployeeController@EditOtherInformation']);
	Route::post('DeleteOtherInformation', ['as'=>'DeleteOtherInformation', 'uses'=>'EmployeeController@DeleteOtherInformation']);
	
	Route::post('UpdateReferences', ['as'=>'UpdateReferences', 'uses'=>'EmployeeController@UpdateReferences']);
	Route::post('DeleteLearningAndDevelopment', ['as'=>'DeleteLearningAndDevelopment', 'uses'=>'EmployeeController@DeleteLearningAndDevelopment']);


});

Route::group(['middleware'=>['authen','roles'],'roles'=>['student']],function(){
	Route::get('/student/checklist', ['as'=>'student/checklist', 'uses'=>'StudentController@Checklist']);
	Route::get('/student/enroll', ['as'=>'student/enroll', 'uses'=>'StudentController@Enroll']);
	
});

Route::get('/noPermission',function(){
	return "403 Forbidden or No Permission to Access";
});