<?php

namespace Tests\Feature\Category;

use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class CreateCategoryTest extends TestCase
{
    use DatabaseTransactions;

    public function setUp(): void
    {
        parent::setUp();
        $this->adminUser = User::create([
            'email' => 'admin@example.com',
            'password' => bcrypt('password'),
            'first_name' => 'John',
            'last_name' => 'Doe',
            'id_role' => 1,
            'is_verified' => true
        ]);
    }

    public function testCategoryCreationSuccess()
    {
        $token = auth()->login($this->adminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/category/create', [
            'title' => 'New Category',
            'description' => 'Detailed description of new category',
            'icon' => 'icon-link',
            'color' => '#abcdef',
            'isActive' => true
        ]);

        $response->assertStatus(201);
        $response->assertJsonStructure(['category' => ['id', 'title', 'description', 'icon', 'color']]);
    }

    public function testCategoryCreationWithoutAdminRights()
    {
        $nonAdminUser = User::create([
            'email' => 'user@example.com',
            'password' => bcrypt('password'),
            'first_name' => 'Jane',
            'last_name' => 'Doe',
            'id_role' => 4,
            'is_verified' => true
        ]);
        $token = auth()->login($nonAdminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/category/create', [
            'title' => 'New Category',
            'description' => 'Detailed description of new category',
            'icon' => 'icon-link',
            'color' => '#abcdef',
            'isActive' => true
        ]);

        $response->assertStatus(403);
    }

    public function testCategoryCreationValidationError()
    {
        $token = auth()->login($this->adminUser);
        $headers = ['Authorization' => "Bearer $token"];

        $response = $this->withHeaders($headers)->postJson('/api/category/create', [
            'title' => '',  // Title is required
            'description' => 'Detailed description',
            'icon' => 'icon-link',
            'color' => 'abc123',  // Invalid color format
            'isActive' => true
        ]);

        $response->assertStatus(422);
        $response->assertJsonStructure(['message', 'errors']);
    }
}
