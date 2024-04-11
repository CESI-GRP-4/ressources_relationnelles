<?php

namespace App\Http\Controllers;

use App\Models\Ressource;
use App\Utils\Utils;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;


class RessourceController extends Controller {
    const ID_ACCEPTED_STATUS = 1;
    const ID_PENDING_STATUS = 2;
    const ID_REJECTED_STATUS = 3;
    const ID_BLOCKED_STATUS = 4;

    /**
     * @OA\Get(
     *     path="/ressource/{id}",
     *     tags={"Ressource"},
     *     summary="Get a specific resource",
     *     description="Retrieves detailed information about a specific resource by ID and increments its view count.",
     *     operationId="getRessource",
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID of the resource to retrieve",
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Resource retrieved successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="ressource",
     *                 ref="#/components/schemas/RessourceDetail"
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Resource not found",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource non trouvée")
     *         )
     *     )
     * )
     */
    public function getRessource($id) {
        $ressource = Ressource::find($id);

        if (!$ressource) {
            return response()->json(['message' => 'Ressource non trouvée'], 404);
        }

        // Add one to the view count
        $ressource->view_count += 1;
        $ressource->save();

        return response()->json(['ressource' => Utils::getRessourceDetail($ressource)], 200);
    }

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
            'label' => 'required|string|max:255',
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

    /**
     * @OA\Get(
     *     path="/myRessources",
     *     tags={"Ressource"},
     *     summary="Get user's resources",
     *     description="Retrieves a list of resources created by the authenticated user.",
     *     operationId="getMyRessources",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Response(
     *         response=200,
     *         description="Resources retrieved successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="ressources",
     *                 type="array",
     *                 @OA\Items(ref="#/components/schemas/RessourceDetail")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Unauthorized - User must be logged in",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Unauthorized - User must be logged in")
     *         )
     *     )
     * )
     */
    public function getMyRessources() {
        $ressources = Ressource::where('id_user', auth()->user()->id_user)->get();
        return response()->json(['ressources' => Utils::mapRessourcesToDetails($ressources)], 200);
    }

    /**
     * @OA\Get(
     *     path="/ressources/pending",
     *     tags={"Ressource"},
     *     summary="Get pending ressources",
     *     description="Retrieves a list of all ressources that are currently pending. This endpoint is restricted to moderators.",
     *     operationId="getPendingRessources",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Response(
     *         response=200,
     *         description="Successful operation",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="ressources",
     *                 type="array",
     *                 @OA\Items(ref="#/components/schemas/RessourceDetail")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=403,
     *         description="Forbidden - Moderator access required",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Access restricted to moderators")
     *         )
     *     )
     * )
     */
    public function pending() {
        $ressources = Ressource::where('id_status', self::ID_PENDING_STATUS)->get();

        return response()->json(['ressources' => Utils::mapRessourcesToDetails($ressources)], 200);
    }

    /**
     * @OA\Get(
     *     path="/ressources/accepted",
     *     tags={"Ressource"},
     *     summary="Get accepted ressources",
     *     description="Retrieves a list of all ressources that have been accepted. This endpoint is restricted to moderators.",
     *     operationId="getAcceptedRessources",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Response(
     *         response=200,
     *         description="Successful operation",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="ressources",
     *                 type="array",
     *                 @OA\Items(ref="#/components/schemas/RessourceDetail")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=403,
     *         description="Forbidden - Moderator access required",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Access restricted to moderators")
     *         )
     *     )
     * )
     */
    public function accepted(){
        $ressources = Ressource::where('id_status', self::ID_ACCEPTED_STATUS)->get();
        return response()->json(['ressources' => Utils::mapRessourcesToDetails($ressources)], 200);
    }

    /**
     * @OA\Get(
     *     path="/ressources/rejected",
     *     tags={"Ressource"},
     *     summary="Get rejected ressources",
     *     description="Retrieves a list of all ressources that have been rejected. This endpoint is restricted to moderators.",
     *     operationId="getRejectedRessources",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Response(
     *         response=200,
     *         description="Successful operation",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="ressources",
     *                 type="array",
     *                 @OA\Items(ref="#/components/schemas/RessourceDetail")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=403,
     *         description="Forbidden - Moderator access required",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Access restricted to moderators")
     *         )
     *     )
     * )
     */
    public function rejected(){
        $ressources = Ressource::where('id_status', self::ID_REJECTED_STATUS)->get();
        return response()->json(['ressources' => Utils::mapRessourcesToDetails($ressources)], 200);
    }

    /**
     * @OA\Get(
     *     path="/ressources/blocked",
     *     tags={"Ressource"},
     *     summary="Get blocked ressources",
     *     description="Retrieves a list of all ressources that have been blocked. This endpoint is restricted to moderators.",
     *     operationId="getBlockedRessources",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Response(
     *         response=200,
     *         description="Successful operation",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="ressources",
     *                 type="array",
     *                 @OA\Items(ref="#/components/schemas/RessourceDetail")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=403,
     *         description="Forbidden - Moderator access required",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Access restricted to moderators")
     *         )
     *     )
     * )
     */
    public function blocked(){
        $ressources = Ressource::where('id_status', 4)->get();
        return response()->json(['ressources' => Utils::mapRessourcesToDetails($ressources)], 200);
    }

    /**
     * @OA\Patch(
     *     path="/ressources/accept/{id}",
     *     tags={"Ressource"},
     *     summary="Accept a ressource",
     *     description="Marks a pending ressource as accepted. This endpoint is restricted to moderators.",
     *     operationId="acceptRessource",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID of the ressource to accept",
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="ressource accepted successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource acceptée")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="ressource already processed",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource déjà traitée")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="ressource not found",
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
    public function accept($id) {
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
     *     path="/ressources/reject/{id}",
     *     tags={"Ressource"},
     *     summary="Reject a ressource",
     *     description="Marks a pending ressource as rejected. This endpoint is restricted to moderators.",
     *     operationId="rejectRessource",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID of the ressource to reject",
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="ressource rejected successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource refusée")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="ressource already processed",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource déjà traitée")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="ressource not found",
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
    public function reject($id) {
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

    /**
     * @OA\Patch(
     *     path="/ressources/block/{id}",
     *     tags={"Ressource"},
     *     summary="Block a specific ressource",
     *     description="Blocks a specific ressource by setting its status to blocked. This endpoint is restricted to moderators.",
     *     operationId="blockRessource",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID of the ressource to block",
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="ressource blocked successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource bloquée")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="ressource not found",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource non trouvée")
     *         )
     *     ),
     *     @OA\Response(
     *         response=403,
     *         description="Forbidden - Moderator access required",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Access restricted to moderators")
     *         )
     *     )
     * )
     */
    public function block($id) {
        $ressource = Ressource::find($id);

        if (!$ressource) {
            return response()->json(['message' => 'Ressource non trouvée'], 404);
        }

        $ressource->id_status = self::ID_BLOCKED_STATUS;
        $ressource->save();

        return response()->json(['message' => 'Ressource bloquée'], 200);
    }




}
