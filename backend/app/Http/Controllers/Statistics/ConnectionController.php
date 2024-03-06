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
     *     tags={"Stats"},
     *     summary="Get connection statistics",
     *     description="Fetches connection counts for a given date range along with the day having the highest average connections.",
     *     operationId="getConnections",
     *     security={{ "BearerAuth": {} }},
     *     @OA\Parameter(
     *         name="startDate",
     *         in="query",
     *         required=true,
     *         description="Start date for fetching connections (format: DD-MM-YYYY)",
     *         @OA\Schema(type="string", format="date")
     *     ),
     *     @OA\Parameter(
     *         name="endDate",
     *         in="query",
     *         required=true,
     *         description="End date for fetching connections (format: DD-MM-YYYY)",
     *         @OA\Schema(type="string", format="date")
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
     *                     @OA\Property(property="date", type="string", example="06-03-2024"),
     *                     @OA\Property(property="numberConnections", type="integer", example=2)
     *                 )
     *             ),
     *             @OA\Property(
     *                 property="average",
     *                 type="object",
     *                 @OA\Property(property="day", type="string", example="mercredi"),
     *                 @OA\Property(property="value", type="string", example="2,0")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=422,
     *         description="Validation error",
     *         @OA\JsonContent(
     *             @OA\Property(property="errors", type="object")
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

        $connections = $this->findConnections($request);
        $average = $this->findMaxDailyAverage($connections);

        return response()->json([
            'connections' => $connections,
            'average' => $average
        ]);
    }

    public function findConnections(Request $request){

        // Convert the dates to the correct format DD-MM-YYYY to YYYY-MM-DD
        // Add one day to the end date to include the end day completely
        $startDate = Carbon::createFromFormat('d-m-Y', $request->input('startDate'))->startOfDay();
        $endDateInput  = Carbon::createFromFormat('d-m-Y', $request->input('endDate'))->addDay()->startOfDay();

        // If the end date is set in the future, adjust it to tomorrow
        $tomorrow = Carbon::tomorrow()->startOfDay();
        $endDate = ($endDateInput > $tomorrow) ? $tomorrow : $endDateInput;


        $interval = new DateInterval('P1D');
        $period = new DatePeriod($startDate, $interval, $endDate);

        // Loop through the period and get the number of connections for each day
        // If there are no connections for a day, set the number to 0
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

        return array_values($dates);
    }

    public function findMaxDailyAverage($connections){
        $totals = [];
        $occurrences = [];

        foreach ($connections as $connection) {
            $dayOfWeek = Carbon::createFromFormat('d-m-Y', $connection['date'])->locale('fr')->isoFormat('dddd');
            if (!isset($totals[$dayOfWeek])) {
                $totals[$dayOfWeek] = 0;
                $occurrences[$dayOfWeek] = 0;
            }
            $totals[$dayOfWeek] += $connection['numberConnections'];
            $occurrences[$dayOfWeek]++;
        }

        $averages = [];
        foreach ($totals as $day => $total) {
            $averages[$day] = $total / $occurrences[$day];
        }

        $maxAverage = max($averages);
        $maxDay = array_search($maxAverage, $averages);

        return [
            'day' => $maxDay,
            'value' => number_format($maxAverage, 1, ',', '')
        ];
    }
}
