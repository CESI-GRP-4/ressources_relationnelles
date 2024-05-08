<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @OA\Schema(
 *     schema="Country",
 *     type="object",
 *     @OA\Property(
 *         property="id",
 *         type="integer",
 *         description="Unique identifier for the country"
 *     ),
 *     @OA\Property(
 *         property="name",
 *         type="string",
 *         description="Name of the country"
 *     ),
 *     @OA\Property(
 *         property="code",
 *         type="string",
 *         description="Country code"
 *     )
 * )
 */
class Country extends Model {
    protected $table = 'countries';
    protected $primaryKey = 'id_country';
    public $timestamps = false;

    protected $fillable = ['name', 'country_code'];

    /**
     * Recherche l'ID d'un pays par son nom.
     *
     * @param string $name Le nom du pays.
     * @return int|null L'ID du pays s'il est trouvé, sinon null.
     */
    public function getIdByName(string $name): ?int
    {
        $country = self::where('name', $name)->first();
        return $country ? $country->id_country : null;
    }
}
