<?php

namespace App\Http\Controllers;

use App\Models\Ressource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;


class RessourceController extends Controller
{
    /**
     * @OA\Post(
     *     path="/creer-ressource",
     *     tags={"Ressources"},
     *     summary="Create a new ressource",
     *     description="Creates a new ressource with the given data. File upload is supported.",
     *     operationId="createRessource",
     *     security={{ "BearerAuth": {} }},
     *     @OA\RequestBody(
     *         required=true,
     *         description="Ressource data and optional file upload",
     *         @OA\MediaType(
     *             mediaType="multipart/form-data",
     *             @OA\Schema(
     *                 type="object",
     *                 required={"label", "description", "content"},
     *                 @OA\Property(
     *                     property="label",
     *                     type="string",
     *                     description="The label of the ressource",
     *                     example="A New Ressource"
     *                 ),
     *                 @OA\Property(
     *                     property="description",
     *                     type="string",
     *                     description="Detailed description of the ressource",
     *                     example="This is a detailed description of the ressource."
     *                 ),
     *                 @OA\Property(
     *                     property="content",
     *                     type="string",
     *                     description="The content of the ressource",
     *                     example="Here goes the content of the ressource."
     *                 ),
     *                 @OA\Property(
     *                     property="id_category",
     *                     type="integer",
     *                     description="The ID of the category this ressource belongs to",
     *                 ),
     *                 @OA\Property(
     *                     property="is_public",
     *                     type="boolean",
     *                     description="Whether the ressource is public or not",
     *                 ),
     *                 @OA\Property(
     *                     property="file",
     *                     type="string",
     *                     format="binary",
     *                     description="Optional file to upload"
     *                 ),
     *                 @OA\Property(
     *                     property="view_count",
     *                     type="integer",
     *                     description="Optional initial view count",
     *                 ),
     *                 @OA\Property(
     *                     property="id_user",
     *                     type="integer",
     *                     description="Optional ID of the user creating the ressource",
     *                 ),
     *                 @OA\Property(
     *                     property="id_status",
     *                     type="integer",
     *                     description="Optional status ID of the ressource",
     *                 )
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=201,
     *         description="Ressource created successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource créée avec succès")
     *         )
     *     ),
     *     @OA\Response(
     *         response=422,
     *         description="Validation Error",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Champ(s) incorrects"),
     *             @OA\Property(property="errors", type="object")
     *         )
     *     )
     * )
     */
    public function createRessource(Request $request)
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

        $ressource = Ressource::create($validatedData->valid());

    return response()->json(['message' => 'Ressource créée avec succès', 'ressource' => $ressource], 201);

    }


    public function getRessource($id) {
        $ressource = Ressource::find($id);

        if (!$ressource) {
            return response()->json(['message' => 'Ressource non trouvée'], 404);
        }

        // Add one to the view count
        $ressource->view_count += 1;
        $ressource->save();

        // TODO : Faire le format
        return response()->json(['ressource' => $ressource], 200);
    }

}
