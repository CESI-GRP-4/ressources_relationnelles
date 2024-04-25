<?php

namespace Tests\Feature\Users;

use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class UsersTest extends TestCase
{
    use DatabaseTransactions;

    protected $adminUser;

    public function setUp(): void
    {
        parent::setUp();
        // Create an admin user as only admins can access the user list
        $this->adminUser = User::create([
            'email' => 'admin@example.com',
            'first_name' => 'Admin',
            'last_name' => 'User',
            'password' => bcrypt('password'),
            'id_role' => 1,  // Assuming 1 is for SuperAdministrateur
            'is_verified' => true,
        ]);
    }

    public function testGetUsersWithPagination()
    {
        $token = auth()->login($this->adminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->getJson('/api/users?perPage=5&page=1');

        $response->assertStatus(200);
        $response->assertJsonStructure([
            'users' => [],
            'totalUsers',
            'perPage',
            'currentPage',
            'lastPage'
        ]);
    }

    public function testGetUsersWithSorting()
    {
        $token = auth()->login($this->adminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->getJson('/api/users?sortBy=firstName&sortDirection=asc');

        $response->assertStatus(200);
        $response->assertJsonStructure([
            'users' => [],
            'totalUsers',
            'perPage',
            'currentPage',
            'lastPage'
        ]);
    }

    public function testGetUsersWithSearch()
    {
        $token = auth()->login($this->adminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->getJson('/api/users?search=admin');

        $response->assertStatus(200);
        $response->assertJsonStructure([
            'users' => [],
            'totalUsers',
            'perPage',
            'currentPage',
            'lastPage'
        ]);
    }

    public function testGetUsersAccessDeniedForNonAdmins()
    {
        $nonAdminUser = User::create([
            'email' => 'user@example.com',
            'first_name' => 'Regular',
            'last_name' => 'User',
            'password' => bcrypt('userpassword'),
            'id_role' => 4,  // Assuming 4 is for Utilisateur
            'is_verified' => true,
        ]);

        $token = auth()->login($nonAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->getJson('/api/users');

        $response->assertStatus(403);
    }
}
