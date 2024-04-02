<?php

namespace App\Http\Controllers;

use App\Models\Resource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;


class ResController extends Controller
{
    /**
     * @OA\Post(
     *     path="/resource",
     *     operationId="storeResource",
     *     tags={"Resources"},
     *     summary="Create a new resource",
     *     description="Stores a new resource and returns its details.",
     *     @OA\RequestBody(
     *         required=true,
     *         description="Data for creating a new resource",
     *         @OA\JsonContent(
     *             required={"label","description","content","id_category"},
     *             @OA\Property(property="label", type="string", maxLength=255, example="Resource Title"),
     *             @OA\Property(property="description", type="string", example="Detailed description of the resource."),
     *             @OA\Property(property="content", type="string", example="Content of the resource."),
     *             @OA\Property(property="id_category", type="integer", example=1)
     *         )
     *     ),
     *     @OA\Response(
     *         response=201,
     *         description="Resource created successfully",
     *         @OA\JsonContent(
     *             ref="#/components/schemas/Resource"
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Invalid input"
     *     )
     * )
     */
    public function store(Request $request)
    {

        $validatedData = Validator::make($request->all(), [
            'label' => 'required|string|max:255',
            'description' => 'required|string',
            'content' => 'required|string',
            // 'id_category' => 'required|integer',
            'id_category' => 'nullable|integer',
            'is_public' => 'nullable|boolean', 
            'file' => 'nullable|file',
            'view_count' => 'nullable|integer',
            'id_user' => 'nullable|integer',
            'id_status' => 'nullable|integer'
        ]);
        
        if ($validatedData->fails()) {
            return response()->json(['message' => 'Champ(s) incorects', 'errors' => $validatedData->errors()], 422);
        }
    
        if ($request->hasFile('files')) {
            $file = $request->file('files');
            // Stockez le fichier et obtenez le chemin
            $path = $file->store('public/files');
            // Ajoutez le chemin à vos données validées
            $validatedData['file'] = $path;
        }
        
        $resource = Resource::create($validatedData->valid());

    return response()->json(['message' => 'Ressource créée avec succès', 'resource' => $resource], 201);

    }


}
