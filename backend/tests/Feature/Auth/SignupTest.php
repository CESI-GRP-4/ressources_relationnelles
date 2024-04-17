<?php

namespace Tests\Feature\Auth;

use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class SignupTest extends TestCase {
    use DatabaseTransactions;

    public function testSignupSuccess() {
        $response = $this->postJson('/api/signup', [
            'email' => 'newuser@example.com',
            'firstName' => 'Jane',
            'lastName' => 'Doe',
            'password' => 'Password@123',
        ]);

        $response->assertStatus(200);
        $response->assertJsonStructure(['user']);
    }

    public function testSignupEmailAlreadyInUse() {
        User::create([
            'email' => 'existinguser@example.com',
            'password' => bcrypt('Password@123'),
            'first_name' => 'John',
            'last_name' => 'Doe',
            'id_role' => 4,
        ]);

        $response = $this->postJson('/api/signup', [
            'email' => 'existinguser@example.com',
            'firstName' => 'John',
            'lastName' => 'Doe',
            'password' => 'Password@123',
        ]);

        $response->assertStatus(401);
        $response->assertJson(['message' => "L'adresse email est déjà utilisée."]);
    }

    public function testSignupEmailAlreadyInUseDeletedAccount() {
        $user = User::create([
            'email' => 'deleteduser@example.com',
            'password' => bcrypt('Password@123'),
            'first_name' => 'John',
            'last_name' => 'Doe',
            'id_role' => 4,
            'deleted_at' => now(),
        ]);

        $response = $this->postJson('/api/signup', [
            'email' => 'deleteduser@example.com',
            'firstName' => 'John',
            'lastName' => 'Doe',
            'password' => 'Password@123',
        ]);

        $response->assertStatus(403);
        $response->assertJson(['message' => "L'adresse email est déjà utilisée par un compte supprimé. Merci de nous contacter."]);
    }
}
