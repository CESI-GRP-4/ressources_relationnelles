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

// Public access
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

    // Ressources
    Route::group(['prefix' => 'ressource'], function () {
        Route::post('create', [RessourceController::class, 'create']);
        Route::post('edit/{id}', [RessourceController::class, 'edit']);
        Route::delete('delete/{id}', [RessourceController::class, 'delete']);
    });

    // myRessources
    Route::group(['prefix' => 'myRessources'], function () {
        Route::get('/', [RessourceController::class, 'getMyRessources']);
        Route::get('stats', [RessourceController::class, 'getMyRessourcesStats']);
    });



    // Moderator +
    Route::group(['middleware' => 'isModerator'], function () {

        // Resources
        Route::group(['prefix' => 'ressources'], function () {
            Route::get('pending', [RessourceController::class, 'pending']);
            Route::patch('accept/{id}', [RessourceController::class, 'accept']);
            Route::post('reject/{id}', [RessourceController::class, 'reject']);
            Route::post('block/{id}', [RessourceController::class, 'block']);

            Route::get('accepted', [RessourceController::class, 'accepted']);
            Route::get('rejected', [RessourceController::class, 'rejected']);
            Route::get('blocked', [RessourceController::class, 'blocked']);
        });

        // Statistics
        Route::group(['prefix' => 'stats'], function () {
            Route::get('ressources', [RessourceController::class, 'getRessourcesStats']);
        });
    });



    // Admin +
    Route::group(['middleware' => 'isAdmin'], function () {

        // Users
        Route::group(['prefix' => 'users'], function () {
            Route::get('/', [UserController::class, 'getUsers']);
            Route::get('history', [UserHistoryController::class, 'getUsersHistory']);
        });

        // User
        Route::group(['prefix' => 'user'], function () {
            Route::post('edit/{id}', [UserController::class, 'editUser']);
            Route::post('ban/{id}', [UserController::class, 'banUser']);
            Route::patch('unban/{id}', [UserController::class, 'unbanUser']);
            Route::delete('delete/{id}', [UserController::class, 'deleteUser']);
        });

        // Categories
        Route::get('allCategories', [CategoryController::class, 'getAllCategories']);
        Route::group(['prefix' => 'category'], function () {
            Route::post('create', [CategoryController::class, 'createCategory']);
            Route::post('edit/{id}', [CategoryController::class, 'editCategory']);
            Route::delete('delete/{id}', [CategoryController::class, 'deleteCategory']);
        });

        // Statistics
        Route::group(['prefix' => 'stats'], function () {
            Route::get('connections', [ConnectionController::class, 'getConnections']);
            Route::get('users', [UserController::class, 'getUsersInformation']);
        });
    });



    // SuperAdmin +
    Route::group(['middleware' => 'isSuperAdmin'], function () {
        Route::post('user/create', [UserController::class, 'create']);
    });

});
