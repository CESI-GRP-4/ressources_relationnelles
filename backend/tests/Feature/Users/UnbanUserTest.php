<?php

namespace Tests\Feature\Users;

use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class UnbanUserTest extends TestCase
{
    use DatabaseTransactions;

    protected $superAdminUser;
    protected $bannedUser;
    protected $unbannedUser;

    public function setUp(): void
    {
        parent::setUp();
        // Create a Super Admin user for authentication purposes
        $this->superAdminUser = User::create([
            'email' => 'superadmin@example.com',
            'first_name' => 'Super',
            'last_name' => 'Admin',
            'password' => bcrypt('superadminpassword'),
            'id_role' => 1,
            'is_verified' => true,
        ]);

        $this->bannedUser = User::create([
            'email' => 'banneduser@example.com',
            'first_name' => 'Banned',
            'last_name' => 'User',
            'password' => bcrypt('bannedpassword'),
            'id_role' => 4,
            'is_verified' => true,
            'ban_until' => now()->addDays(10)->getTimestamp() *1000
        ]);

        // Create an unbanned user for testing error handling
        $this->unbannedUser = User::create([
            'email' => 'unbanneduser@example.com',
            'first_name' => 'Unbanned',
            'last_name' => 'User',
            'password' => bcrypt('unbannedpassword'),
            'id_role' => 4,
            'is_verified' => true,
            'ban_until' => null  // Not banned
        ]);
    }

    public function testUnbanUserSuccess()
    {
        $token = auth()->login($this->superAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->patchJson('/api/user/unban/' . $this->bannedUser->id_user);

        $response->assertStatus(200);
        $response->assertJson([
            'message' => 'L\'utilisateur a été débanni'
        ]);

        // Ensure the user is actually unbanned
        $this->assertNull(User::find($this->bannedUser->id_user)->ban_until);
    }

    public function testUnbanUserNotBanned()
    {
        $token = auth()->login($this->superAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->patchJson('/api/user/unban/' . $this->unbannedUser->id_user);

        $response->assertStatus(404);
        $response->assertJson(['message' => 'L\'utilisateur n\'est pas banni']);
    }

    public function testUnbanUserNotFound()
    {
        $token = auth()->login($this->superAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->patchJson('/api/user/unban/99999'); // Assuming this ID does not exist

        $response->assertStatus(404);
        $response->assertJson(['message' => 'Utilisateur non trouvé']);
    }
}
