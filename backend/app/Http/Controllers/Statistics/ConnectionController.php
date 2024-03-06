<?php

namespace App\Http\Controllers\Statistics;

use App\Http\Controllers\Controller;
use App\Models\LoginLog;
use DateInterval;
use DatePeriod;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Validator;

class ConnectionController extends Controller {

    /**
     * @OA\Get(
     *     path="/stats/connections",
     *     tags={"Statistics"},
     *     summary="Get connections statistics",
     *     description="Retrieves the number of connections for each day between the specified start and end dates.",
     *     operationId="getConnections",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="startDate",
     *         in="query",
     *         required=true,
     *         description="Start date for the statistics period in DD-MM-YYYY format.",
     *         @OA\Schema(type="string", format="date", example="01-01-2024")
     *     ),
     *     @OA\Parameter(
     *         name="endDate",
     *         in="query",
     *         required=true,
     *         description="End date for the statistics period in DD-MM-YYYY format, must be after or equal to the start date.",
     *         @OA\Schema(type="string", format="date", example="31-01-2024")
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
     *                     @OA\Property(property="date", type="string", description="The date in DD-MM-YYYY format."),
     *                     @OA\Property(property="numberConnections", type="integer", description="The number of connections for the date.")
     *                 )
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=422,
     *         description="Validation error",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="errors",
     *                 type="object",
     *                 additionalProperties={
     *                     @OA\Schema(type="array", @OA\Items(type="string"))
     *                 }
     *             )
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
        $startDate = Carbon::createFromFormat('d-m-Y', $request->input('startDate'))->startOfDay();
        $endDateInput  = Carbon::createFromFormat('d-m-Y', $request->input('endDate'))->addDay()->startOfDay();

        // If the end date is set in the future, adjust it to tomorrow
        $tomorrow = Carbon::tomorrow()->startOfDay();
        $endDate = $endDateInput->gt($tomorrow) ? $tomorrow : $endDateInput->addDay();


        // Create the interval for the period of time between the start and end date (1 day)
        $interval = new DateInterval('P1D');

        // Create the period of time between the start and end date
        $period = new DatePeriod($startDate, $interval, $endDate);

        $dates = [];
        foreach ($period as $date) {
            $dateFormatted = $date->format('Y-m-d');
            $logins = LoginLog::whereBetween('login_datetime', [$startDate, $endDate])
                ->selectRaw('DATE(login_datetime) as date, COUNT(*) as numberConnections')
                ->groupBy('date')
                ->get()
                ->keyBy('date');
            $dates[$dateFormatted] = [
                'date' => $date->format('d-m-Y'),
                'numberConnections' => isset($logins[$dateFormatted]) ? $logins[$dateFormatted]['numberConnections'] : 0,
            ];
        }

        return response()->json(['connections' => array_values($dates)]);
    }
}
