<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\City;

class CityController extends Controller
{
    /**
     * @OA\Get(
     *     path="/cities",
     *     tags={"City"},
     *     summary="Retrieve all cities",
     *     description="Fetches a list of all cities available in the database.",
     *     operationId="getAllCities",
     *     @OA\Response(
     *         response=200,
     *         description="A list of cities",
     *         @OA\JsonContent(
     *             type="array",
     *             @OA\Items(
     *                 type="object",
     *                 @OA\Property(property="id_city", type="integer", description="The unique identifier of the city"),
     *                 @OA\Property(property="name", type="string", description="The name of the city")
     *             )
     *         )
     *     )
     * )
     */
    public function getAllCities()
    {
        $cities = City::all();
        return response()->json($cities);
    }
}
