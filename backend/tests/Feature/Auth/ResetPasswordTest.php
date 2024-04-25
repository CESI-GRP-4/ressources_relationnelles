<?php

namespace Tests\Feature\Auth;

use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class ResetPasswordTest extends TestCase {
    use DatabaseTransactions;

    public function testPasswordResetSuccess(){
        $user = User::create([
            'email' => 'reset@example.com',
            'password' => bcrypt('oldpassword'),
            'first_name' => 'John',
            'last_name' => 'Doe',
            'id_role' => 4,
            'password_reset_token' => 'valid_token'
        ]);

        $response = $this->postJson('/api/forgot-password/reset', [
            'token' => 'valid_token',
            'password' => 'newpassword123',
            'verifyPassword' => 'newpassword123'
        ]);

        $response->assertStatus(200);
        $response->assertJson(['message' => 'Mot de passe réinitialisé avec succès']);

        $user = $user->fresh();
        $this->assertTrue(Hash::check('newpassword123', $user->password));
        $this->assertNull($user->password_reset_token);
    }

    public function testPasswordMismatch()
    {
        $response = $this->postJson('/api/forgot-password/reset', [
            'token' => 'any_token',
            'password' => 'newpassword123',
            'verifyPassword' => 'differentpassword123'
        ]);

        $response->assertStatus(403);
        $response->assertJson(['message' => 'Les mots de passe ne correspondent pas']);
    }

    public function testInvalidResetToken()
    {
        $response = $this->postJson('/api/forgot-password/reset', [
            'token' => 'invalid_token',
            'password' => 'newpassword123',
            'verifyPassword' => 'newpassword123'
        ]);

        $response->assertStatus(403);
        $response->assertJson(['message' => 'Token de réinitialisation invalide']);
    }
}
