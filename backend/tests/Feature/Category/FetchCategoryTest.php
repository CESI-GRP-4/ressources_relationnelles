<?php

namespace Tests\Feature\Category;

use App\Models\Category;
use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class FetchCategoryTest extends TestCase
{
    use DatabaseTransactions;

    protected $adminUser;
    protected $activeCategory;
    protected $inactiveCategory;

    public function setUp(): void
    {
        parent::setUp();
        $this->adminUser = User::create([
            'email' => 'admin@example.com',
            'first_name' => 'Admin',
            'last_name' => 'User',
            'password' => bcrypt('adminpassword'),
            'id_role' => 1,
            'is_verified' => true,
        ]);

        $this->activeCategory = Category::create([
            'title' => 'Active Category',
            'description' => 'A category that is active.',
            'icon' => 'icon-link',
            'color' => '#123456',
            'is_active' => true,
            'created_by' => $this->adminUser->id_user
        ]);

        $this->inactiveCategory = Category::create([
            'title' => 'Inactive Category',
            'description' => 'A category that is inactive.',
            'icon' => 'icon-link',
            'color' => '#654321',
            'is_active' => false,
            'created_by' => $this->adminUser->id_user
        ]);
    }

    public function testFetchActiveCategory()
    {
        $response = $this->getJson('/api/category/' . $this->activeCategory->id_category);

        $response->assertStatus(200);
        $response->assertJson([
            'category' => [
                'id' => $this->activeCategory->id_category,
                'title' => $this->activeCategory->title,
            ]
        ]);
    }

    public function testFetchInactiveCategory()
    {
        $response = $this->getJson('/api/category/' . $this->inactiveCategory->id_category);

        $response->assertStatus(404);
        $response->assertJson(['message' => 'Catégorie non trouvée']);
    }

    public function testFetchNonExistentCategory()
    {
        $response = $this->getJson('/api/category/9999');

        $response->assertStatus(404);
        $response->assertJson(['message' => 'Catégorie non trouvée']);
    }
}
