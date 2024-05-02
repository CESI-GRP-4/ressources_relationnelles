<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class StatusComment extends Model {

    protected $table = 'status_comments';

    protected $primaryKey = 'id_status';

    public $timestamps = false;

    protected $fillable = ['label'];

}
