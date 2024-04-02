<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Resource extends Model
{
    use HasFactory;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'resources';

    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'id_resource';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'label',
        'description',
        'content',
        'id_category',
        'is_public', 
        'view_count', 
        'id_user',    
        'id_status',  
        'updated_at',  
        'created_at',
        'file',
    ];

    public function category()
    {
        return $this->belongsTo(Category::class, 'id_category');
    }
}
