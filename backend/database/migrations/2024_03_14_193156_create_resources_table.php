<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('resources', function (Blueprint $table) {
            $table->id();
            $table->string('label', 255);
            $table->text('description');
            $table->text('content');
            $table->unsignedInteger('id_category');
            $table->unsignedInteger('id_user')->nullable()->default(null);
      
            $table->boolean('is_public')->nullable()->change();
            $table->integer('view_count')->nullable()->change();
            $table->timestamp('updated_at')->nullable()->change();
            $table->string('file_path')->nullable();
           
        });
    }

    public function down()
    {
        Schema::table('resources', function (Blueprint $table) {
            $table->dropForeign(['id_user']);
            $table->dropForeign(['id_category']);
            $table->timestamp('updated_at')->nullable(false)->change();
                });

        Schema::dropIfExists('resources');
    }
};
