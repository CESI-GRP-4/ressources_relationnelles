<?php

namespace Tests\Feature\Users;

use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class EditUserTest extends TestCase
{
    use DatabaseTransactions;

    protected $superAdminUser;
    protected $regularUser;

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

        // Create a regular user for testing updates
        $this->regularUser = User::create([
            'email' => 'regular@example.com',
            'first_name' => 'Regular',
            'last_name' => 'User',
            'password' => bcrypt('regularpassword'),
            'id_role' => 4,  // Assuming 4 is the role ID for regular users
            'is_verified' => true,
        ]);
    }

    public function testEditUserSuccess()
    {
        $token = auth()->login($this->superAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/user/edit/' . $this->regularUser->id_user, [
            'firstName' => 'Updated',
            'lastName' => 'User',
            'email' => 'updateduser@example.com'
        ]);

        $response->assertStatus(200);
        $response->assertJson([
            'message' => 'Utilisateur mis à jour avec succès',
            'user' => [
                'email' => 'updateduser@example.com',
                'firstName' => 'Updated',
                'lastName' => 'User'
            ]
        ]);
    }

    public function testEditUserAccessDeniedForNonSuperAdmins()
    {
        $token = auth()->login($this->regularUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/user/edit/' . $this->regularUser->id_user, [
            'firstName' => 'Updated',
            'lastName' => 'User',
            'email' => 'updateduser@example.com',
            'role' => 'Admin'
        ]);

        $response->assertStatus(403);
        $response->assertJson(['error' => 'Vous n\'êtes pas autorisé à accéder à cette route.']);
    }

    public function testEditUserNotFound()
    {
        $token = auth()->login($this->superAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/user/edit/9999', [
            'firstName' => 'Updated',
            'lastName' => 'User'
        ]);

        $response->assertStatus(500);
        $response->assertJson(['error' => 'Une erreur est survenue lors de la mise à jour de l\'utilisateur.']);
    }

    public function testEditUserValidationError()
    {
        $token = auth()->login($this->superAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/user/edit/' . $this->regularUser->id_user, [
            'email' => 'notanemail'  // Clearly invalid email format
        ]);

        $response->assertStatus(400);
    }
}
