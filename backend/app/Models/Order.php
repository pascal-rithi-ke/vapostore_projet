<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    protected $fillable = [
        'user_id',
        'cart_id',
        'total_price',
        'item_number',

        'address',
        'city',
        'postal_code',

        'status',
        'created_at',
        'updated_at',
    ];

    // Status constants
    const STATUS_PENDING = 'pending';
    const STATUS_COMPLETED = 'completed';
    const STATUS_CANCELLED = 'cancelled';

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function cart()
    {
        return $this->belongsTo(Cart::class);
    }

    public function products()
    {
        return $this->cart()->products();
    }
}
