<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;

/**
 * @OA\Info(title="(Re)Sources Relationnelles", version="0.24")
 * @OA\Server(url="http://localhost:80/api")
 */
class Controller extends BaseController
{
    use AuthorizesRequests, ValidatesRequests;
}
