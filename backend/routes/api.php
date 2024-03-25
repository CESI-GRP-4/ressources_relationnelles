<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CountryController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\Statistics\ConnectionController;
use App\Http\Controllers\UserHistoryController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

Route::post('login', [AuthController::class, 'login']);
Route::post('signup', [AuthController::class, 'signup']);
Route::post('email/verify', [AuthController::class, 'verifyEmail'])->name('verify.email');
Route::post('forgot-password/send-mail', [AuthController::class, 'forgotPassword'])->name('password.forgot');
Route::post('forgot-password/reset', [AuthController::class, 'resetPassword']);
Route::get('countries', [CountryController::class, 'getCountries']);

// Route::group(['middleware' => ['jwt.auth','jwt.refresh']], function() { // for refresh token. Commented for now as we got errors

Route::group(['middleware' => ['jwt.auth']], function () {
       Route::post('logout', [AuthController::class, 'logout']);
       Route::post('verifyUser', [AuthController::class, 'verifyUser']);

       Route::group(['middleware' => 'isSuperAdmin'], function () {
              Route::post('createUser', [UserController::class, 'createUser']);
       });

       Route::group(['middleware' => 'isAdmin'], function () {
              Route::get('users', [UserController::class, 'getUsers']);
              Route::get('usershistory', [UserHistoryController::class, 'getUsersHistory']);

              Route::post('editUser/{id}', [UserController::class, 'editUser']);
              Route::delete('deleteUser/{id}', [UserController::class, 'deleteUser']);
              Route::post('banUser/{id}', [UserController::class, 'banUser']);
              Route::patch('unbanUser/{id}', [UserController::class, 'unbanUser']);

              Route::group(['prefix' => 'stats'], function () {
                     Route::get('connections', [ConnectionController::class, 'getConnections']);
              });
       });

       Route::group(['middleware' => 'isModerator'], function () {
              // Routes for moderators (admins & superadmins can also access these routes)
       });
});
