<?php

namespace App\Traits;

trait FieldMappingTrait {
    protected function getFieldMapping() {
        return [
            'firstName' => 'first_name',
            'lastName' => 'last_name',
            'email' => 'email',
            'id' => 'id_user',
            'isEmailVerified' => 'is_verified',
            'imgURL' => 'path_picture',
            'createdAt' => 'created_at',
            'updatedAt' => 'updated_at',
            'role' => 'role.name',
            'country' => 'country.name',
            'countryCode' => 'country.country_code',
            'city' => 'city.name',
            'postalCode' => 'postalCode.postal_code',
        ];
    }
}

