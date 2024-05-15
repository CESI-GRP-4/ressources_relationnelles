<?php

namespace App\Utils;

use App\Models\Category;
use App\Models\Comment;
use App\Models\ProfilePicture;
use App\Models\Ressource;
use App\Models\StatusRessource;
use App\Models\User;
use App\Models\UserHistory;

class Utils{

    // USERS

    public static function getUserPublicData($user){
        return [
            'firstName' => $user->first_name,
            'imgURL' => $user->path_picture,
            'id' => $user->id_user,
            'role' => $user->role->name,
        ];
    }

    /**
     * @OA\Schema(
     *     schema="UserData",
     *     type="object",
     *     @OA\Property(property="firstName", type="string", description="User's first name"),
     *     @OA\Property(property="lastName", type="string", description="User's last name"),
     *     @OA\Property(property="email", type="string", format="email", description="User's email address"),
     *     @OA\Property(property="imgURL", type="string", description="URL to the user's profile picture"),
     *     @OA\Property(property="id", type="integer", description="User ID"),
     *     @OA\Property(property="role", type="string", description="User's role name"),
     *     @OA\Property(property="isEmailVerified", type="boolean", description="Indicates if the user's email is verified"),
     *     @OA\Property(property="newUser", type="boolean", description="Indicates if the user is new")
     * )
     */
    public static function getUserData($user){
        return [
            'firstName' => $user->first_name,
            'lastName' => $user->last_name,
            'email' => $user->email,
            'imgURL' => $user->path_picture,
            'id' => $user->id_user,
            'role' => $user->role->name,
        ];
    }

    /**
     * @OA\Schema(
     *     schema="UserDetail",
     *     type="object",
     *     @OA\Property(property="id", type="integer"),
     *     @OA\Property(property="email", type="string"),
     *     @OA\Property(property="firstName", type="string"),
     *     @OA\Property(property="lastName", type="string"),
     *     @OA\Property(property="isEmailVerified", type="boolean"),
     *     @OA\Property(property="imgURL", type="string"),
     *     @OA\Property(property="city", type="string"),
     *     @OA\Property(property="country", type="string"),
     *     @OA\Property(property="countryCode", type="string"),
     *     @OA\Property(property="postalCode", type="string"),
     *     @OA\Property(property="role", type="string"),
     *     @OA\Property(property="createdAt", type="string", format="date-time"),
     *     @OA\Property(property="updatedAt", type="string", format="date-time"),
     *     @OA\Property(property="isBanned", type="boolean"),
     *     @OA\Property(property="newUser", type="boolean")
     * )
     */
    public static function getAllUserData($user){
        // set false if not set
        $isNewUser = session('isNewUser', false);

        $isBanned = $user->ban_until ? (floor($user->ban_until / 1000) > time()) : false;

        $userData = [
            'id' => $user->id_user,
            'email' => $user->email,
            'firstName' => $user->first_name,
            'lastName' => $user->last_name,
            'isEmailVerified' => $user->is_verified,
            'imgURL' => $user->path_picture,
            'role' => $user->role->name,
            'createdAt' => $user->created_at,
            'updatedAt' => $user->updated_at,
            'isBanned' => $isBanned,
            'newUser' => $isNewUser,
        ];

        if ($user->country) {
            $userData['country'] = $user->country->name;
            $userData['countryCode'] = $user->country->country_code;
        }

        if ($user->postalCode) {
            $userData['postalCode'] = $user->postalCode->postal_code;
        }

        if ($user->city) {
            $userData['city'] = $user->city->name;
        }

        return $userData;
    }

    public static function addUserHistoryEntry($authUserId, $affectedUserId, $action, $columnName=null, $oldValue=null, $newValue=null) {
        UserHistory::create([
            'user_id' => $authUserId,
            'affected_user_id' => $affectedUserId,
            'action' => $action,
            'modified_column' => $columnName,
            'old_value' => $oldValue,
            'new_value' => $newValue,
        ]);
    }

