<?php

namespace Tests\Feature\Users;

use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class DeleteUserTest extends TestCase
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

        // Create a regular user for testing deletion
        $this->regularUser = User::create([
            'email' => 'regular@example.com',
            'first_name' => 'Regular',
            'last_name' => 'User',
            'password' => bcrypt('regularpassword'),
            'id_role' => 4,  // Assuming 4 is the role ID for regular users
            'is_verified' => true,
        ]);
    }

    public function testDeleteUserSuccess()
    {
        $token = auth()->login($this->superAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->deleteJson('/api/user/delete/' . $this->regularUser->id_user);

        $response->assertStatus(200);
        $response->assertJson([
            'message' => 'Utilisateur supprimé avec succés.'
        ]);

        // Ensure the user is marked as deleted (soft delete check)
        $this->assertNotNull(User::find($this->regularUser->id_user)->deleted_at);
    }

    public function testDeleteUserUnauthorized()
    {
        // Using the regular user to attempt to delete another user
        $token = auth()->login($this->regularUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->deleteJson('/api/user/delete/' . $this->superAdminUser->id_user);

        $response->assertStatus(403);
        $response->assertJson([
            'error' => 'Vous n\'êtes pas autorisé à accéder à cette route.'
        ]);
    }

    public function testDeleteUserNotFound()
    {
        $token = auth()->login($this->superAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        // Correct the usage of `$this` instead of `this`
        $response = $this->withHeaders($headers)->deleteJson('/api/user/delete/99999'); // Assuming this ID does not exist

        $response->assertStatus(404);
        $response->assertJson(['message' => 'Utilisateur non trouvé.']);
    }
}
