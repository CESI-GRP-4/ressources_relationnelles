<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\CountryController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\Statistics\ConnectionController;
use App\Http\Controllers\UserHistoryController;
use App\Http\Controllers\CityController;
use App\Http\Controllers\PostalCodeController;
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

// Search Ressources and Categories
Route::post('search', [RessourceController::class, 'searchRessourcesAndCategories']);

// Categories
Route::get('categories', [CategoryController::class, 'getActiveCategories']);
Route::get('category/{id}', [CategoryController::class, 'getCategory']);

// Ressources
Route::get('ressource/{id}', [RessourceController::class, 'getRessource']);

// Cities
Route::get('cities', [CityController::class, 'getAllCities']);

// Postal Codes
Route::get('postalCodes', [PostalCodeController::class, 'getAllPostalCodes']);

// Connected access
Route::group(['middleware' => ['jwt.auth']], function () {
    Route::post('logout', [AuthController::class, 'logout']);
    Route::post('verifyUser', [AuthController::class, 'verifyUser']);

    // Profil
    Route::group(['prefix' => 'profil'], function () {
        Route::post('update', [UserController::class, 'editUser']);
        Route::post('updatePassword', [UserController::class, 'editUserPassword']);
    });


    // Comments
    Route::group(['prefix' => 'comment'], function () {
        Route::post('create', [CommentController::class, 'createComment']);
        Route::delete('delete/{id}', [CommentController::class, 'deleteComment']);
    });

    // Ressources
    Route::group(['prefix' => 'ressource'], function () {
        Route::post('create', [RessourceController::class, 'create']);
        Route::post('edit/{id}', [RessourceController::class, 'edit']);
        Route::delete('delete/{id}', [RessourceController::class, 'delete']);

        // Favorite
        Route::group(['prefix' => 'favorite'], function () {
            Route::get('get', [RessourceController::class, 'getFavotites']);
            Route::post('add', [RessourceController::class, 'addFavotite']);
            Route::post('remove', [RessourceController::class, 'removeFavorite']);
        });

        // Bookmark
        Route::group(['prefix' => 'bookmark'], function () {
            Route::get('get', [RessourceController::class, 'getBookmarks']);
            Route::post('add', [RessourceController::class, 'addBookmark']);
            Route::post('remove', [RessourceController::class, 'removeBookmark']);
        });
    });

    // myRessources
    Route::group(['prefix' => 'myRessources'], function () {
        Route::get('/', [RessourceController::class, 'getMyRessources']);
        Route::get('stats', [RessourceController::class, 'getMyRessourcesStats']);
    });



    // Moderator +
    Route::group(['middleware' => 'isModerator'], function () {

        // Comments
        Route::group(['prefix' => 'comment'], function () {
            Route::get('pending', [CommentController::class, 'pending']);
            Route::get('accepted', [CommentController::class, 'accepted']);
            Route::get('rejected', [CommentController::class, 'rejected']);

            Route::patch('accept/{id}', [CommentController::class, 'accept']);
            Route::patch('reject/{id}', [CommentController::class, 'reject']);
        });

        // Resources
        Route::group(['prefix' => 'ressources'], function () {
            Route::get('pending', [RessourceController::class, 'pending']);
            Route::get('accepted', [RessourceController::class, 'accepted']);
            Route::get('rejected', [RessourceController::class, 'rejected']);
            Route::get('blocked', [RessourceController::class, 'blocked']);

            Route::patch('accept/{id}', [RessourceController::class, 'accept']);
            Route::post('reject/{id}', [RessourceController::class, 'reject']);
            Route::post('block/{id}', [RessourceController::class, 'block']);
        });

        // Statistics
        Route::group(['prefix' => 'stats'], function () {
            Route::get('connections', [ConnectionController::class, 'getConnections']);
            Route::get('categories', [CategoryController::class, 'getCategoriesStatsCount']);
            Route::get('ressources', [RessourceController::class, 'getRessourcesStats']);
            Route::get('ressources/count', [RessourceController::class, 'getRessourcesStatsCount']);
            Route::get('comments', [CommentController::class, 'getCommentsStats']);

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
            Route::get('users', [UserController::class, 'getUsersInformation']);
        });
    });



    // SuperAdmin +
    Route::group(['middleware' => 'isSuperAdmin'], function () {
        Route::post('user/create', [UserController::class, 'create']);
    });

});
