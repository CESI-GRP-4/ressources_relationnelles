<?php

namespace Tests\Feature\Users;

use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class CreateUserTest extends TestCase
{
    use DatabaseTransactions;

    protected $superAdminUser;

    public function setUp(): void
    {
        parent::setUp();
        // Create a Super Admin user for authentication purposes
        $this->superAdminUser = User::create([
            'email' => 'superadmin@example.com',
            'first_name' => 'Super',
            'last_name' => 'Admin',
            'password' => bcrypt('superadminpassword'),
            'id_role' => 1,  // Assuming 1 is the role ID for Super Administrators
            'is_verified' => true,
        ]);
    }

    public function testCreateUserSuccess()
    {
        $token = auth()->login($this->superAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/user/create', [
            'firstName' => 'New',
            'lastName' => 'User',
            'email' => 'newuser@example.com',
            'role' => 'Utilisateur'  // Assuming 'User' is a valid role name
        ]);

        $response->assertStatus(201);
        $response->assertJson([
            'message' => 'Utilisateur créé avec succès',
            'user' => [
                'email' => 'newuser@example.com',
            ]
        ]);

        // Check only the ID of the user is returned
        $this->assertTrue(isset($response->json('user')['id']));
    }


    public function testCreateUserValidationError()
    {
        $token = auth()->login($this->superAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/user/create', [
            'firstName' => '',
            'lastName' => '',
            'email' => 'bademail',
            'role' => 'NonexistentRole'
        ]);

        $response->assertStatus(422);
        $response->assertJsonStructure([
            'message',
            'errors' => [
                'firstName',
                'lastName',
                'email',
                'role'
            ]
        ]);
    }

    public function testCreateUserAccessDeniedForNonAdmins()
    {
        $nonAdminUser = User::create([
            'email' => 'user@example.com',
            'first_name' => 'Regular',
            'last_name' => 'User',
            'password' => bcrypt('userpassword'),
            'id_role' => 4,  // Assuming 4 is for regular users
            'is_verified' => true,
        ]);

        $token = auth()->login($nonAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/user/create', [
            'firstName' => 'New',
            'lastName' => 'User',
            'email' => 'newuser@example.com',
            'role' => 'User'
        ]);

        $response->assertStatus(403);
        $response->assertJson(['error' => "Vous n'êtes pas autorisé à accéder à cette route."]);
    }
}
