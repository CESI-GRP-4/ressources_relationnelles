<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class StatusRessource extends Model {

    protected $table = 'status_ressources';

    protected $primaryKey = 'id_status';

    public $timestamps = false;

    protected $fillable = ['label'];

}
