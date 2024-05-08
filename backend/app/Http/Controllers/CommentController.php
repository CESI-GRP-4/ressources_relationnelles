<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use App\Models\Ressource;
use App\Models\User;
use App\Utils\Utils;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CommentController extends Controller
{
    const ACCEPTED = 1;
    const PENDING = 2;
    const REJECTED = 3;

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
    public function createComment(Request $request)
    {
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
            } else {
                return response()->json(['message' => 'Parent not found'], 404);
            }
        }

        $comment = new Comment();
        $comment->id_user = auth()->user()->id_user;
        $comment->id_ressource = $request->idRessource;
        $comment->comment = $request->comment;
        $comment->id_status = self::PENDING;
        if ($parentId) {
            $comment->id_parent = $parentId;
        }
        $comment->save();
        return response()->json(['message' => 'Comment posted successfully', 'comment' => Utils::formatComment($comment)], 201);
    }

    /**
     * @OA\Schema(
     *     schema="FormattedComment",
     *     type="object",
     *     description="Formatted information about a comment",
     *     @OA\Property(property="id", type="integer", description="The unique identifier of the comment"),
     *     @OA\Property(
     *         property="user",
     *         type="object",
     *         description="Details about the user who made the comment",
     *         ref="#/components/schemas/UserData"
     *     ),
     *     @OA\Property(property="comment", type="string", description="The content of the comment"),
     *     @OA\Property(property="createAt", type="string", format="date-time", description="The date and time when the comment was created"),
     *     @OA\Property(property="ressourceId", type="integer",description="Ressource Id of the comment")
     * )
     */
    public function formatComment($comment)
    {
        return [
            'id' => $comment->id_comment,
            'user' => Utils::getUserData(User::find($comment->id_user)),
            'comment' => $comment->comment,
            'createAt' => $comment->created_at,
            'ressourceId' => $comment->id_ressource,
        ];
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
    public function deleteComment($id)
    {
        $comment = Comment::find($id);

        if (!$comment) {
            return response()->json(['message' => 'Commentaire non trouvé'], 404);
        }

        if (auth()->user()->id_role == 4 and $comment->id_user != auth()->user()->id_user) {
            return response()->json(['message' => 'Unauthorized - You can only delete your own comments'], 401);
        }

        if ($comment->replies()->count() > 0){
            $comment->comment = "Commentaire supprimé";
            $comment->save();
        }else{
            $comment->delete();
            $this->tryDeleteParents($comment->id_parent);
        }
        return response()->json(['message' => 'Comment deleted successfully']);
    }

    private function tryDeleteParents($parentId)
    {
        if (!$parentId) { return; }

        $parent = Comment::find($parentId);
        if ($parent && $parent->comment == "Commentaire supprimé" && $parent->replies()->count() == 0) {
            $parentCommentId = $parent->id_parent;
            $parent->delete();
            $this->tryDeleteParent($parentCommentId);
        }
    }


    /**
     * @OA\Patch(
     *     path="/comment/accept/{id}",
     *     tags={"Comments"},
     *     summary="Accept a comment",
     *     description="Allows a moderator to accept a comment that is currently in a pending state. The comment can only be accepted if it is pending and, if it has a parent comment, the parent must also be accepted.",
     *     operationId="acceptComment",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         description="ID of the comment to be accepted",
     *         required=true,
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Comment accepted successfully",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Commentaire accepté")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Comment not in pending state or parent comment not accepted",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Commentaire n'est pas en attente or Le commentaire parent n'est pas accepté")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Comment not found",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Commentaire non trouvé")
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Unauthorized - User must be logged in and have moderator privileges",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Unauthorized - User must be logged in and have moderator privileges")
     *         )
     *     )
     * )
     */
    public function accept($id)
    {
        $comment = Comment::find($id);
        if (!$comment) {
            return response()->json(['message' => 'Commentaire non trouvé'], 404);
        }

        if ($comment->id_status != self::PENDING) {
            return response()->json(['message' => 'Commentaire n\'est pas en attente'], 400);
        }


        if ($comment->id_parent) {
            $parent = Comment::find($comment->id_parent);
            if ($parent->id_status != self::ACCEPTED) {
                return response()->json(['message' => 'Le commentaire parent n\'est pas accepté'], 400);
            }
        }

        $comment->id_status = self::ACCEPTED;
        $comment->save();
        return response()->json(['message' => 'Commentaire accepté']);
    }

    /**
     * @OA\Patch(
     *     path="/comment/reject/{id}",
     *     tags={"Comments"},
     *     summary="Reject a comment",
     *     description="Allows a moderator to reject a comment that is currently in a pending state. Only comments that are pending can be rejected.",
     *     operationId="rejectComment",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         description="ID of the comment to be rejected",
     *         required=true,
     *         @OA\Schema(
     *             type="integer"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Comment rejected successfully",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Commentaire rejeté")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Comment not in pending state",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Commentaire n'est pas en attente")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Comment not found",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Commentaire non trouvé")
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Unauthorized - User must be logged in and have moderator privileges",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Unauthorized - User must be logged in and have moderator privileges")
     *         )
     *     )
     * )
     */
    public function reject($id)
    {
        $comment = Comment::find($id);
        if (!$comment) {
            return response()->json(['message' => 'Commentaire non trouvé'], 404);
        }

        if ($comment->id_status != self::PENDING) {
            return response()->json(['message' => 'Commentaire n\'est pas en attente'], 400);
        }

        $comment->id_status = self::REJECTED;
        $comment->save();
        return response()->json(['message' => 'Commentaire accepté']);
    }

    /**
     * @OA\Get(
     *     path="/comment/pending",
     *     tags={"Comments"},
     *     summary="Retrieve all pending comments",
     *     description="Fetches a list of all comments that are currently in a pending state, formatted for display.",
     *     operationId="getPendingComments",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Response(
     *         response=200,
     *         description="A list of pending comments",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="comments",
     *                 type="array",
     *                 description="An array of formatted comments",
     *                 @OA\Items(ref="#/components/schemas/FormattedComment")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Unauthorized - User must be logged in and have the appropriate privileges (e.g., moderator)",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Unauthorized - User must be logged in and have the appropriate privileges")
     *         )
     *     )
     * )
     */
    public function pending()
    {
        $comments = Comment::where('id_status', self::PENDING)
            ->where(function ($query) {
                $query->whereNull('id_parent')
                ->orWhereIn('id_parent', function ($query) {
                    $query->select('id_comment')
                        ->from('comments')
                        ->where('id_status', self::ACCEPTED);
                });
            })
            ->get();

        return response()->json(['comments' => $comments->map(fn($comment) => $this->formatComment($comment))]);
    }

    /**
     * @OA\Get(
     *     path="/comment/accepted",
     *     tags={"Comments"},
     *     summary="Retrieve all accepted comments",
     *     description="Fetches a list of all comments that are currently in an accepted state, formatted for display.",
     *     operationId="getAcceptedComments",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Response(
     *         response=200,
     *         description="A list of accepted comments",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="comments",
     *                 type="array",
     *                 description="An array of formatted comments",
     *                 @OA\Items(ref="#/components/schemas/FormattedComment")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Unauthorized - User must be logged in and have the appropriate privileges (e.g., moderator)",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Unauthorized - User must be logged in and have the appropriate privileges")
     *         )
     *     )
     * )
     */
    public function accepted()
    {
        $comments = Comment::where('id_status', self::ACCEPTED)->get();
        return response()->json(['comments' => $comments->map(fn($comment) => self::formatComment($comment))]);
    }

    /**
     * @OA\Get(
     *     path="/comment/rejected",
     *     tags={"Comments"},
     *     summary="Retrieve all rejected comments",
     *     description="Fetches a list of all comments that are currently in a rejected state, formatted for display.",
     *     operationId="getRejectedComments",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Response(
     *         response=200,
     *         description="A list of rejected comments",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="comments",
     *                 type="array",
     *                 description="An array of formatted comments",
     *                 @OA\Items(ref="#/components/schemas/FormattedComment")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Unauthorized - User must be logged in and have the appropriate privileges (e.g., moderator)",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Unauthorized - User must be logged in and have the appropriate privileges")
     *         )
     *     )
     * )
     */
    public function rejected()
    {
        $comments = Comment::where('id_status', self::REJECTED)->get();
        return response()->json(['comments' => $comments->map(fn($comment) => self::formatComment($comment))]);
    }

    /**
     * @OA\Get(
     *     path="/stats/comments",
     *     tags={"Statistics"},
     *     summary="Retrieve statistics about comments",
     *     description="Fetches statistics about comments, including the total number of comments, the number of comments that are pending, accepted, and rejected, and the number of comments posted in the last week.",
     *     operationId="getCommentsStats",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Response(
     *         response=200,
     *         description="Statistics about comments",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="comments", type="object",
     *                 @OA\Property(property="total", type="integer", description="The total number of comments"),
     *                 @OA\Property(property="pending", type="integer", description="The number of comments that are pending"),
     *                 @OA\Property(property="accepted", type="integer", description="The number of comments that are accepted"),
     *                 @OA\Property(property="rejected", type="integer", description="The number of comments that are rejected"),
     *                 @OA\Property(property="lastWeek", type="integer", description="The number of comments posted in the last week")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Unauthorized - User must be logged in and have the appropriate privileges (e.g., moderator)",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Unauthorized - User must be logged in and have the appropriate privileges")
     *         )
     *     )
     * )
     */
    public function getCommentsStats(){
        $comments = Comment::all();
        $commentsStats = [
            'total' => $comments->count(),
            'pending' => $comments->where('id_status', self::PENDING)->count(),
            'accepted' => $comments->where('id_status', self::ACCEPTED)->count(),
            'rejected' => $comments->where('id_status', self::REJECTED)->count(),
            'lastWeek' => $comments->where('created_at', '>=', Carbon::now()->subWeek())->count(),
        ];

        return response()->json(['comments' => $commentsStats], 200);
    }

}
