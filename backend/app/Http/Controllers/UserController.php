<?php

namespace App\Http\Controllers;

use App\Traits\FieldMappingTrait;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    use FieldMappingTrait;

    /**
     * Récupère une liste paginée des utilisateurs.
     *
     * @param Request $request
     * @return JsonResponse
     */
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
     *             @OA\Property(property="users", type="array", @OA\Items(ref="#/components/schemas/User")),
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
             $searchColumn = $fieldMapping[$request->searchColumn] ?? $request->searchColumn;
             $searchValue = $request->searchValue;
             $query->where($searchColumn, 'like', "%{$searchValue}%");
         }

         // Sorts
         $sortBy = $request->input('sortBy');
         $sortDirection = $request->input('sortDirection', 'asc');

         if (!empty($sortBy)) {
             $mappedSortBy = $fieldMapping[$sortBy] ?? $sortBy;
             if (in_array($mappedSortBy, ['first_name', 'last_name', 'email', 'id_user', 'is_verified', 'path_picture', 'created_at', 'updated_at'])) {
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

        $usersTransformed = $usersPaginated->getCollection()->map(function ($user) {
            return [
                'id' => $user->id_user,
                'email' => $user->email,
                'firstName' => $user->first_name,
                'lastName' => $user->last_name,
                'role' => $user->role->name ?? null,
                'isEmailVerified' => $user->is_verified,
                'imgURL' => $user->path_picture,
                'country' => $user->country->name ?? null,
                'countryCode' => $user->country->country_code ?? null,
                'city' => $user->city->name ?? null,
                'postalCode' => $user->postalCode->postal_code ?? null,
                'createdAt' => $user->created_at,
                'updatedAt' => $user->updated_at,
            ];
        });

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
}
