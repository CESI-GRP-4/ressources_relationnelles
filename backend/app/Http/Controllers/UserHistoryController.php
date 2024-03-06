<?php

namespace App\Http\Controllers;

use App\Models\UserHistory;
use App\Utils\Utils;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class UserHistoryController extends Controller {

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

            if ($history->action === 'Modify') {
                $item['colName'] = $history->modified_column;
                $item['newValue'] = $history->new_value;
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
