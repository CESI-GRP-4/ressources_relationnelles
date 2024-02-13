<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    /**
     * Récupère une liste paginée des utilisateurs.
     *
     * @param Request $request
     * @return JsonResponse
     */
    public function getUsers(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'perPage' => 'integer|min:1',
            'page' => 'integer|min:1',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        $perPage = $request->input('perPage', 15);
        $page = $request->input('page', 1);

        $usersPaginated = User::with(['role', 'city', 'country', 'postalCode'])->paginate($perPage, ['*'], 'page', $page);

        $usersTransformed = $usersPaginated->getCollection()->map(function ($user) {
            return [
                    'id' => $user->id_user,
                    'email' => $user->email,
                    'firstName' => $user->first_name,
                    'lastName' => $user->last_name,
                    'role' => $user->role->name,
                    'isEmailVerified' => $user->is_verified,
                    'imgURL' => $user->path_picture ?? null,
                    'country' => $user->country->name ?? null,
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
