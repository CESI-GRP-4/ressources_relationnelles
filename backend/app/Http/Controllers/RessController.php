<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class RessController extends Controller
{

   /**
     * @OA\Post(
     *     path="/create-resource",
     *     tags={"Resource"},
     *     summary="Create a new resource",
     *     operationId="createResource",
     *     @OA\RequestBody(
     *         required=true,
     *         description="Data required for creating a resource",
     *         @OA\JsonContent(
     *             required={"label", "description", "content", "id_category"},
     *             @OA\Property(property="label", type="string", example="Resource Title"),
     *             @OA\Property(property="description", type="string", example="Resource description"),
     *             @OA\Property(property="content", type="string", example="Resource content"),
     *             @OA\Property(property="id_category", type="integer", example=1)
     *         ),
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Resource created successfully",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Resource created successfully!"),
     *             @OA\Property(property="resource", type="object")
     *         )
     *     ),
     *     @OA\Response(
     *         response=403,
     *         description="Validation error or other errors",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Error message")
     *         )
     *     )
     * )
     */
    public function createRessource(Request $request)
    {
        // Validation des données reçues de la requête
        $validatedData = $request->validate([
            'label' => 'required|string|max:255',
            'description' => 'required|string',
            'content' => 'required|string',
            'id_category' => 'required|integer'
        ]);

        // Création de la ressource en utilisant le modèle Resource
        $resource = new Ressource();
        $resource->label = $validatedData['label'];
        $resource->description = $validatedData['description'];
        $resource->content = $validatedData['content'];
        $resource->id_category = $validatedData['id_category'];

        // Sauvegarde de la ressource dans la base de données
        $resource->save();

        // Retourne une réponse indiquant le succès de l'opération
        return response()->json([
            'message' => 'Resource created successfully!',
            'resource' => $resource
        ], 201); // Le code HTTP 201 indique qu'une ressource a été créée avec succès.
    }


}
