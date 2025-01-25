<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TypeProduit extends Model
{

    protected $table = 'type_products';

    //
    protected $fillable = [
        'libelle',
    ];

    public function products()
    {
        return $this->hasMany(Product::class, 'type_id');
    }
}
