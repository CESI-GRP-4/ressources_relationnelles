<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CountryController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\Statistics\ConnectionController;
use App\Http\Controllers\UserHistoryController;
use App\Http\Controllers\RessourceController;
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

// Categories
Route::get('categories', [CategoryController::class, 'getActiveCategories']);
Route::get('category/{id}', [CategoryController::class, 'getCategory']);

// Ressources
Route::get('ressource/{id}', [RessourceController::class, 'getRessource']);

// Connected access
Route::group(['middleware' => ['jwt.auth']], function () {
    Route::post('logout', [AuthController::class, 'logout']);
    Route::post('verifyUser', [AuthController::class, 'verifyUser']);
    Route::post('createRessource', [RessourceController::class, 'createRessource']);

    Route::get('myRessources', [RessourceController::class, 'getMyRessources']);
    Route::get('myRessources/stats', [RessourceController::class, 'getMyRessourcesStats']);



    // SuperAdmin routes
    Route::group(['middleware' => 'isSuperAdmin'], function () {
        Route::post('createUser', [UserController::class, 'createUser']);
    });

    // Admin & SuperAdmin routes
    Route::group(['middleware' => 'isAdmin'], function () {
        Route::get('users', [UserController::class, 'getUsers']);
        Route::get('usersHistory', [UserHistoryController::class, 'getUsersHistory']);

        Route::post('editUser/{id}', [UserController::class, 'editUser']);
        Route::delete('deleteUser/{id}', [UserController::class, 'deleteUser']);
        Route::post('banUser/{id}', [UserController::class, 'banUser']);
        Route::patch('unbanUser/{id}', [UserController::class, 'unbanUser']);

        Route::get('allCategories', [CategoryController::class, 'getAllCategories']);
        Route::post('createCategory', [CategoryController::class, 'createCategory']);
        Route::post('editCategory/{id}', [CategoryController::class, 'editCategory']);
        Route::delete('deleteCategory/{id}', [CategoryController::class, 'deleteCategory']);


        Route::group(['prefix' => 'stats'], function () {
            Route::get('connections', [ConnectionController::class, 'getConnections']);
            Route::get('users', [UserController::class, 'getUsersInformation']);
            Route::get('ressources', [RessourceController::class, 'getRessourcesStats']);
        });
    });

    // Moderator, Admin & SuperAdmin routes
    Route::group(['middleware' => 'isModerator'], function () {
        // Routes for moderators (admins & superadmins can also access these routes)

        Route::group(['prefix' => 'ressources'], function () {
            Route::get('pending', [RessourceController::class, 'pending']);
            Route::patch('accept/{id}', [RessourceController::class, 'accept']);
            Route::patch('reject/{id}', [RessourceController::class, 'reject']);
            Route::patch('block/{id}', [RessourceController::class, 'block']);

            Route::get('accepted', [RessourceController::class, 'accepted']);
            Route::get('rejected', [RessourceController::class, 'rejected']);
            Route::get('blocked', [RessourceController::class, 'blocked']);
        });
    });
});
