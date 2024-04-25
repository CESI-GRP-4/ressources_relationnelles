<?php

namespace Tests\Feature\Category;

use App\Models\Category;
use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;
class DeleteCategoryTest extends TestCase
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
            'id_role' => 1,
            'is_verified' => true
        ]);

        $this->category = Category::create([
            'title' => 'Delete Category',
            'description' => 'Category to be deleted',
            'icon' => 'delete-icon',
            'color' => '#123456',
            'is_active' => true,
            'created_by' => $this->adminUser->id_user
        ]);
    }

    public function testCategoryDeleteSuccess() {
        $token = auth()->login($this->adminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->deleteJson('/api/category/delete/' . $this->category->id_category);

        $response->assertStatus(200);
        $response->assertJson(['message' => 'Catégorie supprimée']);

        $this->assertDatabaseMissing('categories', ['id_category' => $this->category->id_category]);
    }

    public function testCategoryDeleteWithoutAdminRights()  {
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

        $response = $this->withHeaders($headers)->deleteJson('/api/category/delete/' . $this->category->id_category);

        $response->assertStatus(403);
    }

    public function testCategoryNotFound()
    {
        $token = auth()->login($this->adminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->deleteJson('/api/category/delete/999999'); // Assuming this ID does not exist

        $response->assertStatus(404);
        $response->assertJson(['message' => 'Catégorie non trouvée']);
    }
}
