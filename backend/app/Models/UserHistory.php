<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @OA\Schema(
 *     schema="UserHistoryRecord",
 *     type="object",
 *     description="A record of an action performed on a user",
 *     @OA\Property(property="userModified", ref="#/components/schemas/UserDetail"),
 *     @OA\Property(property="modifyBy", ref="#/components/schemas/UserDetail"),
 *     @OA\Property(property="action", type="string", description="The type of action performed"),
 *     @OA\Property(property="time", type="string", format="date-time", description="The timestamp when the action was performed"),
 *     @OA\Property(property="colName", type="string", description="The column name that was modified, applicable for 'Modify' actions"),
 *     @OA\Property(property="newValue", type="string", description="The new value for the modified column, applicable for 'Modify' actions"),
 *     @OA\Property(property="oldValue", type="string", description="The old value for the modified column, applicable for 'Modify' actions")
 * )
 */
class UserHistory extends Model{

    public $timestamps = false;
    protected $table = 'user_history';
    protected $fillable = [
        'user_id',
        'affected_user_id',
        'action',
        'modified_column',
        'old_value',
        'new_value',
        'created_at'
    ];


    public function user() {
        return $this->belongsTo(User::class, 'user_id');
    }
    public function affectedUser() {
        return $this->belongsTo(User::class, 'affected_user_id');
    }
}
