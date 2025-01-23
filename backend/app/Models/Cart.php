<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Cart extends Model
{
    // Les attributs
    protected $fillable = [
        'user_id',
        'product_id',
        'quantity',
        'total',
        'price',
        'created_at',
        'updated_at'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function products()
    {
        return $this->belongsToMany(Product::class)->withPivot('quantity', 'price');
    }

    public function orders()
    {
        return $this->hasMany(Order::class);
    }
}
