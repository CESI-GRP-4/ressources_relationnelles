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
            'isBanned' => 'ban_until',
        ];
    }

    protected function getReverseFieldMapping() {
        return [
            'first_name' => 'firstName',
            'last_name' => 'lastName',
            'email' => 'email',
            'id_user' => 'id',
            'is_verified' => 'isEmailVerified',
            'path_picture' => 'imgURL',
            'created_at' => 'createdAt',
            'updated_at' => 'updatedAt',
            'role.name' => 'role',
            'country.name' => 'country',
            'country.country_code' => 'countryCode',
            'city.name' => 'city',
            'postalCode.postal_code' => 'postalCode',
            'ban_until' => 'isBanned',
        ];
    }
}

