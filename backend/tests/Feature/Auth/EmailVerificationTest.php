<?php

namespace Tests\Feature\Auth;

use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class EmailVerificationTest extends TestCase {
    use DatabaseTransactions;

    public function testEmailVerificationSuccess() {
        $user = User::create([
            'email' => 'verify@example.com',
            'password' => bcrypt('password'),
            'first_name' => 'Verify',
            'last_name' => 'User',
            'id_role' => 4,
            'is_verified' => false,
            'verification_token' => 'valid_verification_token'
        ]);

        $response = $this->postJson('/api/email/verify', [
            'token' => 'valid_verification_token'
        ]);

        $response->assertStatus(200);
        $response->assertJson(['message' => 'Email vérifié avec succès']);

        $user = $user->fresh();
        $this->assertTrue($user->is_verified);
        $this->assertNull($user->verification_token);
    }

    public function testEmailVerificationWithInvalidToken() {
        $response = $this->postJson('/api/email/verify', [
            'token' => 'invalid_verification_token'
        ]);

        $response->assertStatus(403);
        $response->assertJson(['message' => 'Token de vérification invalide']);
    }
}