    // CATEGORIES
    /**
     * @OA\Schema(
     *     schema="CategoryData",
     *     type="object",
     *     description="Information about a category",
     *     @OA\Property(property="id", type="integer", description="Category ID"),
     *     @OA\Property(property="title", type="string", description="Title of the category"),
     *     @OA\Property(property="description", type="string", description="Description of the category"),
     *     @OA\Property(property="icon", type="string", description="Icon representing the category"),
     *     @OA\Property(property="color", type="string", description="Color associated with the category. Hexadecimal format with '#': #000000"),
     *     @OA\Property(property="createdAt", type="string", format="date-time", description="Creation date of the category"),
     *     @OA\Property(property="updatedAt", type="string", format="date-time", description="Last update date of the category"),
     * )
     */
    public static function getCategoryData($category) {
        return [
            'id' => $category->id_category,
            'title' => $category->title,
            'description' => $category->description,
            'icon' => $category->icon,
            'color' => $category->color,
            'createdAt' => $category->created_at->toDateTimeString(),
            'updatedAt' => $category->updated_at->toDateTimeString(),
        ];
    }

    /**
     * @OA\Schema(
     *     schema="CategoryDetail",
     *     type="object",
     *     description="Detailed information about a category",
     *     @OA\Property(property="id", type="integer", description="Category ID"),
     *     @OA\Property(property="title", type="string", description="Title of the category"),
     *     @OA\Property(property="description", type="string", description="Description of the category"),
     *     @OA\Property(property="icon", type="string", description="Icon representing the category"),
     *     @OA\Property(property="color", type="string", description="Color associated with the category. Hexadecimal format with '#': #000000"),
     *     @OA\Property(property="createdAt", type="string", format="date-time", description="Creation date of the category"),
     *     @OA\Property(property="updatedAt", type="string", format="date-time", description="Last update date of the category"),
     *     @OA\Property(property="isActive", type="boolean", description="Whether the category is active. Visible to admins only."),
     *     @OA\Property(
     *          property="createdBy",
     *          type="object",
     *          description="User details of the creator. Visible to admins only.",
     *          ref="#/components/schemas/UserDetail"
     *      ),
     * )
     */
    public static function getCategoryDetail($category) {
        $user = User::find($category->created_by);
        return [
            'id' => $category->id_category,
            'title' => $category->title,
            'description' => $category->description,
            'icon' => $category->icon,
            'color' => $category->color,
            'createdAt' => $category->created_at->toDateTimeString(),
            'updatedAt' => $category->updated_at->toDateTimeString(),
            'isActive' => $category->is_active,
            'createdBy' => self::getAllUserData($user),
        ];
    }

    /**
     * @OA\Schema(
     *     schema="CategoryDetailWithRessources",
     *     type="object",
     *     description="Detailed information about a category, including its associated resources",
     *     allOf={
     *         @OA\Schema(ref="#/components/schemas/CategoryDetail"),
     *         @OA\Schema(
     *             @OA\Property(
     *                 property="ressources",
     *                 type="array",
     *                 description="An array of resources associated with the category",
     *                 @OA\Items(ref="#/components/schemas/RessourceDetail")
     *             )
     *         )
     *     }
     * )
     */
    public static function getCategoryDetailWithRessources($category) {
        $categoryData = self::getCategoryData($category);
        $ressources = Ressource::where('id_category', $category->id_category)
            ->where('id_status', 1)
            ->where('is_public', 1)
            ->get();
        $categoryData['ressources'] = $ressources->map(function ($ressource) {
            return self::getRessourceDetail($ressource);
        });
        return $categoryData;
    }

