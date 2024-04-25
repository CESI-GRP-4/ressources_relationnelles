<?php

namespace Tests\Feature\Category;

use App\Models\Category;
use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;
class EditCategoryTest extends TestCase
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
            'title' => 'Original Category',
            'description' => 'Original description',
            'icon' => 'original-icon',
            'color' => '#123456',
            'is_active' => true,
            'created_by' => $this->adminUser->id_user
        ]);
    }

    public function testCategoryEditSuccess()
    {
        $token = auth()->login($this->adminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/category/edit/' . $this->category->id_category, [
            'title' => 'Updated Category',
            'description' => 'Updated description',
            'icon' => 'updated-icon',
            'color' => '#654321',
            'isActive' => false
        ]);

        $response->assertStatus(200);
        $response->assertJsonStructure(['category' => ['id', 'title', 'description', 'icon', 'color', 'isActive']]);
    }

    public function testCategoryEditWithoutAdminRights()
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

        $response = $this->withHeaders($headers)->postJson('/api/category/edit/' . $this->category->id_category, [
            'title' => 'Updated Category',
            'description' => 'Updated description',
            'icon' => 'updated-icon',
            'color' => '#654321',
            'isActive' => false
        ]);

        $response->assertStatus(403);
    }

    public function testCategoryEditValidationError()
    {
        $token = auth()->login($this->adminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/category/edit/' . $this->category->id_category, [
            'title' => '',
            'color' => 'abc',
            'isActive' => 'not_boolean'
        ]);

        $response->assertStatus(422);
        $response->assertJsonStructure(['message', 'errors']);
    }

    public function testCategoryEditNotFound()
    {
        $token = auth()->login($this->adminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/category/edit/999999', [
            'title' => 'Updated Category',
            'description' => 'Updated description',
            'icon' => 'updated-icon',
            'color' => '#654321',
            'isActive' => false
        ]);

        $response->assertStatus(404);
        $response->assertJson(['message' => 'Catégorie non trouvée']);
    }
}
