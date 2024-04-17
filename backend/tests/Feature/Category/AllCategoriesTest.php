<?php
namespace Tests\Feature\Category;

use App\Models\Category;
use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class AllCategoriesTest extends TestCase
{
    use DatabaseTransactions;

    public function setUp(): void
    {
        parent::setUp();
        $this->adminUser = User::create([
            'email' => 'admin@example.com',
            'first_name' => 'Admin',
            'last_name' => 'User',
            'password' => bcrypt('password'),
            'id_role' => 2,
            'is_verified' => true
        ]);
    }

    public function testAllCategoriesFetchSuccess()
    {
        $token = auth()->login($this->adminUser);
        $headers = ['Authorization' => "Bearer $token"];

        Category::create([
            'title' => 'Category One',
            'description' => 'Description One',
            'icon' => 'icon-one',
            'color' => '#123456',
            'is_active' => true,
            'created_by' => $this->adminUser->id_user
        ]);

        Category::create([
            'title' => 'Category Two',
            'description' => 'Description Two',
            'icon' => 'icon-two',
            'color' => '#654321',
            'is_active' => false,
            'created_by' => $this->adminUser->id_user
        ]);

        $response = $this->withHeaders($headers)->getJson('/api/allCategories');

        $response->assertStatus(200);
        $response->assertJsonStructure([
            'categories' => [
                '*' => ['id', 'title', 'description', 'icon', 'color', 'isActive', 'createdBy']
            ]
        ]);
    }

    public function testAllCategoriesAccessDeniedForNonAdmins()
    {
        $nonAdminUser = User::create([
            'email' => 'user@example.com',
            'first_name' => 'Regular',
            'last_name' => 'User',
            'password' => bcrypt('password'),
            'id_role' => 4,
            'is_verified' => true
        ]);
        $token = auth()->login($nonAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->getJson('/api/allCategories');

        $response->assertStatus(403);
    }
}
