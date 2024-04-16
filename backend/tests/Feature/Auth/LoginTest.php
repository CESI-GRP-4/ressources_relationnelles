<?php

namespace Tests\Feature\Auth;

use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class LoginTest extends TestCase {
    use DatabaseTransactions;

    public function testLoginSuccess(){

        $user = User::create([
            'email' => 'user@example.com',
            'password' => bcrypt('password'),
            'first_name' => 'John',
            'last_name' => 'Doe',
            'id_role' => 4,
            'is_verified' => 0,
            'ban_until' => null,
            'verification_token' => 'token',
            'path_picture' => 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Angel',
        ]);

        $response = $this->postJson('/api/login', [
            'email' => 'user@example.com',
            'password' => 'password',
        ]);

        $response->assertStatus(200);
        $response->assertJsonStructure(['user', 'newUser']);
    }

    public function testLoginFailure()
    {
        $response = $this->postJson('/api/login', [
            'email' => 'wronguser@example.com',
            'password' => 'wrongpassword',
        ]);

        $response->assertStatus(401);
        $response->assertJson(['message' => 'Les informations d\'identification fournies ne sont pas correctes.']);
    }
}
