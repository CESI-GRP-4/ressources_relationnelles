<?php

use App\Http\Controllers\AuthController;
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



Route::group(['middleware' => ['jwt.auth']], function() {
    Route::post('logout', [AuthController::class, 'logout']);
    Route::post('verifyUser', [AuthController::class, 'verifyUser']);
});
