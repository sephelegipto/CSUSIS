<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTusersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tusers', function (Blueprint $table) {
         $table->increments('id');
         $table->string('UserID');
         $table->string('LoginID');

         $table->string('password');
         $table->integer('role_id');
         $table->rememberToken();
         $table->timestamps();
     });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tusers');
    }
}
