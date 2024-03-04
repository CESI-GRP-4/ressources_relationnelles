<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CountryController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/
Route::post('login', [AuthController::class, 'login']);
Route::post('signup', [AuthController::class, 'signup']);

Route::post('login', [AuthController::class, 'login']);
Route::post('signup', [AuthController::class, 'signup']);
Route::post('email/verify', [AuthController::class, 'verifyEmail'])->name('verify.email');
Route::post('forgot-password/send-mail', [AuthController::class, 'forgotPassword'])->name('password.forgot');
Route::post('forgot-password/reset', [AuthController::class, 'resetPassword']);
Route::get('countries', [CountryController::class, 'getCountries']);

// Route::group(['middleware' => ['jwt.auth','jwt.refresh']], function() { // for refresh token. Commented for now as we got errors





Route::group(['middleware' => ['jwt.auth']], function() {
    Route::post('logout', [AuthController::class, 'logout']);
    Route::post('verifyUser', [AuthController::class, 'verifyUser']);

    Route::group(['middleware' => 'isAdmin'], function () {
        Route::get('users', [UserController::class, 'getUsers']);
        Route::post('editUser/{id}', [UserController::class, 'editUser']);
        Route::delete('deleteUser/{id}', [UserController::class, 'deleteUser']);
        Route::patch('banUser/{id}', [UserController::class, 'banUser']);
        Route::patch('unbanUser/{id}', [UserController::class, 'unbanUser']);
    });
});
