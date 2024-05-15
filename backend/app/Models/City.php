<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class City extends Model {
    protected $table = 'cities';
    protected $primaryKey = 'id_city';
    public $timestamps = false;

    protected $fillable = ['name'];

    /**
     * Recherche l'ID d'une ville par son nom.
     *
     * @param string $name Le nom de la ville.
     * @return int|null L'ID de la ville s'il est trouvé, sinon null.
     */
    public function getIdByName(string $name): ?int
    {
        $city = self::where('name', $name)->first();
        return $city ? $city->id_city : null;
    }
}
