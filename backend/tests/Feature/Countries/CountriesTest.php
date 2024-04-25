<?php

namespace Tests\Feature\Countries;

use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;

class CountriesTest extends TestCase
{
    use DatabaseTransactions;

    public function testCountriesList()
    {
        $response = $this->getJson('/api/countries');

        $response->assertStatus(200);
        $response->assertJsonStructure(['countries' => [['id', 'name', 'code']]]);
    }
}
