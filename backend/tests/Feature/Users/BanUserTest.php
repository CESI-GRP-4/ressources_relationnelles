<?php

namespace Tests\Feature\Category;

use App\Models\User;
use Carbon\Carbon;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;


class BanUserTest extends TestCase
{
    use DatabaseTransactions;

    protected $superAdminUser;
    protected $adminUser;
    protected $regularUser;

    public function setUp(): void
    {
        parent::setUp();
        // Create users for testing purposes
        $this->superAdminUser = User::create([
            'email' => 'superadmin@example.com',
            'first_name' => 'Super',
            'last_name' => 'Admin',
            'password' => bcrypt('superadminpassword'),
            'id_role' => 1,  // Assuming 1 is the role ID for Super Administrators
            'is_verified' => true,
        ]);

        $this->adminUser = User::create([
            'email' => 'admin@example.com',
            'first_name' => 'Admin',
            'last_name' => 'User',
            'password' => bcrypt('adminpassword'),
            'id_role' => 2,  // Assuming 2 is the role ID for Administrators
            'is_verified' => true,
        ]);

        $this->regularUser = User::create([
            'email' => 'regular@example.com',
            'first_name' => 'Regular',
            'last_name' => 'User',
            'password' => bcrypt('regularpassword'),
            'id_role' => 4,  // Assuming 4 is the role ID for regular users
            'is_verified' => true,
        ]);
    }

    public function testBanUserSuccess()
    {
        $token = auth()->login($this->superAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/user/ban/' . $this->regularUser->id_user, [
            'isPermanent' => true
        ]);

        $response->assertStatus(200);
        $response->assertJson([
            'message' => 'L\'utilisateur a été banni.'
        ]);
    }

    public function testBanAdminUnauthorized()
    {
        $token = auth()->login($this->superAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/user/ban/' . $this->adminUser->id_user, [
            'isPermanent' => true
        ]);

        $response->assertStatus(403);
        $response->assertJson([
            'message' => 'Non autorisé'
        ]);
    }

    public function testBanUserNotFound()
    {
        $token = auth()->login($this->superAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/user/ban/99999', [
            'isPermanent' => true
        ]);

        $response->assertStatus(404);
        $response->assertJson(['message' => 'Utilisateur non trouvé']);
    }

    public function testBanUserValidationError()
    {
        $token = auth()->login($this->superAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/user/ban/' . $this->regularUser->id_user, [
            'banTimestamp' => Carbon::now()->subDays(1)->getTimestamp() * 1000 // A past timestamp
        ]);

        $response->assertStatus(422);
        $response->assertJson(['message' => 'La date de fin de bannissement doit être dans le futur.']);
    }
}
