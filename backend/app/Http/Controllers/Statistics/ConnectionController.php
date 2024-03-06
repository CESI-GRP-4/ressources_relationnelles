<?php

namespace App\Http\Controllers\Statistics;

use App\Http\Controllers\Controller;
use App\Models\LoginLog;
use Illuminate\Http\Request;

class ConnectionController extends Controller {

    /**
     * @OA\Get(
     *     path="/stats/connections",
     *     tags={"Statistics"},
     *     summary="Get connection statistics",
     *     description="Fetches connection statistics within a given date range. The end date is adjusted to the current date if it's set in the future.",
     *     operationId="getConnections",
     *     @OA\Parameter(
     *         name="startDate",
     *         in="query",
     *         required=true,
     *         description="Start date for fetching connection statistics (inclusive)",
     *         @OA\Schema(
     *             type="string",
     *             format="date",
     *             example="2023-01-01"
     *         )
     *     ),
     *     @OA\Parameter(
     *         name="endDate",
     *         in="query",
     *         required=true,
     *         description="End date for fetching connection statistics (inclusive). Adjusted to current date if set in the future.",
     *         @OA\Schema(
     *             type="string",
     *             format="date",
     *             example="2023-01-31"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Successful operation",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="connections",
     *                 type="array",
     *                 @OA\Items(
     *                     type="object",
     *                     @OA\Property(property="date", type="string", format="date", example="2023-01-01"),
     *                     @OA\Property(property="numberConnections", type="integer", example=150)
     *                 )
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Validation Error",
     *         @OA\JsonContent(
     *             @OA\Property(property="error", type="string", example="La date de début et la date de fin sont requises.")
     *         )
     *     )
     * )
     */
    public function getConnections(Request $request) {
        $startDate = $request->input('startDate');
        $endDate = $request->input('endDate');

        // If the start date or end date is not provided, return an error
        if (!$startDate || !$endDate) {
            return response()->json(['error' => 'La date de début et la date de fin sont requises.'], 400);
        }

        // If the end date is less than the start date, return an error
        if ($endDate < $startDate) {
            return response()->json(['error' => 'La date de fin doit être supérieure à la date de début.'], 400);
        }

        $nowDate = date('Y-m-d');

        // If the end date is greater than the current date, set the end date to the current date
        if ($endDate > $nowDate) $endDate = $nowDate;

        // Add one day to the end date to include the end day completely
        $endDate = date('Y-m-d', strtotime($endDate . ' +1 day'));

        $connections = LoginLog::whereBetween('login_datetime', [$startDate, $endDate])
            ->selectRaw('DATE(login_datetime) as date, COUNT(*) as numberConnections')
            ->groupBy('date')
            ->orderBy('date')
            ->get();

        return response()->json(['connections' => $connections]);
    }

}
