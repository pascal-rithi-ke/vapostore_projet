<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    // Les attributs
    protected $fillable = [
        'name',
        'description',
        'price',
        'image',
        'type_id',
        'created_at',
        'updated_at'
    ];

    public function type()
    {
        return $this->belongsTo(TypeProduit::class);
    }
}
