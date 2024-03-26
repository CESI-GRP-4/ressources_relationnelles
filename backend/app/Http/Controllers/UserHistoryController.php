<?php

namespace App\Http\Controllers;

use App\Models\UserHistory;
use App\Traits\FieldMappingTrait;
use App\Utils\Utils;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class UserHistoryController extends Controller {
    use FieldMappingTrait;

    /**
     * @OA\Get(
     *     path="/usershistory",
     *     tags={"Users"},
     *     summary="Fetch users' history",
     *     description="Retrieves a paginated history of actions performed on users, including detailed information about the user modified and the user who performed the modification.",
     *     operationId="getUsersHistory",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="perPage",
     *         in="query",
     *         description="Number of history records per page",
     *         required=false,
     *         @OA\Schema(
     *             type="integer",
     *             default=10
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="page",
     *         in="query",
     *         description="Page number to retrieve",
     *         required=false,
     *         @OA\Schema(
     *             type="integer",
     *             default=1
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Successful operation",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="userHistory",
     *                 type="array",
     *                 @OA\Items(ref="#/components/schemas/UserHistoryRecord")
     *             ),
     *             @OA\Property(property="total", type="integer"),
     *             @OA\Property(property="perPage", type="integer"),
     *             @OA\Property(property="currentPage", type="integer"),
     *             @OA\Property(property="lastPage", type="integer")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Validation Error"
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Not Found"
     *     )
     * )
     */

    public function getUsersHistory(Request $request){

        $validator = Validator::make($request->all(), [
            'perPage' => 'integer|min:1',
            'page' => 'integer|min:1',
        ]);
        if ($validator->fails()) { return response()->json($validator->errors(), 400); }

        $perPage = $request->input('perPage', 10);
        $userHistoryPaginated = UserHistory::with(['user', 'affectedUser'])
            ->orderBy('created_at', 'desc')
            ->paginate($perPage);

        $userHistoryTransformed = $userHistoryPaginated->getCollection()->map(function ($history) {
            $userModifiedData = $history->affectedUser ? Utils::getAllUserData($history->affectedUser) : null;
            $modifiedByData = $history->user ? Utils::getAllUserData($history->user) : null;

            $item = [
                'userModified' => $userModifiedData,
                'modifyBy' => $modifiedByData,
                'action' => $history->action,
                'time' => $history->created_at,
            ];
            $fieldMapping = $this->getReverseFieldMapping();


            if ($history->action === 'Modify' ) {
                $item['colName'] = $fieldMapping[$history->modified_column] ?? $history->modified_column;
                $item['newValue'] = $history->new_value;
                $item['oldValue'] = $history->old_value;
            }

            if ($history->action === 'Ban' ) {
                $item['colName'] = $fieldMapping[$history->modified_column] ?? $history->modified_column;
                $item['newValue'] = $history->new_value;
                if($history->new_value == 253402297199000){
                    $item['newValue'] = 'permanent';
                }
                $item['oldValue'] = $history->old_value;
            }

            return $item;
        });

        $userHistoryPaginated->setCollection($userHistoryTransformed);

        $response = [
            'userHistory' => $userHistoryPaginated->items(),
            'total' => $userHistoryPaginated->total(),
            'perPage' => $userHistoryPaginated->perPage(),
            'currentPage' => $userHistoryPaginated->currentPage(),
            'lastPage' => $userHistoryPaginated->lastPage(),
        ];

        return response()->json($response);
    }

}
