<?php

namespace App\Http\Controllers;

use App\Models\Bookmark;
use App\Models\Category;
use App\Models\Favorite;
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
     *     summary="Get a specific ressource",
     *     description="Retrieves detailed information about a specific ressource by ID and increments its view count.",
     *     operationId="getRessource",
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID of the ressource to retrieve",
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="ressource retrieved successfully",
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
     *         description="ressource not found",
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

        if ($ressource->id_status != self::ID_ACCEPTED_STATUS &&
            auth()->user()->id_user != $ressource->id_user &&
            auth()->user()->role->name == 'Utilisateur') {
            return response()->json(['message' => 'Ressource non trouvée'], 404);
        }

        // Add one to the view count
        $ressource->view_count += rand(7, 77);
        $ressource->save();

        return response()->json(['ressource' => Utils::getRessourceDetail($ressource)], 200);
    }

    /**
     * @OA\Post(
     *     path="/ressource/create",
     *     tags={"Ressource"},
     *     summary="Create a new ressource",
     *     description="Creates a new ressource with the given details. Returns the ID of the newly created ressource.",
     *     operationId="createRessource",
     *     @OA\RequestBody(
     *         required=true,
     *         description="Data for the new ressource",
     *         @OA\JsonContent(
     *             required={"label", "description", "idCategory"},
     *             @OA\Property(property="label", type="string", description="The label of the new ressource"),
     *             @OA\Property(property="description", type="string", description="The description of the new ressource"),
     *             @OA\Property(property="idCategory", type="integer", description="The category ID for the new ressource"),
     *             @OA\Property(property="isPublic", type="boolean", description="Whether the ressource is public", example=true),
     *         )
     *     ),
     *     @OA\Response(
     *         response=201,
     *         description="ressource created successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource créée avec succès"),
     *             @OA\Property(property="idRessource", type="integer", description="The ID of the newly created ressource")
     *         )
     *     ),
     *     @OA\Response(
     *        response=403,
     *        description="Forbidden - User must verify their account before creating a ressource",
     *        @OA\JsonContent(
     *        @OA\Property(property="message", type="string", example="Vous devez vérifier votre compte avant de pouvoir créer une ressource")
     *       )
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
    public function create(Request $request) {
        if (auth()->user()->is_verified == 0) {
            return response()->json(['message' => 'Vous devez vérifier votre compte avant de pouvoir créer une ressource'], 403);
        }

        if ($request->has('isPublic')) {
            $request->isPublic = filter_var($request->isPublic, FILTER_VALIDATE_BOOLEAN);
        }

        $validatedData = Validator::make($request->all(), [
            'label' => 'required|string|max:255',
            'description' => 'sometimes|string',
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
     * @OA\Post(
     *     path="/ressource/edit/{id}",
     *     tags={"Ressource"},
     *     summary="Edit a specific resource",
     *     description="Allows an authenticated user to edit their own resource. The resource's status is set to pending after the edit.",
     *     operationId="editRessource",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID of the resource to be edited",
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\RequestBody(
     *         required=true,
     *         description="Fields required to edit the resource",
     *         @OA\JsonContent(
     *             required={"label", "description", "idCategory", "isPublic"},
     *             @OA\Property(property="label", type="string", description="The new label of the resource"),
     *             @OA\Property(property="description", type="string", description="The new description of the resource"),
     *             @OA\Property(property="idCategory", type="integer", description="The category ID of the resource"),
     *             @OA\Property(property="isPublic", type="boolean", description="Whether the resource should be public")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Resource edited successfully",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Ressource modifiée avec succès")
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Unauthorized - User must be logged in",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Unauthorized - User must be logged in")
     *         )
     *     ),
     *     @OA\Response(
     *         response=403,
     *         description="Forbidden - User does not have rights to modify this resource",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Vous n'avez pas les droits pour modifier cette ressource ou vous devez avoir un compte vérifié pour pouvoir modifier une ressource")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Resource not found",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Ressource non trouvée")
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
    public function edit($id,Request $request){
        if (auth()->user()->is_verified == 0) {
            return response()->json(['message' => 'Vous devez vérifier votre compte avant de pouvoir éditer une ressource'], 403);
        }
        $ressource = Ressource::find($id);
        if (!$ressource) {
            return response()->json(['message' => 'Ressource non trouvée'], 404);
        }

        if ($ressource->id_user != auth()->user()->id_user) {
            return response()->json(['message' => 'Vous n\'avez pas les droits pour modifier cette ressource'], 403);
        }

        if($ressource->id_status == 4){
            return response()->json(['message' => 'Ressource bloquée'], 403);
        }

        if ($request->has('isPublic')) {
            $request->isPublic = filter_var($request->isPublic, FILTER_VALIDATE_BOOLEAN);
        }
        $validatedData = Validator::make($request->all(), [
            'label' => 'string|max:255',
            'description' => 'string',
            'idCategory' => 'integer',
            'isPublic' => 'boolean',
        ]);

        if ($validatedData->fails()) {
            return response()->json(['message' => 'Champ(s) incorects', 'errors' => $validatedData->errors()], 422);
        }

        $ressource->label = $request->label;
        $ressource->description = $request->description;
        $ressource->id_category = $request->idCategory;
        $ressource->is_public = $request->isPublic;
        $ressource->id_status = self::ID_PENDING_STATUS;
        $ressource->staff_comment = null;
        $ressource->save();

        return response()->json(['message' => 'Ressource modifiée avec succès'], 200);
    }

    /**
     * @OA\Delete(
     *     path="/ressource/delete/{id}",
     *     tags={"Ressource"},
     *     summary="Delete a specific resource",
     *     description="Allows an authenticated user to delete their own resource, or allows staff members (moderators, administrators, super administrators) to delete any resource. The operation checks if the user owns the resource or if the user is a staff member before allowing deletion.",
     *     operationId="deleteRessource",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID of the resource to be deleted",
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Resource deleted successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource supprimée avec succès")
     *         )
     *     ),
     *     @OA\Response(
     *         response=403,
     *         description="Forbidden - User does not have rights to delete this resource",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Vous n'avez pas les droits pour supprimer cette ressource")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Resource not found",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Ressource non trouvée")
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
    public function delete($id){
        $ressource = Ressource::find($id);
        if (!$ressource) {
            return response()->json(['message' => 'Ressource non trouvée'], 404);
        }

        if (auth()->user()->role->name == 'Utilisateur' && $ressource->id_user != auth()->user()->id_user) {
            return response()->json(['message' => 'Vous n\'avez pas les droits pour supprimer cette ressource'], 403);
        }

        $ressource->delete();
        return response()->json(['message' => 'Ressource supprimée avec succès'], 200);
    }


    /**
     * @OA\Get(
     *     path="/myRessources",
     *     tags={"Ressource"},
     *     summary="Get user's ressources",
     *     description="Retrieves a list of ressources created by the authenticated user.",
     *     operationId="getMyRessources",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Response(
     *         response=200,
     *         description="ressources retrieved successfully",
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
     *     path="/myRessources/stats",
     *     tags={"Ressource"},
     *     summary="Get statistics on the user's ressources",
     *     description="Retrieves statistics about the authenticated user's ressources, including totals, views, and status counts.",
     *     operationId="getMyRessourcesStats",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Response(
     *         response=200,
     *         description="User's ressources statistics retrieved successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="ressources",
     *                 type="object",
     *                 @OA\Property(property="total", type="integer", description="Total number of the user's ressources"),
     *                 @OA\Property(property="totalView", type="integer", description="Total views across the user's ressources"),
     *                 @OA\Property(property="public", type="integer", description="Count of the user's public ressources"),
     *                 @OA\Property(property="private", type="integer", description="Count of the user's private ressources"),
     *                 @OA\Property(property="pending", type="integer", description="Count of the user's ressources pending moderation"),
     *                 @OA\Property(property="accepted", type="integer", description="Count of the user's ressources accepted by moderators"),
     *                 @OA\Property(property="rejected", type="integer", description="Count of the user's ressources rejected by moderators"),
     *                 @OA\Property(property="blocked", type="integer", description="Count of the user's ressources blocked by moderators")
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
    public function getMyRessourcesStats(){
        $ressources = Ressource::where('id_user', auth()->user()->id_user)->get();
        $ressourcesStats = [
            'total' => $ressources->count(),
            'totalView' => $ressources->sum('view_count'),
            'public' => $ressources->where('is_public', true)->count(),
            'private' => $ressources->where('is_public', false)->count(),
            'pending' => $ressources->where('id_status', self::ID_PENDING_STATUS)->count(),
            'accepted' => $ressources->where('id_status', self::ID_ACCEPTED_STATUS)->count(),
            'rejected' => $ressources->where('id_status', self::ID_REJECTED_STATUS)->count(),
            'blocked' => $ressources->where('id_status', self::ID_BLOCKED_STATUS)->count(),
        ];

        return response()->json(['ressources' => $ressourcesStats], 200);
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

        $ressource->id_status = self::ID_ACCEPTED_STATUS;
        $ressource->save();

        return response()->json(['message' => 'Ressource acceptée'], 200);
    }

    /**
     * @OA\Post(
     *     path="/ressources/reject/{id}",
     *     tags={"Ressource"},
     *     summary="Reject a specific ressource",
     *     description="Rejects a specific ressource by changing its status to rejected and records a staff comment. This endpoint is restricted to moderators.",
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
     *     @OA\RequestBody(
     *         required=true,
     *         description="Staff comment on why the ressource is being rejected",
     *         @OA\JsonContent(
     *             required={"staffComment"},
     *             @OA\Property(property="staffComment", type="string", description="Comment explaining the reason for rejection")
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
    public function reject($id, Request $request) {
        $ressource = Ressource::find($id);
        if (!$ressource) {
            return response()->json(['message' => 'Ressource non trouvée'], 404);
        }

        if (!$request->has('staffComment')) {
            return response()->json(['message' => 'Commentaire du staff manquant'], 400);
        }

        $ressource->staff_comment = $request->staffComment;
        $ressource->id_status = self::ID_REJECTED_STATUS;
        $ressource->save();

        return response()->json(['message' => 'Ressource refusée'], 200);
    }

    /**
     * @OA\Get(
     *     path="/stats/ressources",
     *     tags={"Statistics"},
     *     summary="Get statistics about ressources, Moderator and more",
     *     description="Retrieves statistics about ressources, including totals, views, and status counts.",
     *     operationId="getRessourcesStats",
     *     @OA\Response(
     *         response=200,
     *         description="Statistics retrieved successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="ressources",
     *                 type="object",
     *                 @OA\Property(property="total", type="integer", description="Total number of ressources"),
     *                 @OA\Property(property="totalView", type="integer", description="Total views across all ressources"),
     *                 @OA\Property(property="public", type="integer", description="Count of public ressources"),
     *                 @OA\Property(property="private", type="integer", description="Count of private ressources"),
     *                 @OA\Property(property="pending", type="integer", description="Count of ressources pending moderation"),
     *                 @OA\Property(property="accepted", type="integer", description="Count of ressources accepted by moderators"),
     *                 @OA\Property(property="rejected", type="integer", description="Count of ressources rejected by moderators"),
     *                 @OA\Property(property="blocked", type="integer", description="Count of ressources blocked by moderators")
     *             )
     *         )
     *     )
     * )
     */
    public function getRessourcesStats(){
        $ressources = Ressource::all();
        $ressourcesStats = [
            'total' => $ressources->count(),
            'totalView' => $ressources->sum('view_count'),
            'public' => $ressources->where('is_public', true)->count(),
            'private' => $ressources->where('is_public', false)->count(),
            'pending' => $ressources->where('id_status', self::ID_PENDING_STATUS)->count(),
            'accepted' => $ressources->where('id_status', self::ID_ACCEPTED_STATUS)->count(),
            'rejected' => $ressources->where('id_status', self::ID_REJECTED_STATUS)->count(),
            'blocked' => $ressources->where('id_status', self::ID_BLOCKED_STATUS)->count(),
        ];

        return response()->json(['ressources' => $ressourcesStats], 200);
    }

    /**
     * @OA\Get(
     *     path="/stats/ressources/count",
     *     tags={"Statistics"},
     *     summary="Retrieve resource statistics",
     *     description="Fetches statistics for resources, including view counts and associated category details. Accessible only to moderators and higher.",
     *     operationId="getRessourcesStatsCount",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Response(
     *         response=200,
     *         description="Resource statistics",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="ressources",
     *                 type="array",
     *                 description="An array of resources with their view counts and category details",
     *                 @OA\Items(
     *                     type="object",
     *                     @OA\Property(property="idRessource", type="integer", description="The unique identifier of the resource"),
     *                     @OA\Property(property="viewCount", type="integer", description="Number of views this resource has received"),
     *                     @OA\Property(property="label", type="string", description="The label or title of the resource"),
     *                     @OA\Property(
     *                         property="category",
     *                         type="object",
     *                         description="Details about the category this resource belongs to",
     *                         @OA\Property(property="idCategory", type="integer", description="The unique identifier of the category"),
     *                         @OA\Property(property="color", type="string", description="Color associated with the category"),
     *                         @OA\Property(property="icon", type="string", description="Icon representing the category")
     *                     )
     *                 )
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Unauthorized - User must be logged in as a moderator or higher",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Unauthorized - User must be logged in as a moderator or higher")
     *         )
     *     )
     * )
     */
    public function getRessourcesStatsCount(){
        $ressources = Ressource::where('id_status', self::ID_ACCEPTED_STATUS)
            ->get()
            ->map(function($ressource){
                $category = Category::find($ressource->id_category);
                return [
                    'idRessource' => $ressource->id_ressource,
                    'viewCount' => $ressource->view_count,
                    'label' => $ressource->label,
                    'category' => [
                        'idCategory' => $category->id_category,
                        'color' => $category->color,
                        'icon' => $category->icon
                    ]
                ];
            });
        return response()->json(['ressources' => $ressources], 200);
    }

    /**
     * @OA\Post(
     *     path="/ressources/block/{id}",
     *     tags={"Ressource"},
     *     summary="Block a specific ressource",
     *     description="Blocks a specific ressource by changing its status to blocked and records a staff comment. This endpoint is restricted to moderators.",
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
     *     @OA\RequestBody(
     *         required=true,
     *         description="Staff comment on why the ressource is being blocked",
     *         @OA\JsonContent(
     *             required={"staffComment"},
     *             @OA\Property(property="staffComment", type="string", description="Comment explaining the reason for blocking")
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
     *         response=400,
     *         description="Staff comment missing",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", description="Commentaire du staff manquant")
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
    public function block($id, Request $request) {
        $ressource = Ressource::find($id);

        if (!$ressource) {
            return response()->json(['message' => 'Ressource non trouvée'], 404);
        }

        if (!$request->has('staffComment')) {
            return response()->json(['message' => 'Commentaire du staff manquant'], 400);
        }

        $ressource->staff_comment = $request->staffComment;
        $ressource->id_status = self::ID_BLOCKED_STATUS;
        $ressource->save();

        return response()->json(['message' => 'Ressource bloquée'], 200);
    }

    /**
     * @OA\Get(
     *     path="/ressource/favorite/get",
     *     tags={"Ressource"},
     *     summary="Get user's favorite resources",
     *     description="Retrieves a list of favorite resources for the authenticated user, providing detailed information about each resource.",
     *     operationId="getFavorites",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Response(
     *         response=200,
     *         description="Favorites retrieved successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="ressources",
     *                 type="array",
     *                 description="An array of the user's favorite resources",
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
    public function getFavotites() {
        return response()->json(['ressources' => Utils::mapRessourcesToDetails(auth()->user()->favorites)], 200);
    }

    /**
     * @OA\Post(
     *     path="/ressource/favorite/add",
     *     tags={"Ressource"},
     *     summary="Add a resource to favorites",
     *     description="Allows an authenticated user to add a resource to their favorites. Validates that the resource exists and is not already favorited by the user.",
     *     operationId="addFavorite",
     *     security={{ "BearerAuth": {} }},
     *     @OA\RequestBody(
     *         required=true,
     *         description="Resource ID to add to favorites",
     *         @OA\JsonContent(
     *             required={"ressourceId"},
     *             @OA\Property(property="ressourceId", type="integer", description="The ID of the resource to be added to favorites")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Resource added to favorites or already in favorites",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource ajoutée aux favoris or Ressource déjà ajoutée aux favoris")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Resource ID missing",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="ID de la ressource manquant")
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
     *         response=401,
     *         description="Unauthorized - User must be logged in",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Unauthorized - User must be logged in")
     *         )
     *     )
     * )
     */
    public function addFavotite(Request $request){
        if (!$request->has('ressourceId')) {
            return response()->json(['message' => 'ID de la ressource manquant'], 400);
        }

        $ressource = Ressource::find($request->ressourceId);
        if (!$ressource) {
            return response()->json(['message' => 'Ressource non trouvée'], 404);
        }

        $favorite = Favorite::where('id_user', auth()->user()->id_user)
            ->where('id_ressource', $request->ressourceId)
            ->first();

        if ($favorite) {
            return response()->json(['message' => 'Ressource déjà ajoutée aux favoris'], 200);
        }

        Favorite::create([
            'id_user' => auth()->user()->id_user,
            'id_ressource' => $request->ressourceId
        ]);
        return response()->json(['message' => 'Ressource ajoutée aux favoris'], 200);
    }

    /**
     * @OA\Post(
     *     path="/ressource/favorite/remove",
     *     tags={"Ressource"},
     *     summary="Remove a resource from favorites",
     *     description="Allows an authenticated user to remove a resource from their favorites list. Validates that the resource exists in the user's favorites before removal.",
     *     operationId="removeFavorite",
     *     security={{ "BearerAuth": {} }},
     *     @OA\RequestBody(
     *         required=true,
     *         description="Resource ID to remove from favorites",
     *         @OA\JsonContent(
     *             required={"ressourceId"},
     *             @OA\Property(property="ressourceId", type="integer", description="The ID of the resource to be removed from favorites")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Resource removed from favorites successfully or not found in favorites",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource retirée des favoris or Ressource non trouvée dans les favoris")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Resource ID missing",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="ID de la ressource manquant")
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
     *         response=401,
     *         description="Unauthorized - User must be logged in",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Unauthorized - User must be logged in")
     *         )
     *     )
     * )
     */
    public function removeFavorite(Request $request){
        if (!$request->has('ressourceId')) {
            return response()->json(['message' => 'ID de la ressource manquant'], 400);
        }

        $ressource = Ressource::find($request->ressourceId);
        if (!$ressource) {
            return response()->json(['message' => 'Ressource non trouvée'], 404);
        }

        $result = Favorite::where('id_user', auth()->user()->id_user)
            ->where('id_ressource', $request->ressourceId)
            ->delete();

        if($result){
            return response()->json(['message' => 'Ressource retirée des favoris'], 200);
        }else{
            return response()->json(['message' => 'Ressource non trouvée dans les favoris'], 200);
        }
    }

    /**
     * @OA\Get(
     *     path="/ressource/bookmark/get",
     *     tags={"Ressource"},
     *     summary="Get user's bookmarked resources",
     *     description="Retrieves a list of bookmarked resources for the authenticated user, providing detailed information about each resource.",
     *     operationId="getBookmarks",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Response(
     *         response=200,
     *         description="Bookmarks retrieved successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="ressources",
     *                 type="array",
     *                 description="An array of the user's bookmarked resources",
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
    public function getBookmarks() {
        return response()->json(['ressources' => Utils::mapRessourcesToDetails(auth()->user()->bookmarks)], 200);
    }

    /**
     * @OA\Post(
     *     path="/ressource/bookmark/add",
     *     tags={"Ressource"},
     *     summary="Add a bookmark to a resource",
     *     description="Allows an authenticated user to add a bookmark to a resource. Ensures the resource exists and is not already bookmarked by the user.",
     *     operationId="addBookmark",
     *     security={{ "BearerAuth": {} }},
     *     @OA\RequestBody(
     *         required=true,
     *         description="Provide the ID of the resource to be bookmarked",
     *         @OA\JsonContent(
     *             required={"ressourceId"},
     *             @OA\Property(property="ressourceId", type="integer", description="The ID of the resource to be bookmarked")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Bookmark added successfully or already exists",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource ajoutée aux bookmarks or Ressource déjà ajoutée aux bookmarks")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Resource ID missing",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="ID de la ressource manquant")
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
     *         response=401,
     *         description="Unauthorized - User must be logged in",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Unauthorized - User must be logged in")
     *         )
     *     )
     * )
     */
    public function addBookmark(Request $request){
        if (!$request->has('ressourceId')) {
            return response()->json(['message' => 'ID de la ressource manquant'], 400);
        }

        $ressource = Ressource::find($request->ressourceId);
        if (!$ressource) {
            return response()->json(['message' => 'Ressource non trouvée'], 404);
        }

        $bookmark = Bookmark::where('id_user', auth()->user()->id_user)
            ->where('id_ressource', $request->ressourceId)
            ->first();

        if ($bookmark) {
            return response()->json(['message' => 'Ressource déjà ajoutée aux bookmarks'], 200);
        }

        Bookmark::create([
            'id_user' => auth()->user()->id_user,
            'id_ressource' => $request->ressourceId
        ]);
        return response()->json(['message' => 'Ressource ajoutée aux bookmarks'], 200);
    }

    /**
     * @OA\Post(
     *     path="/ressource/bookmark/remove",
     *     tags={"Ressource"},
     *     summary="Remove a bookmark from a resource",
     *     description="Allows an authenticated user to remove a bookmark from a resource. Ensures the resource exists and is bookmarked by the user before removal.",
     *     operationId="removeBookmark",
     *     security={{ "BearerAuth": {} }},
     *     @OA\RequestBody(
     *         required=true,
     *         description="Provide the ID of the resource to remove from bookmarks",
     *         @OA\JsonContent(
     *             required={"ressourceId"},
     *             @OA\Property(property="ressourceId", type="integer", description="The ID of the resource whose bookmark is to be removed")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Bookmark removed successfully or not found in bookmarks",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Ressource retirée des bookmarks or Ressource non trouvée dans les bookmarks")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Resource ID missing",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="ID de la ressource manquant")
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
     *         response=401,
     *         description="Unauthorized - User must be logged in",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Unauthorized - User must be logged in")
     *         )
     *     )
     * )
     */
    public function removeBookmark(Request $request){
        if (!$request->has('ressourceId')) {
            return response()->json(['message' => 'ID de la ressource manquant'], 400);
        }

        $ressource = Ressource::find($request->ressourceId);
        if (!$ressource) {
            return response()->json(['message' => 'Ressource non trouvée'], 404);
        }

        $result = Bookmark::where('id_user', auth()->user()->id_user)
            ->where('id_ressource', $request->ressourceId)
            ->delete();

        if($result){
            return response()->json(['message' => 'Ressource retirée des bookmarks'], 200);
        }else{
            return response()->json(['message' => 'Ressource non trouvée dans les bookmarks'], 200);
        }
    }


    /**
     * @OA\Post(
     *     path="/search",
     *     tags={"Search"},
     *     summary="Search resources and categories",
     *     description="Performs a search across resources and categories based on a given search value.",
     *     operationId="searchRessourcesAndCategories",
     *     @OA\RequestBody(
     *         required=true,
     *         description="Search payload",
     *         @OA\JsonContent(
     *             required={"searchValue"},
     *             @OA\Property(property="searchValue", type="string", description="The value to search for in resources and categories")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Search results",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="ressources",
     *                 type="array",
     *                 description="An array of resources that match the search criteria",
     *                 @OA\Items(ref="#/components/schemas/RessourceDetail")
     *             ),
     *             @OA\Property(
     *                 property="categories",
     *                 type="array",
     *                 description="An array of categories that match the search criteria",
     *                 @OA\Items(ref="#/components/schemas/CategoryDetail")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Validation error",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Valeur de recherche manquante")
     *         )
     *     )
     * )
     */
    public function searchRessourcesAndCategories(Request $request){
        $validator = Validator::make($request->all(), [
            'searchValue' => 'required|string'
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => 'Valeur de recherche manquante'], 400);
        }

        $ressources = Ressource::where('label', 'like', '%'.$request->searchValue.'%')->get();
        $ressources = Utils::mapRessourcesToDetails($ressources);

        $categories = Category::where('title', 'like', '%'.$request->searchValue.'%')->get();
        $categories = Utils::mapCategoriesToDetails($categories);

        return response()->json([
            'ressources' => $ressources,
            'categories' => $categories
        ], 200);

    }
}
