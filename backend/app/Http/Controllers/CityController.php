<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\City;

class CityController extends Controller
{
    /**
     * Retourne la liste de toutes les villes.
     *
     * @return \Illuminate\Http\Response
     */
    public function getAllCities()
    {
        $cities = City::all();
        return response()->json($cities);
    }
}
