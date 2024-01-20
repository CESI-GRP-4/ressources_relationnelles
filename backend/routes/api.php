<?php

use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/
Route::get('/aze', function (Request $request) {
    return response()->json(['message' => "Bienvenue!"],200);
});

Route::post('login', [AuthController::class, 'login']);


Route::group(['middleware' => ['jwt.auth']], function() {
    Route::post('logout', [AuthController::class, 'logout']);

    Route::get('/user', function (Request $request) {
        return response()->json(['message' => "Validé!"],200);
    });
});
