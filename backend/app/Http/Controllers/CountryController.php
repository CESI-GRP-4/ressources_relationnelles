<?php

namespace App\Http\Controllers;

use App\Models\Country;

class CountryController extends Controller {

    /**
     * @OA\Get(
     *     path="/countries",
     *     operationId="getCountries",
     *     tags={"Countries"},
     *     summary="Get list of countries",
     *     description="Returns a list of countries with their ID, name, and code.",
     *     @OA\Response(
     *         response=200,
     *         description="Successful operation",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="countries",
     *                 type="array",
     *                 @OA\Items(ref="#/components/schemas/Country")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Bad Request"
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Not Found"
     *     )
     * )
     */
    public function getCountries() {
        $countries = Country::all(['id_country AS id', 'name', 'country_code AS code']);

        return response()->json(['countries' => $countries]);
    }
}