    // RESOURCES
    /**
     * @OA\Schema(
     *     schema="RessourceDetail",
     *     type="object",
     *     description="Detailed information about a resource",
     *     @OA\Property(property="id", type="integer", description="The unique identifier of the resource"),
     *     @OA\Property(property="label", type="string", description="The label or title of the resource"),
     *     @OA\Property(property="description", type="string", description="The detailed description of the resource"),
     *     @OA\Property(property="isPublic", type="boolean", description="Indicates if the resource is public"),
     *     @OA\Property(property="status", type="string", description="The status of the resource"),
     *     @OA\Property(
     *         property="category",
     *         type="object",
     *         description="Details about the category this resource belongs to",
     *         ref="#/components/schemas/CategoryData"
     *     ),
     *     @OA\Property(property="viewCount", type="integer", description="Number of views this resource has received"),
     *     @OA\Property(
     *         property="user",
     *         type="object",
     *         description="Details about the user who created this resource",
     *         ref="#/components/schemas/UserData"
     *     ),
     *     @OA\Property(property="creationDate", type="string", format="date-time", description="The date and time when the resource was created"),
     *     @OA\Property(property="lastModificationDate", type="string", format="date-time", description="The date and time when the resource was last updated"),
     *     @OA\Property(property="staffComment", type="string", description="Staff comments on the resource, if any"),
     *     @OA\Property(property="isFavorite", type="boolean", description="Indicates whether the resource is marked as a favorite by the current user"),
     *     @OA\Property(property="isBookmark", type="boolean", description="Indicates whether the resource is bookmarked by the current user"),
     *     @OA\Property(
     *         property="comments",
     *         type="array",
     *         description="List of comments associated with the resource",
     *         @OA\Items(ref="#/components/schemas/CommentData")
     *     )
     * )
     */
    public static function getRessourceDetail($ressource){
        $category = Category::find($ressource->id_category);
        $user = User::find($ressource->id_user);
        if(auth()->user() AND auth()->user()->role_id == 4){
            $user = self::getUserPublicData($user);
        }else{
            $user = self::getUserData($user);
        }
        $status = StatusRessource::find($ressource->id_status);
        return [
            'id' => $ressource->id_ressource,
            'label' => $ressource->label,
            'description' => $ressource->description,
            'isPublic' => $ressource->is_public,
            'status' => $status->label,
            'category' => self::getCategoryData($category),
            'viewCount' => $ressource->view_count,
            'user' => $user,
            'creationDate' => $ressource->created_at,
            'lastModificationDate' => $ressource->updated_at,
            'staffComment' => $ressource->staff_comment,
            'comments' => self::getCommentCascade($ressource->id_ressource),
            'isFavorite' => self::isFavorite($ressource->id_ressource),
            'isBookmark' => self::isBookmark($ressource->id_ressource),
        ];
    }

    public static function mapRessourcesToDetails($ressources){
        return $ressources->map(function ($ressource) {
            return self::getRessourceDetail($ressource);
        });
    }
    public static function mapCategoriesToDetails($categories){
        return $categories->map(function ($category) {
            return self::getCategoryDetail($category);
        });
    }


    public static function getRandomProfilePicture() {
        $profilePictures = ProfilePicture::all();
        $randomIndex = rand(0, count($profilePictures) - 1);
        return $profilePictures[$randomIndex];
    }

    private static function isFavorite($ressource){
        $user = auth()->user();
        if ($user) {
            return $user->favorites->contains($ressource);
        }
        return false;
    }

    private static function isBookmark($ressource){
        $user = auth()->user();
        if ($user) {
            return $user->bookmarks->contains($ressource);
        }
        return false;
    }

    // COMMENTS
    /**
     * @OA\Schema(
     *     schema="CommentData",
     *     type="object",
     *     @OA\Property(property="id", type="integer", description="Comment ID"),
     *     @OA\Property(property="user", type="object", ref="#/components/schemas/UserData"),
     *     @OA\Property(property="comment", type="string", description="The comment text"),
     *     @OA\Property(property="createAt", type="string", format="date-time", description="The date and time when the comment was created"),
     *     @OA\Property(property="children", type="array", description="An array of child comments", @OA\Items(ref="#/components/schemas/CommentData"))
     * )
     */
    public static function formatComment($comment){
        $user = User::find($comment->id_user);
        if(auth()->user() AND auth()->user()->id_role == 4){
            $user = self::getUserPublicData($user);
        }else{
            $user = self::getUserData($user);
        }
        return [
            'id' => $comment->id_comment,
            'user' => $user,
            'comment' => $comment->comment,
            'createAt' => $comment->created_at,
            'children' => self::getCommentChildren($comment->id_comment),
        ];
    }

    public static function getCommentCascade($ressourceId){
        $rootComments = Comment::whereNull('id_parent')
                        ->where('id_ressource', $ressourceId)
                        ->where('id_status', 1) // accepted
                        ->get();
        return $rootComments->map(function ($comment) {
            return self::formatComment($comment);
        });
    }

    private static function getCommentChildren($parentId) {
        $children = Comment::where('id_parent', $parentId)
            ->where('id_status', 1) // accepted
            ->get();
        return $children->map(function ($child) {
            return self::formatComment($child);
        });
    }
}
