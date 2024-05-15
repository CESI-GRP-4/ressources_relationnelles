<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\PostalCode;

class PostalCodeController extends Controller
{

    /**
     * @OA\Get(
     *     path="/postalCode",
     *     tags={"Postal Code"},
     *     summary="Retrieve all postal codes",
     *     description="Fetches a list of all postal codes available in the database.",
     *     operationId="getAllPostalCodes",
     *     @OA\Response(
     *         response=200,
     *         description="A list of postal codes",
     *         @OA\JsonContent(
     *             type="array",
     *             @OA\Items(
     *                 type="object",
     *                 @OA\Property(property="id_postal_code", type="integer", description="The unique identifier of the postal code"),
     *                 @OA\Property(property="postal_code", type="string", description="The value of the postal code")
     *             )
     *         )
     *     )
     * )
     */
    public function getAllPostalCodes()
    {
        $postalCodes = PostalCode::all();
        return response()->json($postalCodes);
    }
}
