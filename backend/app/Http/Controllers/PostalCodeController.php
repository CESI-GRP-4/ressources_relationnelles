<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\PostalCode;

class PostalCodeController extends Controller
{
    /**
     * Retourne la liste de tous les codes postaux.
     *
     * @return \Illuminate\Http\Response
     */
    public function getAllPostalCodes()
    {
        $postalCodes = PostalCode::all();
        return response()->json($postalCodes);
    }
}
