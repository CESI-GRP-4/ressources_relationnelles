<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PostalCode extends Model {
    protected $table = 'postal_codes';
    protected $primaryKey = 'id_postal_code';
    public $timestamps = false;

    protected $fillable = ['postal_code'];


    /**
     * Recherche l'ID d'un code postal par sa valeur.
     *
     * @param string $postalCode La valeur du code postal.
     * @return int|null L'ID du code postal s'il est trouvé, sinon null.
     */
    public function getIdByName(string $postalCode): ?int
    {
        $postalCodeEntry = self::where('postal_code', $postalCode)->first();
        return $postalCodeEntry ? $postalCodeEntry->id_postal_code : null;
    }
}
