<?php

namespace Tests\Feature\Auth;

use App\Models\User;
use App\Notifications\ResetPass;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Illuminate\Support\Str;
use Tests\TestCase;

class ForgotPasswordTest extends TestCase {
    use DatabaseTransactions;

    public function testForgotPasswordEmailSent() {
        $user = User::create([
            'email' => 'existing@example.com',
            'password' => bcrypt('password'),
            'first_name' => 'John',
            'last_name' => 'Doe',
            'id_role' => 4,
            'password_reset_token' => null
        ]);

        $response = $this->postJson('/api/forgot-password/send-mail', [
            'email' => 'existing@example.com'
        ]);

        $response->assertStatus(200);
        $response->assertJson(['message' => 'Un email de réinitialisation de mot de passe a été envoyé.']);

        $user = $user->fresh();
        $this->assertNotNull($user->password_reset_token);
    }

    public function forgotPassword() {
        $data = request()->validate([
            'email' => 'required|email',
        ]);

        $user = User::where('email', $data['email'])->first();

        if ($user) {
            $token = Str::random(100);
            $user->password_reset_token = $token;
            $user->save();

            $user->notify(new ResetPass());
        }

        return response()->json(['message' => 'Un email de réinitialisation de mot de passe a été envoyé.'], 200);
    }
}
