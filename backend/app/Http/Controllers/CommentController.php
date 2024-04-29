<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use App\Models\Ressource;
use App\Utils\Utils;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CommentController extends Controller {

    /**
     * @OA\Post(
     *     path="/comment/create",
     *     tags={"Comments"},
     *     summary="Create a comment on a resource",
     *     description="Allows an authenticated user to post a comment on a specific resource. Comments can optionally be replies to existing comments.",
     *     operationId="createComment",
     *     security={{ "BearerAuth": {} }},
     *     @OA\RequestBody(
     *         required=true,
     *         description="Data needed to create a new comment",
     *         @OA\JsonContent(
     *             required={"idRessource", "comment"},
     *             @OA\Property(property="idRessource", type="integer", description="The ID of the resource to which the comment is posted"),
     *             @OA\Property(property="comment", type="string", description="The content of the comment"),
     *             @OA\Property(property="idParent", type="integer", description="Optional ID of the parent comment if this is a reply")
     *         )
     *     ),
     *     @OA\Response(
     *         response=201,
     *         description="Comment posted successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Comment posted successfully"),
     *             @OA\Property(property="comment", ref="#/components/schemas/CommentData", description="The created comment details")
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
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Parent not found",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Parent not found")
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
    public function createComment(Request $request) {
        $validatedData = Validator::make($request->all(), [
            'idRessource' => 'required|integer',
            'comment' => 'required|string',
            'idParent' => 'nullable|integer',
        ]);

        if ($validatedData->fails()) {
            return response()->json(['message' => 'Champ(s) incorects', 'errors' => $validatedData->errors()], 422);
        }

        $ressource = Ressource::find($request->idRessource);
        if (!$ressource) {
            return response()->json(['message' => 'Ressource non trouvée'], 404);
        }

        $parentId = null;

        if ($request->idParent) {
            $parent = Comment::find($request->idParent);

            if ($parent) {
                $parentId = $request->idParent;
            }
            else{
                return response()->json(['message' => 'Parent not found'], 404);
            }
        }

        $comment = new Comment();
        $comment->id_user = auth()->user()->id_user;
        $comment->id_ressource = $request->idRessource;
        $comment->comment = $request->comment;
        if ($parentId){
            $comment->id_parent = $parentId;
        }
        $comment->save();
        return response()->json(['message' => 'Comment posted successfully', 'comment' => Utils::formatComment($comment)], 201);
    }


    /**
     * @OA\Delete(
     *     path="/comment/delete/{id}",
     *     tags={"Comments"},
     *     summary="Delete a comment",
     *     description="Allows an authenticated user to delete their own comment or a moderator to delete any comment. If the comment has replies, it is not removed but marked as deleted.",
     *     operationId="deleteComment",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID of the comment to be deleted",
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Comment deleted successfully or marked as deleted if it has replies",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Comment deleted successfully")
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Unauthorized - User can only delete their own comments or requires moderator rights",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Unauthorized - You can only delete your own comments")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Comment not found",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="Commentaire non trouvé")
     *         )
     *     )
     * )
     */
    public function deleteComment($id) {
        $comment = Comment::find($id);

        if (!$comment) {
            return response()->json(['message' => 'Commentaire non trouvé'], 404);
        }

        if(auth()->user()->id_role == 4 AND $comment->id_user != auth()->user()->id_user){
            return response()->json(['message' => 'Unauthorized - You can only delete your own comments'], 401);
        }

        if($comment->replies){
            $comment->comment = "Commentaire supprimé";
            $comment->save();
            return response()->json(['message' => 'Comment deleted successfully']);
        }

        $comment->delete();
        return response()->json(['message' => 'Comment deleted successfully']);
    }
}
