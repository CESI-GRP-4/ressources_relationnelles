<?php

namespace App\Http\Controllers\Statistics;

use App\Http\Controllers\Controller;
use App\Models\LoginLog;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Validator;

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
     *             example="01-01-2023"
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
     *             example="31-01-2023"
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
     *                     @OA\Property(property="date", type="string", format="date", example="01-01-2023"),
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
        $rules = [
            'startDate' => 'required|date_format:d-m-Y',
            'endDate' => 'required|date_format:d-m-Y|after_or_equal:startDate',
        ];

        $messages = [
            'startDate.required' => 'La date de début est requise.',
            'startDate.date_format' => 'La date de début doit être au format DD-MM-YYYY.',
            'endDate.required' => 'La date de fin est requise.',
            'endDate.date_format' => 'La date de fin doit être au format DD-MM-YYYY.',
            'endDate.after_or_equal' => 'La date de fin doit être supérieure ou égale à la date de début.',
        ];

        $validator = Validator::make($request->all(), $rules, $messages);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Convert the dates to the correct format DD-MM-YYYY to YYYY-MM-DD
        // Add one day to the end date to include the end day completely
        $startDate = Carbon::createFromFormat('d-m-Y', $request->input('startDate'))->format('Y-m-d');
        $endDate = Carbon::createFromFormat('d-m-Y', $request->input('endDate'))->addDay()->format('Y-m-d');

        $connections = LoginLog::whereBetween('login_datetime', [$startDate, $endDate])
            ->selectRaw('DATE(login_datetime) as date, COUNT(*) as numberConnections')
            ->groupBy('date')
            ->orderBy('date')
            ->get()
            ->map(function ($item) {
                $item->date = Carbon::createFromFormat('Y-m-d', $item->date)->format('d-m-Y');
                return $item;
            });

        return response()->json(['connections' => $connections]);
    }
}
