<?php

namespace App\Http\Controllers;

use App\Models\Ressource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;


class RessourceController extends Controller {
    const ID_ACCEPTED_STATUS = 1;
    const ID_PENDING_STATUS = 2;
    const ID_REJECTED_STATUS = 3;

    /**
     * @OA\Post(
     *     path="/createRessource",
     *     tags={"Ressource"},
     *     summary="Create a new ressource",
     *     description="Creates a new resource with the given details. Returns the ID of the newly created resource.",
     *     operationId="createRessource",
     *     @OA\RequestBody(
     *         required=true,
     *         description="Data for the new resource",
     *         @OA\JsonContent(
     *             required={"label", "description", "idCategory"},
     *             @OA\Property(property="label", type="string", description="The label of the new resource"),
     *             @OA\Property(property="description", type="string", description="The description of the new resource"),
     *             @OA\Property(property="idCategory", type="integer", description="The category ID for the new resource"),
     *             @OA\Property(property="isPublic", type="boolean", description="Whether the resource is public", example=true),
     *         )
     *     ),
     *     @OA\Response(
     *         response=201,
     *         description="Resource created successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource créée avec succès"),
     *             @OA\Property(property="idRessource", type="integer", description="The ID of the newly created resource")
     *         )
     *     ),
     *     @OA\Response(
     *         response=422,
     *         description="Validation error",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", description="Validation message"),
     *             @OA\Property(
     *                 property="errors",
     *                 type="object",
     *                 additionalProperties={
     *                     @OA\Property(type="array", @OA\Items(type="string"))
     *                 },
     *                 description="Detailed validation errors"
     *             )
     *         )
     *     )
     * )
     */
    public function createRessource(Request $request) {
        if ($request->has('isPublic')) {
            $request->isPublic = filter_var($request->isPublic, FILTER_VALIDATE_BOOLEAN);
        }

        $validatedData = Validator::make($request->all(), [
            'label' => 'required|unique:ressources|string|max:255',
            'description' => 'required|string',
            'idCategory' => 'required|integer',
            'isPublic' => 'sometimes|boolean',
        ]);

        if ($validatedData->fails()) {
            return response()->json(['message' => 'Champ(s) incorects', 'errors' => $validatedData->errors()], 422);
        }

        $ressource = Ressource::create([
            'label' => $request->label,
            'description' => $request->description,
            'id_category' => $request->idCategory,
            'is_public' => $request->isPublic,
            'id_user' => auth()->user()->id_user,
            'id_status' => self::ID_PENDING_STATUS,
            'id_type' => 1,
        ]);

        return response()->json(['message' => 'Ressource créée avec succès', 'idRessource' => $ressource->id_ressource], 201);
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

    /**
     * @OA\Patch(
     *     path="/acceptRessource/{id}",
     *     tags={"Ressource"},
     *     summary="Accept a resource",
     *     description="Marks a pending resource as accepted. This endpoint is restricted to moderators.",
     *     operationId="acceptRessource",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID of the resource to accept",
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Resource accepted successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource acceptée")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Resource already processed",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource déjà traitée")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Resource not found",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource non trouvée")
     *         )
     *     ),
     *     @OA\Response(
     *         response=403,
     *         description="Forbidden - Moderator access required",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Access restricted to moderators")
     *         )
     *     )
     * )
     */
    public function acceptRessource($id) {
        $ressource = Ressource::find($id);

        if (!$ressource) {
            return response()->json(['message' => 'Ressource non trouvée'], 404);
        }

        if ($ressource->id_status != self::ID_PENDING_STATUS) {
            return response()->json(['message' => 'Ressource déjà traitée'], 400);
        }

        $ressource->id_status = self::ID_ACCEPTED_STATUS;
        $ressource->save();

        return response()->json(['message' => 'Ressource acceptée'], 200);
    }

    /**
     * @OA\Patch(
     *     path="/rejectRessource/{id}",
     *     tags={"Ressource"},
     *     summary="Reject a resource",
     *     description="Marks a pending resource as rejected. This endpoint is restricted to moderators.",
     *     operationId="rejectRessource",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID of the resource to reject",
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Resource rejected successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource refusée")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Resource already processed",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource déjà traitée")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Resource not found",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource non trouvée")
     *         )
     *     ),
     *     @OA\Response(
     *         response=403,
     *         description="Forbidden - Moderator access required",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Access restricted to moderators")
     *         )
     *     )
     * )
     */
    public function rejectRessource($id) {
        $ressource = Ressource::find($id);

        if (!$ressource) {
            return response()->json(['message' => 'Ressource non trouvée'], 404);
        }

        if ($ressource->id_status != self::ID_PENDING_STATUS) {
            return response()->json(['message' => 'Ressource déjà traitée'], 400);
        }

        $ressource->id_status = self::ID_REJECTED_STATUS;
        $ressource->save();

        return response()->json(['message' => 'Ressource refusée'], 200);
    }

}
