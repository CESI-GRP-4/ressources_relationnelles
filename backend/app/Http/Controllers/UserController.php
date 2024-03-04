<?php

namespace App\Http\Controllers;

use App\Models\City;
use App\Models\Country;
use App\Models\PostalCode;
use App\Models\Role;
use App\Traits\FieldMappingTrait;
use App\Utils\Utils;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    use FieldMappingTrait;

    /**
     * @OA\Get(
     *     path="/users",
     *     tags={"Users"},
     *     summary="Get a list of users with optional search, sort, and pagination",
     *     security={{ "BearerAuth": {} }},
     *     operationId="getUsers",
     *     @OA\Parameter(
     *         name="search",
     *         in="query",
     *         description="Search term to apply on firstName, lastName, and email",
     *         required=false,
     *         @OA\Schema(type="string")
     *     ),
     *     @OA\Parameter(
     *         name="searchColumn",
     *         in="query",
     *         description="Column to specifically search in (firstName, lastName, email, etc.)",
     *         required=false,
     *         @OA\Schema(type="string")
     *     ),
     *     @OA\Parameter(
     *         name="searchValue",
     *         in="query",
     *         description="Value to search for in the specified column",
     *         required=false,
     *         @OA\Schema(type="string")
     *     ),
     *     @OA\Parameter(
     *         name="sortBy",
     *         in="query",
     *         description="Column to sort the users by",
     *         required=false,
     *         @OA\Schema(type="string")
     *     ),
     *     @OA\Parameter(
     *         name="sortDirection",
     *         in="query",
     *         description="Direction to sort (asc or desc)",
     *         required=false,
     *         @OA\Schema(type="string", enum={"asc", "desc"})
     *     ),
     *     @OA\Parameter(
     *         name="perPage",
     *         in="query",
     *         description="Number of users per page",
     *         required=false,
     *         @OA\Schema(type="integer")
     *     ),
     *     @OA\Parameter(
     *         name="page",
     *         in="query",
     *         description="Page number to retrieve",
     *         required=false,
     *         @OA\Schema(type="integer")
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Successful operation",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="users", type="array", @OA\Items(ref="#/components/schemas/UserDetail")),
     *             @OA\Property(property="totalUsers", type="integer"),
     *             @OA\Property(property="perPage", type="integer"),
     *             @OA\Property(property="currentPage", type="integer"),
     *             @OA\Property(property="lastPage", type="integer")
     *         )
     *     ),
     *     @OA\Response(
     *         response=403,
     *         description="Forbidden - Admin or Super Admin role required"
     *     )
     * )
     */
     public function getUsers(Request $request){

         $validator = Validator::make($request->all(), [
             'perPage' => 'integer|min:1',
             'page' => 'integer|min:1',
             'search' => 'string|nullable',
             'searchColumn' => 'string|nullable',
             'searchValue' => 'string|nullable',
             'sortBy' => 'string|nullable',
             'sortDirection' => 'in:asc,desc|nullable'
         ]);

         if ($validator->fails()) { return response()->json($validator->errors(), 400); }

         $query = User::query();
         $fieldMapping = $this->getFieldMapping();

         // Filters
         // Search on multiple columns
         if ($request->filled('search')) {
             $search = $request->search;
             $query->where(function ($q) use ($search, $fieldMapping) {
                 $q->where($fieldMapping['firstName'] ?? 'first_name', 'like', "%{$search}%")
                     ->orWhere($fieldMapping['lastName'] ?? 'last_name', 'like', "%{$search}%")
                     ->orWhere($fieldMapping['email'] ?? 'email', 'like', "%{$search}%");
             });
         }

         // Search on a specific column
         if ($request->filled('searchColumn') && $request->filled('searchValue')) {
             $searchColumn = $request->searchColumn; // Pas besoin de mappage ici, sauf si vos champs front-end ont des noms différents
             $searchValue = $request->searchValue;

             switch ($searchColumn) {
                 case 'role':
                     $query->whereHas('role', function ($q) use ($searchValue) {
                         $q->where('name', 'like', "%{$searchValue}%");
                     });
                     break;

                 case 'country':
                     $query->whereHas('country', function ($q) use ($searchValue) {
                         $q->where('name', 'like', "%{$searchValue}%");
                     });
                     break;

                 case 'countryCode':
                     $query->whereHas('country', function ($q) use ($searchValue) {
                         $q->where('country_code', 'like', "%{$searchValue}%");
                     });
                     break;

                 case 'city':
                     $query->whereHas('city', function ($q) use ($searchValue) {
                         $q->where('name', 'like', "%{$searchValue}%");
                     });
                     break;

                 case 'postalCode':
                     $query->whereHas('postalCode', function ($q) use ($searchValue) {
                         $q->where('postal_code', 'like', "%{$searchValue}%");
                     });
                     break;

                 default:
                     if (array_key_exists($searchColumn, $fieldMapping)) {
                         $dbColumn = $fieldMapping[$searchColumn];
                         $query->where($dbColumn, 'like', "%{$searchValue}%");
                     }
                     break;
             }
         }

         // Sorts
         $sortBy = $request->input('sortBy');
         $sortDirection = $request->input('sortDirection', 'asc');

         if (!empty($sortBy)) {
             $mappedSortBy = $fieldMapping[$sortBy] ?? $sortBy;
             if (in_array($mappedSortBy, ['first_name', 'last_name', 'email', 'id_user', 'is_verified', 'is_banned', 'path_picture', 'created_at', 'updated_at'])) {
                 $query->orderBy($mappedSortBy, $sortDirection);
             } else {
                 switch ($sortBy) {

                     case 'role':
                         $query->select('users.*')
                             ->join('roles', 'users.id_role', '=', 'roles.id_role')
                             ->orderBy('roles.name', $sortDirection);
                         break;

                     case 'country':
                         $query->select('users.*')
                             ->join('countries', 'users.id_country', '=', 'countries.id_country')
                             ->orderBy('countries.name', $sortDirection);
                         break;

                     case 'countryCode':
                         $query->select('users.*')
                             ->join('countries', 'users.id_country', '=', 'countries.id_country')
                             ->orderBy('countries.country_code', $sortDirection);
                         break;

                     case 'city':
                         $query->select('users.*')
                             ->join('cities', 'users.id_city', '=', 'cities.id_city')
                             ->orderBy('cities.name', $sortDirection);
                         break;

                     case 'postalCode':
                         $query->select('users.*')
                             ->join('postal_codes', 'users.id_postal_code', '=', 'postal_codes.id_postal_code')
                             ->orderBy('postal_codes.postal_code', $sortDirection);
                         break;

                 }
            }
        }

        // Pagination
        $perPage = $request->input('perPage', 10);
        $usersPaginated = $query->paginate($perPage);

        $usersTransformed = $usersPaginated->getCollection()->map([Utils::class, 'getAllUserData']);
        $usersPaginated->setCollection($usersTransformed);

        $response = [
            'users' => $usersPaginated->items(),
            'totalUsers' => $usersPaginated->total(),
            'perPage' => $usersPaginated->perPage(),
            'currentPage' => $usersPaginated->currentPage(),
            'lastPage' => $usersPaginated->lastPage(),
        ];

        return response()->json($response);
    }


    /**
     * @OA\Post(
     *     path="/editUser/{id}",
     *     tags={"Users"},
     *     summary="Edit a user's details",
     *     description="Allows editing user details. Note: Only Super Administrators can change the user's role.",
     *     operationId="editUser",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="User ID",
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\RequestBody(
     *         description="User data to update",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="firstName", type="string", example="John"),
     *             @OA\Property(property="lastName", type="string", example="Doe"),
     *             @OA\Property(property="email", type="string", format="email", example="john.doe@example.com"),
     *             @OA\Property(property="isEmailVerified", type="boolean", example=true),
     *             @OA\Property(property="country", type="string", example="Japan"),
     *             @OA\Property(property="city", type="string", example="Paris"),
     *             @OA\Property(property="postalCode", type="string", example="75000"),
     *             @OA\Property(property="role", type="string", example="User", description="Role of the user. Can only be changed by Super Administrators.")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="User updated successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Utilisateur mis à jour avec succés"),
     *             @OA\Property(
     *                 property="user",
     *                 type="object",
     *                 @OA\Property(property="id", type="integer", example=30),
     *                 @OA\Property(property="email", type="string", format="email", example="john.doe@example.com"),
     *                 @OA\Property(property="firstName", type="string", example="John"),
     *                 @OA\Property(property="lastName", type="string", example="Doe"),
     *                 @OA\Property(property="isEmailVerified", type="boolean", example=true),
     *                 @OA\Property(property="imgURL", type="string", example="/path/to/picture/user_9.jpg"),
     *                 @OA\Property(property="city", type="string", example="Paris"),
     *                 @OA\Property(property="country", type="string", example="Japan"),
     *                 @OA\Property(property="countryCode", type="string", example="JP"),
     *                 @OA\Property(property="postalCode", type="string", example="75000"),
     *                 @OA\Property(property="role", type="string", example="User"),
     *                 @OA\Property(property="createdAt", type="string", format="date-time", example="2024-02-13T19:05:16.000000Z"),
     *                 @OA\Property(property="updatedAt", type="string", format="date-time", example="2024-02-20T19:45:22.000000Z"),
     *                 @OA\Property(property="newUser", type="boolean", example=false)
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Validation error"
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="User not found"
     *     )
     * )
     */
    public function editUser(Request $request, $id){

        $user = User::findOrFail($id);

        $isSuperAdmin = auth()->user()->role->name === 'SuperAdministrateur';

        $rules = [
            'firstName' => 'string|nullable',
            'lastName' => 'string|nullable',
            'email' => 'string|email|nullable',
            'isEmailVerified' => 'boolean|nullable',
            'country' => 'string|nullable',
            'city' => 'string|nullable',
            'postalCode' => 'string|nullable',
        ];

        if ($isSuperAdmin) {
            $rules['role'] = 'string|nullable';
        }

        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }


        // Mise à jour des champs directs
        $fieldMapping = $this->getFieldMapping(); // Utilisez votre trait pour obtenir les mappages
        foreach ($validator->validated() as $key => $value) {
            if (in_array($key, ['firstName', 'lastName', 'email', 'isEmailVerified']) && $value !== null) {
                $dbKey = $fieldMapping[$key] ?? $key;
                $user->$dbKey = $value;
            }
        }

        if ($request->filled('country')) {
            $country = Country::where('name', $request->country)->firstOrFail();
            $user->id_country = $country->id_country;
        }

        if ($request->filled('city')) {
            $city = City::firstOrCreate(['name' => $request->city]);
            $user->id_city = $city->id_city;
        }
        if ($request->filled('postalCode')) {
            $postalCode = PostalCode::firstOrCreate(['postal_code' => $request->postalCode]);
            $user->id_postal_code = $postalCode->id_postal_code;
        }
        if ($isSuperAdmin && $request->filled('role')) {
            $role = Role::where('name', $request->role)->firstOrFail();
            $user->id_role = $role->id_role;
        }

        $user->save();

        return response()->json(['message' => 'Utilisateur mis à jour avec succés', 'user' => Utils::getAllUserData($user)], 200);
    }

    /**
     * @OA\Delete(
     *     path="/deleteUser/{id}",
     *     tags={"Users"},
     *     summary="Delete a user",
     *     description="Deletes a user. This action is restricted to Super Administrators only.",
     *     operationId="deleteUser",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID of the user to delete",
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="User deleted successfully",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Utilisateur supprimé avec succés.")
     *         )
     *     ),
     *     @OA\Response(
     *         response=403,
     *         description="Unauthorized: Only a Super Administrator can delete a user.",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Non autorisé : Seul un super administrateur peut supprimer un utilisateur.")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="User not found.",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Utilisateur non trouvé.")
     *         )
     *     )
     * )
     */
    public function deleteUser($id){
        if (auth()->user()->role->name != 'SuperAdministrateur') {
            return response()->json(['message' => 'Unauthorized: Seul un superAdministrateur peut supprimer un utilisateur.'], 403);
        }

        $user = User::find($id);
        if (!$user) {
            return response()->json(['message' => 'Utilisateur non trouvé.'], 404);
        }
        $user->delete();
        return response()->json(['message' => 'Utilisateur supprimé avec succés.']);
    }

    /**
     * @OA\Patch(
     *     path="/banUser/{id}",
     *     tags={"Users"},
     *     summary="Ban a user",
     *     description="Ban a user . Administrators and Super Administrators cannot be ban.",
     *     operationId="banUser",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="The ID of the user to ban",
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="User has been banned.",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="L'utilisateur a été banni.")
     *         )
     *     ),
     *     @OA\Response(
     *         response=403,
     *         description="Unauthorized",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Non autorisé")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="User not found",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Utilisateur non trouvé")
     *         )
     *     )
     * )
     */
    public function banUser($id) {

        $user = User::find($id);

        if($user->role->name == 'SuperAdministrateur' || $user->role->name == 'Administrateur') {
            return response()->json(['message' => 'Non autorisé'], 403);
        }

        if (!$user) {
            return response()->json(['message' => 'Utilisateur non trouvé'], 404);
        }

        $user->is_banned = true;
        $user->save();

        return response()->json(['message' => 'L\'utilisateur a été banni.']);
    }

    /**
     * @OA\Patch(
     *     path="/unbanUser/{id}",
     *     tags={"Users"},
     *     summary="Unban a user",
     *     description="Unban a previously unban user.",
     *     operationId="unbanUser",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="The ID of the user to unban",
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="User has been unban.",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="L'utilisateur a été débanni")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="User not found or not banned",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Utilisateur non trouvé ou pas banni")
     *         )
     *     )
     * )
     */
    public function unbanUser($id) {
        $user = User::find($id);
        if (!$user) {
            return response()->json(['message' => 'Utilisateur non trouvé'], 404);
        }


        if (!$user->is_banned) {
            return response()->json(['message' => 'L\'utilisateur n\'est pas banni'], 404);
        }

        $user->is_banned = false;
        $user->save();

        return response()->json(['message' => 'L\'utilisateur a été débanni']);
    }
}
