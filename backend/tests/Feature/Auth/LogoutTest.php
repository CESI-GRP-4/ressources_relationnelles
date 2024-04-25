<?php

namespace Tests\Feature\Auth;

use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class LogoutTest extends TestCase
{
    use DatabaseTransactions;

    public function testSuccessfulLogout() {
        $user = User::create([
            'email' => 'user@example.com',
            'password' => bcrypt('password'),
            'first_name' => 'John',
            'last_name' => 'Doe',
            'id_role' => 4,
        ]);

        $token = auth()->login($user);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/logout');

        $response->assertStatus(200);
        $response->assertCookieExpired('token');
    }

    public function testLogoutWithInvalidToken()
    {
        $headers = ['Authorization' => "Bearer invalid_token"];
        $response = $this->withHeaders($headers)->postJson('/api/logout');

        $response->assertStatus(401);
        $response->assertJson(['message' => "Wrong number of segments"]);
    }
}
