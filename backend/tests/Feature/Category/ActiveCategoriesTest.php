<?php

namespace Tests\Feature\Category;

use App\Models\Category;
use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class ActiveCategoriesTest extends TestCase
{
    use DatabaseTransactions;

    public function setUp(): void
    {
        parent::setUp();
        $adminUser = User::create([
            'email' => 'admin@example.com',
            'first_name' => 'Admin',
            'last_name' => 'User',
            'password' => bcrypt('password'),
            'id_role' => 1,
            'is_verified' => true
        ]);

        Category::create([
            'title' => 'Active Category 1',
            'description' => 'Active description 1',
            'icon' => 'icon-one',
            'color' => '#123456',
            'is_active' => true,
            'created_by' => $adminUser->id_user
        ]);

        Category::create([
            'title' => 'Inactive Category',
            'description' => 'Inactive description',
            'icon' => 'icon-two',
            'color' => '#654321',
            'is_active' => false,
            'created_by' => $adminUser->id_user
        ]);

        Category::create([
            'title' => 'Active Category 2',
            'description' => 'Active description 2',
            'icon' => 'icon-three',
            'color' => '#abcdef',
            'is_active' => true,
            'created_by' => $adminUser->id_user
        ]);
    }

    public function testFetchActiveCategories()
    {
        $response = $this->getJson('/api/categories');

        $response->assertStatus(200);
        $response->assertJsonStructure([
            'categories' => [
                '*' => [
                    'id', 'title', 'description', 'icon', 'color', 'createdAt', 'updatedAt', 'isActive', 'createdBy'
                ]
            ]
        ]);

        $categories = $response->json('categories');
        foreach ($categories as $category) {
            $this->assertTrue($category['isActive']);
        }
    }
}
